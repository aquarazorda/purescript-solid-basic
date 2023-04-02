module Frontend.Routes.About where

import SolidJS.Basic (Component)
import SolidJS.Basic.Dom (div, text)

default :: Component {}
default _ =
  div { className: "flex justify-center" } \_ ->
    [ text "About"
    ]
