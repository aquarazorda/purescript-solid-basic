module SolidJS.Basic.Router where

import Prelude
import Data.Maybe (Maybe)
import Data.UndefinedOr (UndefinedOr, fromUndefined)
import Effect (Effect)
import Prim.Row (class Union)
import Record (modify)
import Routing.Duplex (RouteDuplex', print)
import SolidJS.Basic (Accessor, Children, Component, Lazy, ModuleName, createMemo_)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type RouteData a
  = Effect (Accessor (Maybe a))

type RouteProps route compProps routeData
  = ( path :: route
    , children :: Children
    , data :: Unit -> routeData
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

foreign import lazyRoute :: forall a routeData. ModuleName -> (Unit -> routeData) -> Lazy (Component a)

foreign import useRouteData_ :: forall a. Effect (UndefinedOr a)

useRouteData :: forall a. RouteData a
useRouteData = createMemo_ (fromUndefined <$> useRouteData_)
