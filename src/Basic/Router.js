import { createComponent } from 'solid-js';
import { Route as Route_, useRouteData as uRD } from 'solid-start';

export const route_ = (props) => {
  if (props.lazy) {
    return createComponent(Route_, {
      path: props.path,
      component: () => createComponent(lazy(props.lazy)),
      data: async () => await props.lazy().then((m) => m.routeData())
    });
  }
  return createComponent(Route_, props);
};

export const lazyRoute = (path) => () => import(`../../output/Frontend.${path}/index.js`);

export const useRouteData = uRD;