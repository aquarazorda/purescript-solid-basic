import { Show, createComponent, mergeProps } from 'solid-js';
import { Dynamic } from 'solid-js/web';

export const dynamic = (component) => (props) => (cs) => createComponent(Dynamic, mergeProps(props, {
  component,
  get children() {
    return cs
  }
}));

export const show_ = (props) => createComponent(Show, mergeProps(props, {
  get children() {
    if (typeof props.children === 'function') {
      return (v) => {
        return props.children(typeof v === 'function' ? v() : v) || null
      };
    }
    return props.children || null;
  },
  get when() {
    if (typeof props.when === 'function') {
      return props.when() || false;
    }
    return props.when || false;
  }
}));

export const toUndefined_ = (isJust) => (maybe) => {
  return isJust(maybe) ? maybe.value0 : undefined;
};