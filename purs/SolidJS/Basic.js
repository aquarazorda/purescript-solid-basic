import { createComponent as _createComponent, render as _render } from 'solid-js/web';
import {
  createSignal as _createSignal,
  createEffect as _createEffect,
  createMemo as _createMemo,
  createResource as _cr,
  mergeProps,
  lazy as lzy
} from 'solid-js';

export const render = (componentFn) => (root) => () => _render(componentFn, root);

export const createComponent = (comp) => _createComponent(comp);
export const createComponent_ = (comp) => (props) => _createComponent(comp, mergeProps(props));
export const cc = (comp) => (props) => (children) => _createComponent(comp, mergeProps(props, children))

export const fragment = (children) => () => children;

export const createResource_ = (resourceFn) => {
  const [resource, mutRef] = _cr(resourceFn);

  return { value0: resource, value1: mutRef };
}

export const createSignal = (initialValue) => () => {
  const [signal, setSignal] = _createSignal(initialValue);
  return { value0: signal, value1: (val) => setSignal(val) };
};

export const createEffect = (effectFn) => () => _createEffect(effectFn);

export const createMemo = _createMemo;

export const lazy = (path) => lzy(() => import(`../../output/${path}/index.js`));

export const props = mergeProps;

export const toGetterProp = (key) => (fn) => ({
  get [key]() {
    return fn();
  }
})