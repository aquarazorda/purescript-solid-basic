module Frontend.Routes.Home (default) where

import Prelude hiding (div, show)
import Data.Tuple.Nested ((/\))
import SolidJS.Basic (Component, Resource, createComponent)
import SolidJS.Basic.Dom (div, showAccessorMaybe, text)
import SolidJS.Basic.Router (RouteData, useRouteData)
import SolidJS.Basic.Start (suspense)

type ResourceData
  = Resource { title :: String }

default ∷ Component {}
default _ =
  createComponent do
    routeData /\ _ <- useRouteData :: RouteData ResourceData
    pure
      $ suspense {} \_ ->
          [ div
              { className: "flex justify-center" } \_ ->
              [ showAccessorMaybe routeData (text "No data...") \{ title } -> text title
              ]
          ]
