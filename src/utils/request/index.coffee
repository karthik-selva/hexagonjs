import logger from 'utils/logger'
import { identity, isArray, isFunction, isObject, isString, merge } from 'utils/utils'
import { parseHTML } from 'utils/dom-utils'

deprecatedWarning = (fn) => logger.deprecated(fn, 'fetch (native browser function) - https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API')

respondToRequest = (request, url, data, callback, options, index) ->
  status = request.status

  source = if data? then {url:url, data:data} else url

  if status >= 200 and status < 300 or status is 304
    try
      result = options.formatter request
    catch e
      callback e, undefined, source, index
      return
    callback undefined, result, source, index
  else
    callback request, undefined, source, index
  return

sendRequest = (request, url, data, options) ->
  request.open options.requestType, url, true

  for header, value of options.headers
    request.setRequestHeader header, value

  if options.responseType then request.responseType = options.responseType
  if options.contentType then request.overrideMimeType options.contentType

  sendData = if data? and typeof data isnt 'string' then JSON.stringify(data) else data

  request.send sendData

performRequest = (url, data = null, callback, options = {}, index) ->
  defaults =
    requestType: 'GET'
    formatter: identity
    headers: {}

  options = merge defaults, options

  if options.contentType
    options.headers['Content-Type'] ?= options.contentType
    options.headers['accept'] ?= options.contentType + ',*/*'

  if options.requestType is 'GET' and data
    options.requestType = 'POST'

  request = new XMLHttpRequest()

  respond = ->
    respondToRequest(request, url, data, callback, options, index)

  request.onload = request.onerror = respond
  sendRequest(request, url, data, options)


hx_xhr = (urlType, urls, data, callback, options) ->
  if urlType is 'array'
    resultArr = []

    buildResultArr = (error, result, source, index) ->
      resultArr[index] = {data: result, source: source}
      callback(error, result, source, index)
      if resultArr.filter((d) -> d isnt undefined).length is urls.length
        resultSource = resultArr.map((d) -> d.source)
        resultData = resultArr.map((d) -> d.data)
        callback(error, resultData, resultSource, -1)

    for url, i in urls
      if isObject(url)
        data = url.data or data
        url = url.url
      performRequest url, data, buildResultArr, options, i
  else
    if urlType is 'object'
      data = urls.data or data
      url = urls.url
    else
      url = urls
    performRequest url, data, callback, options

standardRequest = -> # url, callback, options || url, data, callback, options
  urls = arguments[0]

  urlType = switch
    when isArray(urls) then 'array'
    when isObject(urls) then 'object'
    when isString(urls) then 'string'

  if not urlType or urlType is 'array' and urls.length is 0
    console.error('Incorrect URL passed into request: ', urls)
    return

  if isFunction(arguments[1])
    callback = arguments[1]
    options = arguments[2]
  else
    data = arguments[1]
    callback = arguments[2]
    options = arguments[3]

  hx_xhr urlType, urls, data or null, callback, options

export request = ->
  deprecatedWarning('request')
  standardRequest.apply(null, arguments)

parsers =
  'application/json': (text) -> if text then JSON.parse text
  'text/html': (text) -> parseHTML.call(request, text)
  'text/plain': (text) -> text

reshapedRequest = (type) ->
  fn = switch type
    when 'application/json' then 'hx.json'
    when 'text/html' then 'hx.html'
    when 'text/plain' then 'hx.text'
    when undefined then 'hx.reshapedRequest'

  (urls, data, callback, options) ->
    deprecatedWarning(fn)
    [data, callback, options] = [undefined, data, callback] if isFunction data

    defaults = if type
      contentType: type
      formatter: (xhr) -> parsers[type](xhr.responseText)
    else
      formatter: (xhr) ->
        [mimeType] = xhr.getResponseHeader 'content-type'
          .split ';'
        parser = parsers[mimeType]
        if parser
          parser xhr.responseText
        else
          logger.warn "Unknown parser for mime type #{mimeType}, carrying on anyway"
          xhr

    options = merge defaults, options
    standardRequest urls, data, callback, options

export json = reshapedRequest('application/json')
export html = reshapedRequest('text/html')
export text = reshapedRequest('text/plain')
export reshapedRequest = reshapedRequest()
