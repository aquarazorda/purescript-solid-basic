import { createComponent, lazy } from 'solid-js';
import { Route as Route_, useRouteData as uRD } from 'solid-start';

export const route_ = (props) => {
  if (props.lazy) {
    return createComponent(Route_, {
      path: props.path,
      component: lazy(() => props.lazy.component),
      data: props.lazy.data
    });
  }

  return createComponent(Route_, {
    path: props.path,
    component: props.component,
    data: props.data
  });
};

export const lazyRoute = (path) => (dataFn) => {
  return ({
    component: import(`../../output/Frontend.Routes.${path}/index.js`),
    data: dataFn?.value0 ? dataFn?.value0 : empty
  });
}

export const useRouteData_ = uRD;