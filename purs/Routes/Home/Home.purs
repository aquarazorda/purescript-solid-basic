module Frontend.Routes.Home (default) where

import Prelude hiding (div, show)
import Data.Tuple.Nested ((/\))
import SolidJS.Basic (Component, Resource, createComponent)
import SolidJS.Basic.Dom (div, showMaybe, text)
import SolidJS.Basic.Router (useRouteData)

default ∷ Component {}
default =
  createComponent \_ -> do
    (d /\ _) <- useRouteData :: Resource { title :: String }
    pure
      $ div { className: "flex justify-center" }
          [ showMaybe d (text "Loading...") (\{ title } -> text title)
          ]
