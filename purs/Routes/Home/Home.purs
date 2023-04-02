module Frontend.Routes.Home (default) where

import Prelude hiding (div, show)
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Data.UndefinedOr (fromUndefined, isUndefined)
import Foreign (Foreign)
import Frontend.Routes.Home.Data (homeRouteData)
import SolidJS.Basic (Accessor, Component, Resource, access, access_, createComponent, createMemo, createSignal)
import SolidJS.Basic.Dom (button, div, show, showAccessorMaybe, text)
import SolidJS.Basic.Query (QueryReturn)
import SolidJS.Basic.Router (RouteData, useRouteData)
import SolidJS.Basic.Start (suspense)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type ResourceData
  = Resource { title :: String }

showContent :: { title :: String } -> Element
showContent { title } = text title

default ∷ Component {}
default _ =
  createComponent do
    qr /\ _ <- useRouteData :: RouteData ResourceData
    count /\ setCount <- createSignal 0
    pure
      $ div
          { className: "flex justify-center" } \_ ->
          -- [ show (isUndefined qr.data) (text "No data...") \{ title } -> text title ]
          [ showAccessorMaybe (fromUndefined <$> qr) (text "No data..") showContent
          , button { onClick: \_ -> setCount $ access_ count + 1 } \_ -> [ text count ]
          ]
