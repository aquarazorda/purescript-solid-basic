module Frontend.Routes.Home (default) where

import Prelude hiding (div, show)
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Prelude (show)
import SolidJS.Basic (Accessor, Component, Resource, access, createComponent, createEffect, createMemo, toElement)
import SolidJS.Basic.Dom (div, showMaybe, text)
import SolidJS.Basic.Router (useRouteData)

default ∷ Component {}
default =
  createComponent \_ -> do
    (d /\ _) <- useRouteData :: Resource { title :: String }
    pure
      $ div { className: "flex justify-center" }
          [ toElement
              $ access
                  ( case _ of
                      Just { title } -> title
                      Nothing -> "No title"
                  )
                  d
          ]
