import { Show, createComponent, mergeProps, children } from 'solid-js';
import { Dynamic } from 'solid-js/web';

export const dynamic = (component) => (props) => (cs) =>
  createComponent(Dynamic, mergeProps({
    component,
    get children() {
      return children(() => cs)
    }
  }, props))

export const show_ = Show;