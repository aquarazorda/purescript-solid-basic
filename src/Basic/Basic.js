import { createComponent as _createComponent, Dynamic, render as _render } from 'solid-js/web';
import { 
  createSignal as _createSignal, 
  createEffect as _createEffect, 
  createMemo as _createMemo, 
  mergeProps,
} from 'solid-js';

export const render = (componentFn) => (root) => () => _render(componentFn, root);

export const createComponent = (comp) => (props) => _createComponent(comp, props);

export const createSignal = (initialValue) => () => {
  const [signal, setSignal] = _createSignal(initialValue);
  return {value0: signal, value1: (val) => setSignal(val)};
};

export const createEffect = (effectFn) => () => _createEffect(() => effectFn()());

export const createMemo = (memoFn) => _createMemo(() => memoFn());

export const dynamic = (component) => (props) => 
  _createComponent(Dynamic, mergeProps({ component }, props))