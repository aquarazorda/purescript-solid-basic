import { createComponent, lazy } from 'solid-js';
import { Route as Route_, useRouteData as uRD } from 'solid-start';

export const route_ = (props) => {
  if (props.lazy) {
    if (props.lazy.data) {
      // console.log(props.lazy.data())
    }
    return createComponent(Route_, {
      path: props.path,
      component: () => createComponent(lazy(props.lazy.component)),
      data: props.lazy.data
    });
  }
  return createComponent(Route_, props);
};

export const lazyRoute = (path) => (dataFn) => ({
  component: () => import(`../../output/Frontend.Routes.${path}/index.js`),
  data: dataFn?.value0 || undefined 
});

export const useRouteData = uRD;