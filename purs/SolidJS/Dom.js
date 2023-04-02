import { Show, createComponent, mergeProps } from 'solid-js';
import { Dynamic } from 'solid-js/web';

export const dynamic = (component) => (props) => (children) => 
createComponent(Dynamic, mergeProps(props, { component }, children));

export const show = (when) => (fallback) => (children) => createComponent(Show, {
  fallback,
  get children() {
    if (typeof children === 'function') {
      return (v) => {
        console.log("123", v());
        return children(typeof v === 'function' ? v() : v) || null
      };
    }
    return children || null;
  },
  get when() {
    if (typeof when === 'function') {
      return when() || false;
    }
    return when || false;
  }
});

export const toUndefined_ = (isJust) => (maybe) => {
  return isJust(maybe) ? maybe.value0 : undefined;
};