import { createComponent } from 'solid-js';
import { Route as Route_ } from 'solid-start';

export const route_ = (props) => {
  console.log(props);
  return createComponent(Route_, props);
};