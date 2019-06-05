import { div, datePicker } from 'hexagon-js';

export default () => [
  datePicker(),
  div(),
  datePicker({
    selectRange: true,
  }),
  div(),
  datePicker({
    date: new Date(Date.UTC(2019, 4, 22, 0, 20)),
  }),
  div(),
  datePicker({
    date: new Date(Date.UTC(2019, 4, 22, 0, 20)),
    featureFlags: {
      useTrueDate: true,
    },
  }),
  div(),
  datePicker({
    selectRange: true,
    range: {
      start: new Date(Date.UTC(2019, 4, 22, 0, 20)),
      end: new Date(Date.UTC(2019, 4, 24, 0, 20)),
    },
  }),
  div(),
  datePicker({
    selectRange: true,
    range: {
      start: new Date(Date.UTC(2019, 4, 22, 0, 20)),
      end: new Date(Date.UTC(2019, 4, 24, 0, 20)),
    },
    featureFlags: {
      useTrueDate: true,
    },
  }),
];
