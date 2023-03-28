module Frontend.Home (default, routeData) where

import Prelude hiding (div)
import Data.Tuple.Nested ((/\))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Console (logShow)
import Fetch (Method(..), fetch)
import Foreign (Foreign)
import SolidJS.Basic (Accessor, Component, access, createComponent, createResource)
import SolidJS.Basic.Dom (div, text)
import SolidJS.Basic.Router (useRouteData)

routeData :: Unit -> Aff (Accessor Foreign)
routeData _ = do
  (d /\ _) <-
    createResource
      $ fetch "https://jsonplaceholder.typicode.com/todos/1"
          { method: GET
          }
  pure d

default ∷ Component {}
default =
  createComponent \_ -> do
    d <- useRouteData :: Effect (Accessor String)
    -- logShow $ access d
    pure
      $ div { className: "flex justify-center" }
          [ text "Home"
          ]
