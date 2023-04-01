module Frontend.Routes.About where

import Prelude (($))
import SolidJS.Basic (Component, children)
import SolidJS.Basic.Dom (div, text)

default :: Component {}
default _ =
  div { className: "flex justify-center" }
    $ children \_ ->
        [ text "About"
        ]
