module SolidJS.Basic.Router where

import Prelude
import Effect (Effect)
import Prim.Row (class Union)
import Record (modify)
import Routing.Duplex (RouteDuplex', print)
import SolidJS.Basic (Component, Lazy, ModuleName, Resource)
import SolidJS.Basic.Types (Children)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type RouteData a
  = Effect a

type RouteProps route compProps params query routeData
  = ( path :: route
    , children :: Children
    , data :: RouteDataArgs params query routeData
    -- , matchFilters :: Maybe (MatchFilters s)
    , component :: Effect Element
    , preload :: Effect Unit
    , lazy :: Lazy (Component compProps)
    )

foreign import route_ :: forall a. Record a -> Element

type Route
  = forall attrs attrs2 route compProps params query routeData.
    Union attrs attrs2 (RouteProps route compProps params query routeData) =>
    RouteDuplex' route -> Record attrs -> Element

route :: forall a. Record a -> Element
route = route_

-- route :: Route
-- route routes props = route_ $ modify (Proxy :: Proxy "path") (unsafeCoerce $ print routes) (unsafeCoerce props)
foreign import lazyRoute :: forall a routeData params query. ModuleName -> RouteDataArgs params query routeData -> Lazy (Component a)

foreign import useRouteData :: forall a. Effect a

-- params: Params;
--     location: Location;
--     navigate: Navigator;
type RouteDataArgs params query d
  = { data :: d
    , params :: params
    , location ::
        { pathname :: String
        , search :: String
        , hash :: String
        , query :: query
        }
    , navigate ::
        { to :: String
        }
    } ->
    d

-- useRouteData :: forall a. RouteData a
-- useRouteData = createMemo_ (fromUndefined <$> useRouteData_)
