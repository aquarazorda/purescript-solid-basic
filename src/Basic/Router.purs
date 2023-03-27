module SolidJS.Basic.Router where

import Prelude
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Foreign (Foreign)
import Foreign.Object (Object, update)
import Foreign.Object.Unsafe (unsafeIndex)
import Prim.Row (class Union)
import Record (modify)
import Routing.Duplex (RouteDuplex', print)
import SolidJS.Basic (Component, Children)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type RouteProps route compProps
  = ( path :: route
    , children :: Children
    -- , data :: RouteDataFunc
    -- , matchFilters :: Maybe (MatchFilters s)
    , component :: Component compProps
    , preload :: Effect Unit
    )

foreign import route_ :: forall a. Record a -> Element

route ::
  forall attrs attrs2 route compProps.
  Union attrs attrs2 (RouteProps route compProps) =>
  RouteDuplex' route -> Record attrs -> Element
route routes props = route_ $ modify (Proxy :: Proxy "path") (unsafeCoerce $ print routes) (unsafeCoerce props)
