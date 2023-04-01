module SolidJS.Basic.Router where

import Prelude
import Effect (Effect)
import Prim.Row (class Union)
import Record (modify)
import Routing.Duplex (RouteDuplex', print)
import SolidJS.Basic (Children, Component, Lazy, ModuleName)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type RouteData a
  = Effect a

type RouteProps route compProps routeData
  = ( path :: route
    , children :: Children
    , data :: Unit -> routeData
    -- , matchFilters :: Maybe (MatchFilters s)
    , component :: Effect Element
    , preload :: Effect Unit
    , lazy :: Lazy (Component compProps)
    )

foreign import route_ :: forall a. Record a -> Element

type Route
  = forall attrs attrs2 route compProps routeData.
    Union attrs attrs2 (RouteProps route compProps routeData) =>
    RouteDuplex' route -> Record attrs -> Element

-- route :: forall a. Record a -> Element
-- route = route_
route :: Route
route routes props = route_ $ modify (Proxy :: Proxy "path") (unsafeCoerce $ print routes) (unsafeCoerce props)

foreign import lazyRoute :: forall a routeData. ModuleName -> (Unit -> routeData) -> Lazy (Component a)

foreign import useRouteData :: forall a. Effect a

-- useRouteData :: forall a. RouteData a
-- useRouteData = createMemo_ (fromUndefined <$> useRouteData_)
