module SolidJS.Basic.Router where

import Prelude
import Effect (Effect)
import Effect.Aff (Aff)
import Prim.Row (class Union)
import Record (modify)
import Routing.Duplex (RouteDuplex', print)
import SolidJS.Basic (Children, Component, Lazy, ModuleName)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type RouteProps route compProps routeData
  = ( path :: route
    , children :: Children
    , data :: Aff routeData
    -- , matchFilters :: Maybe (MatchFilters s)
    , component :: Component compProps
    , preload :: Effect Unit
    , lazy :: Lazy (Component compProps)
    )

foreign import route_ :: forall a. Record a -> Element

route ::
  forall attrs attrs2 route compProps routeData.
  Union attrs attrs2 (RouteProps route compProps routeData) =>
  RouteDuplex' route -> Record attrs -> Element
route routes props = route_ $ modify (Proxy :: Proxy "path") (unsafeCoerce $ print routes) (unsafeCoerce props)

foreign import lazyRoute :: forall a. ModuleName -> Lazy (Component a)

foreign import useRouteData :: forall a. Effect a
