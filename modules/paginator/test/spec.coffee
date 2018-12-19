describe 'hx-paginator', ->



  describe 'getPageItems', () ->
    getPageItems = hx._.paginator.getPageItems

    runTest = (expectation, currentPage, pageCount) ->
      it "page: #{currentPage}, pageCount: #{pageCount} => #{expectation}", () ->
        getPageItems(currentPage, pageCount, 2).join(' ').should.equal(expectation)

    runTest('1~ 2 3 4 5 ... 100 next', 1, 100)
    runTest('prev 1 2 3~ 4 5 ... 100 next', 3, 100)
    runTest('prev 1 ... 13 14 15~ 16 17 ... 100 next', 15, 100)
    runTest('prev 1 ... 96~ 97 98 99 100 next', 96, 100)
    runTest('prev 1 ... 96 97 98 99 100~', 100, 100)

    runTest('1~', undefined, 1)
    runTest('1~', 1, 1)

    runTest('1~ 2 next', undefined, 2)
    runTest('1~ 2 next', 1, 2)
    runTest('prev 1 2~', 2, 2)

    runTest('1~ 2 3 next', undefined, 3)
    runTest('1~ 2 3 next', 1, 3)
    runTest('prev 1 2~ 3 next', 2, 3)
    runTest('prev 1 2 3~', 3, 3)

    runTest('1~ 2 3 4 next', undefined, 4)
    runTest('1~ 2 3 4 next', 1, 4)
    runTest('prev 1 2~ 3 4 next', 2, 4)
    runTest('prev 1 2 3~ 4 next', 3, 4)
    runTest('prev 1 2 3 4~', 4, 4)

    runTest('1~ 2 3 4 5 next', undefined, 5)
    runTest('1~ 2 3 4 5 next', 1, 5)
    runTest('prev 1 2~ 3 4 5 next', 2, 5)
    runTest('prev 1 2 3~ 4 5 next', 3, 5)
    runTest('prev 1 2 3 4~ 5 next', 4, 5)
    runTest('prev 1 2 3 4 5~', 5, 5)

    runTest('1~ 2 3 4 5 6 next', undefined, 6)
    runTest('1~ 2 3 4 5 6 next', 1, 6)
    runTest('prev 1 2~ 3 4 5 6 next', 2, 6)
    runTest('prev 1 2 3~ 4 5 6 next', 3, 6)
    runTest('prev 1 2 3 4~ 5 6 next', 4, 6)
    runTest('prev 1 2 3 4 5~ 6 next', 5, 6)
    runTest('prev 1 2 3 4 5 6~', 6, 6)

    runTest('1~ 2 3 4 5 6 7 next', undefined, 7)
    runTest('1~ 2 3 4 5 6 7 next', 1, 7)
    runTest('prev 1 2~ 3 4 5 6 7 next', 2, 7)
    runTest('prev 1 2 3~ 4 5 6 7 next', 3, 7)
    runTest('prev 1 2 3 4~ 5 6 7 next', 4, 7)
    runTest('prev 1 2 3 4 5~ 6 7 next', 5, 7)
    runTest('prev 1 2 3 4 5 6~ 7 next', 6, 7)
    runTest('prev 1 2 3 4 5 6 7~', 7, 7)

    runTest('1~ 2 3 4 5 ... 8 next', undefined, 8)
    runTest('1~ 2 3 4 5 ... 8 next', 1, 8)
    runTest('prev 1 2~ 3 4 5 ... 8 next', 2, 8)
    runTest('prev 1 2 3~ 4 5 ... 8 next', 3, 8)
    runTest('prev 1 2 3 4~ 5 ... 8 next', 4, 8)
    runTest('prev 1 ... 4 5~ 6 7 8 next', 5, 8)
    runTest('prev 1 ... 4 5 6~ 7 8 next', 6, 8)
    runTest('prev 1 ... 4 5 6 7~ 8 next', 7, 8)
    runTest('prev 1 ... 4 5 6 7 8~', 8, 8)

    runTest('1~ 2 3 4 5 ... 9 next', undefined, 9)
    runTest('1~ 2 3 4 5 ... 9 next', 1, 9)
    runTest('prev 1 2~ 3 4 5 ... 9 next', 2, 9)
    runTest('prev 1 2 3~ 4 5 ... 9 next', 3, 9)
    runTest('prev 1 2 3 4~ 5 ... 9 next', 4, 9)
    runTest('prev 1 ... 5~ 6 7 8 9 next', 5, 9)
    runTest('prev 1 ... 5 6~ 7 8 9 next', 6, 9)
    runTest('prev 1 ... 5 6 7~ 8 9 next', 7, 9)
    runTest('prev 1 ... 5 6 7 8~ 9 next', 8, 9)
    runTest('prev 1 ... 5 6 7 8 9~', 9, 9)

    runTest('1~ 2 3 4 5 ... 10 next', undefined, 10)
    runTest('1~ 2 3 4 5 ... 10 next', 1, 10)
    runTest('prev 1 2~ 3 4 5 ... 10 next', 2, 10)
    runTest('prev 1 2 3~ 4 5 ... 10 next', 3, 10)
    runTest('prev 1 2 3 4~ 5 ... 10 next', 4, 10)
    runTest('prev 1 2 3 4 5~ ... 10 next', 5, 10)
    runTest('prev 1 ... 6~ 7 8 9 10 next', 6, 10)
    runTest('prev 1 ... 6 7~ 8 9 10 next', 7, 10)
    runTest('prev 1 ... 6 7 8~ 9 10 next', 8, 10)
    runTest('prev 1 ... 6 7 8 9~ 10 next', 9, 10)
    runTest('prev 1 ... 6 7 8 9 10~', 10, 10)

    runTest('1~ 2 3 4 5 ... 11 next', undefined, 11)
    runTest('1~ 2 3 4 5 ... 11 next', 1, 11)
    runTest('prev 1 2~ 3 4 5 ... 11 next', 2, 11)
    runTest('prev 1 2 3~ 4 5 ... 11 next', 3, 11)
    runTest('prev 1 2 3 4~ 5 ... 11 next', 4, 11)
    runTest('prev 1 2 3 4 5~ ... 11 next', 5, 11)
    runTest('prev 1 ... 4 5 6~ 7 8 ... 11 next', 6, 11)
    runTest('prev 1 ... 7~ 8 9 10 11 next', 7, 11)
    runTest('prev 1 ... 7 8~ 9 10 11 next', 8, 11)
    runTest('prev 1 ... 7 8 9~ 10 11 next', 9, 11)
    runTest('prev 1 ... 7 8 9 10~ 11 next', 10, 11)
    runTest('prev 1 ... 7 8 9 10 11~', 11, 11)

