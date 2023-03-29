import { Show, createComponent, mergeProps } from 'solid-js';
import { Dynamic } from 'solid-js/web';

export const dynamic = (component) => (props) => (cs) => {
  return createComponent(Dynamic, mergeProps(props, {
    component,
    get children() {
      return cs
    }
  }));
}

export const show_ = (props) => createComponent(Show, mergeProps(props, {
  get when() {
    return props.when()
  }
}));

export const toUndefined_ = (isJust) => (maybe) => isJust(maybe) ? maybe.value0 : undefined;