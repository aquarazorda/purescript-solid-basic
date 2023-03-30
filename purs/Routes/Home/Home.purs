module Frontend.Routes.Home (default) where

import Prelude hiding (div, show)
import Data.Tuple.Nested ((/\))
import SolidJS.Basic (Component, Resource, createComponent)
import SolidJS.Basic.Dom (div, showAccessorMaybe, showMaybe, text)
import SolidJS.Basic.Router (RouteData, useRouteData)
import Web.DOM (Element)

type ResourceData
  = Resource { title :: String }

default ∷ Component {}
default =
  createComponent \_ -> do
    d <- useRouteData :: RouteData ResourceData
    let
      showContent :: ResourceData -> Element
      showContent (m /\ _) = showAccessorMaybe m (text "Loading...") \{ title } -> text title
    pure
      $ div { className: "flex justify-center" }
          [ showMaybe d (text "No route data provided") showContent
          ]
