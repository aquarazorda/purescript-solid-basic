import { Show, createComponent, mergeProps } from 'solid-js';
import { Dynamic } from 'solid-js/web';

export const dynamic = (component) => (props) => (cs) => {
  return createComponent(Dynamic, mergeProps(props, {
    component,
    get children() {
      return cs
      // return cs?.map?.(item => (typeof item === 'function') ? children(item) : item) || cs
    }
  }));
}

export const show_ = (props) => createComponent(Show, mergeProps(props, {
  get children() {
    if (typeof props.children === 'function') {
      return (v) => props.children(v()) || null;
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