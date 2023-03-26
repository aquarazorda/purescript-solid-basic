module SolidJS.Basic.Dom where

import SolidJS.Basic (dynamic)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Children
  = Array Element

text :: String -> Element
text = unsafeCoerce

div :: forall props. props -> Element
div = dynamic "div"

div_ ∷ Children -> Element
div_ children = div { children }

button ∷ ∀ (props9 ∷ Type). props9 → Element
button = dynamic "button"
