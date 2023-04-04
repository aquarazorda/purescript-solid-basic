import { createComponent, lazy, mergeProps } from 'solid-js';
import { Route as Route_, useRouteData as uRD, useRoutes as uR } from 'solid-start';

export const route_ = (props) => {
  if (props.lazy) {
    return createComponent(Route_, mergeProps(props, {
      component: (ps) => createComponent(lazy(props.lazy.component), ps),
      data: props.lazy.data
    }));
  }
  return createComponent(Route_, mergeProps(props));
};

export const lazyRoute = (path) => (dataFn) => {
  return ({
    component: () => import(`../../output/Frontend.Routes.${path}/index.js`),
    data: dataFn
  });
}

export const useRoutes = uR;

export const useRouteData = uRD;