module Frontend.Home where

import Prelude hiding (div)
import SolidJS.Basic (Component)
import SolidJS.Basic.Dom (div, text)

default ∷ Component {}
default _ =
  div { className: "flex justify-center" }
    [ text "Home"
    ]
