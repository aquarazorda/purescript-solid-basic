import { Dynamic, createComponent as _createComponent, render as _render } from 'solid-js/web';
import {
  createSignal as _createSignal,
  createEffect as _createEffect,
  createMemo as _createMemo,
  createResource as _cr,
  lazy as lzy,
  mergeProps
} from 'solid-js';

export const transformObject = (obj, children) => {
  if (obj) {
    for (const [key, value] of Object.entries(obj)) {
      if (typeof value === "object" && value.hasOwnProperty("memo") && typeof value.memo === "function") {
        Object.defineProperty(obj, key, {
          get: value.memo,
        });
      }
    }
  }

  return mergeProps(obj, { children });
}

export const render = (componentFn) => (root) => () => _render(componentFn, root);

export const dynamic = (component) => (props) => (children) => _createComponent(Dynamic, transformObject({ ...props, component }, children));

export const createComponent = (comp) => (props) => _createComponent(comp, transformObject(props));
export const createComponent_ = (comp) => _createComponent(comp);

export const createComponentChildren = (comp) => (props) => (children) => {
  // console.log(comp, props, children);
  return _createComponent(comp, transformObject(props, children))
};

export const createResource_ = (resourceFn) => {
  const [resource, mutRef] = _cr(resourceFn);

  return { value0: resource, value1: mutRef };
}

export const createResourceWithSource = (source) => (resourceFn) => {
  const [resource, mutRef] = _cr(source, resourceFn);

  return { value0: resource, value1: mutRef };
}

export const createSignal = (initialValue) => () => {
  const [signal, setSignal] = _createSignal(initialValue);
  return { value0: signal, value1: (val) => setSignal(val) };
};

export const createEffect = (effectFn) => () => _createEffect(effectFn);

export const lazy = (path) => lzy(() => import(`../../output/${path}/index.js`));

export const toGetterProp = (key) => (fn) => ({
  get [key]() {
    return fn();
  }
})