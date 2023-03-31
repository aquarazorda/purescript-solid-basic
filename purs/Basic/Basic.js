import { createComponent as _createComponent, Dynamic, render as _render } from 'solid-js/web';
import {
  createSignal as _createSignal,
  createEffect as _createEffect,
  createMemo as _createMemo,
  createResource as _cr,
  mergeProps,
  lazy as lzy
} from 'solid-js';

export const render = (componentFn) => (root) => () => _render(componentFn, root);

export const createComponent = (comp) => () => _createComponent(comp);
export const createComponent_ = (comp) => (props) => () => _createComponent(comp, mergeProps({}, props));

export const fragment = (children) => () => children;

export const createResource_ = (nothing) => (resourceFn) => {
  const [resource, mutRef] = _cr(resourceFn, {
    initialValue: nothing
  });
  
  return { value0: resource, value1: mutRef };
}

export const createSignal = (initialValue) => () => {
  const [signal, setSignal] = _createSignal(initialValue);
  return { value0: signal, value1: (val) => setSignal(val) };
};

export const createEffect = (effectFn) => () => _createEffect(effectFn);

export const createMemo = (memoFn) => _createMemo(memoFn);
export const createMemo_ = (memoFn) => () => _createMemo(memoFn);

export const lazy = (path) => lzy(() => import(`../../output/Frontend.${path}/index.js`));
