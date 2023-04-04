import { Show, createComponent, For } from 'solid-js';

export const show = (when) => (fallback) => (children) => createComponent(Show, {
  fallback,
  get children() {
    if (typeof children === 'function') {
      return (v) => children(typeof v === 'function' ? v() : v) || null;
    }
    if (children.children) {
      return children.children;
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

export const forEach = (each) => (fallback) => (children) => createComponent(For, {
  get each() {
    return typeof each === 'function' ? each() : each;
  },
  get fallback() {
    return fallback || null;
  },
  children
})

export const toUndefined_ = (isJust) => (maybe) => {
  return isJust(maybe) ? maybe.value0 : undefined;
};