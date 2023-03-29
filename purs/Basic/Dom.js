import { Show, createComponent, mergeProps, children } from 'solid-js';
import { Dynamic } from 'solid-js/web';

export const dynamic = (component) => (props) => (cs) =>
  createComponent(Dynamic, mergeProps(props, {
    component,
    get when() {
      return props?.when?.()
    },
    get children() {
      return cs
    }
  }))

export const show_ = Show;

export const toUndefined_ = (isJust) => (maybe) => isJust(maybe) ? maybe.value0 : undefined;