module Frontend.Routes.Home (default) where

import Prelude hiding (div, show)
import Data.Tuple.Nested ((/\))
import SolidJS.Basic (Component, Resource, createComponent)
import SolidJS.Basic.Dom (div, showAccessorMaybe, text)
import SolidJS.Basic.Router (RouteData, useRouteData)
import SolidJS.Basic.Start (suspense)
import Web.DOM (Element)

type ResourceData
  = Resource { title :: String }

default ∷ Component {}
default _ =
  createComponent do
    routeData <- useRouteData :: RouteData ResourceData
    let
      showContent :: ResourceData -> Element
      showContent (m /\ _) = showAccessorMaybe m (text "No data...") \{ title } -> text title
    pure
      $ suspense (text "Loading...")
          [ div { className: "flex justify-center" }
              [ showAccessorMaybe routeData (text "No route data provided") showContent
              ]
          ]
