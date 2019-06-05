import {
  detached, div, button, span, Form,
} from 'hexagon-js';

export default () => {
  const theForm = div();
  new Form(theForm)
    .addText('Text', { required: true, placeholder: 'Name' })
    .addText('Text with Autocomplete', { required: true, placeholder: 'Name', autocompleteData: [1, 2, 3] })
    .addTextArea('Text Area', { placeholder: 'Name' })
    .addEmail('Email', { required: true, placeholder: 'your.name@ocado.com' })
    .addUrl('Url', { placeholder: 'http://www.example.co.uk/' }) // Allows blank or valid URL (with http:// prefix)
    .addNumber('Number', { required: true })
    .addCheckbox('Checkbox')
    .addCheckbox('Checkbox', { required: true })
    .addPassword('Password')
    .addPassword('Password', { required: true })
    .addRadio('Radio', ['One', 'Two', 'Three'])
    .addRadio('Radio', ['One', 'Two', 'Three'], { required: true })
    .addPicker('Picker', ['red', 'green', 'blue'])
    .addPicker('Picker', ['red', 'green', 'blue'], { required: true })
    .addTagInput('Tag Input')
    .addTagInput('Tag Input', { required: true })
    .addTagInput('Tag Input', {
      required: true,
      tagInputOptions: {
        validator: (name) => {
          if (!Number.isNaN(Number(name))) {
            return 'Please enter text';
          }
          return false;
        },
      },
    })
    .addFileInput('File Input')
    .addFileInput('File Input', { required: true })
    .addDatePicker('Date Picker')
    .addDatePicker('Date Picker', { required: true })
    .addTimePicker('Time Picker')
    .addTimePicker('Time Picker', { required: true })
    .addDateTimePicker('Date Time Picker')
    .addDateTimePicker('Date Time Picker', { required: true })
    .addAutocompletePicker('Autocomplete Picker', ['a', 'b', 'c'])
    .addAutocompletePicker('Autocomplete Picker', ['a', 'b', 'c'], { required: true })
    .addSubmit('Submit', 'fa fa-check')
    .on('submit', (data) => { console.log(data); });

  return [
    detached('form').class('hx-form')
      .add(div()
        .add(detached('label').text('Text'))
        .add(detached('input').attr('type', 'text')))
      .add(div()
        .add(detached('label').text('Email'))
        .add(detached('input').attr('type', 'email')))
      .add(div()
        .add(detached('label').text('Number'))
        .add(detached('input').attr('type', 'number')))
      .add(div()
        .add(detached('label').text('Url'))
        .add(detached('input').attr('type', 'url')))
      .add(div()
        .add(detached('label').text('Radio'))
        .add(div().attr('id', 'group-1')
          .add(div()
            .add(detached('input').attr('id', 'radio1').attr('type', 'radio').attr('value', 'One')
              .attr('name', 'group-1'))
            .add(detached('label').attr('for', 'radio1').text('One')))
          .add(div()
            .add(detached('input').attr('id', 'radio2').attr('type', 'radio').attr('value', 'Two')
              .attr('name', 'group-1'))
            .add(detached('label').attr('for', 'radio2').text('Two')))
          .add(div()
            .add(detached('input').attr('id', 'radio3').attr('type', 'radio').attr('value', 'Three')
              .attr('name', 'group-1'))
            .add(detached('label').attr('for', 'radio3').text('Three')))))
      .add(div()
        .add(detached('label').attr('for', 'checkbox1').text('Checkbox'))
        .add(detached('input').attr('id', 'checkbox1').attr('type', 'checkbox')))
      // .add(div()
      //   .add(detached('label').text('Tag Input'))
      //   .add(div()
      //     .add(tagInput())))
      .add(button('hx-btn hx-positive').attr('type', 'submit')
        .add(detached('i').class('fa fa-paper-plane'))
        .add(span().text(' Submit'))),
    detached('br'),
    theForm,
  ];
};
