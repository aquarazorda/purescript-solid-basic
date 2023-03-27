module SolidJS.Basic.Dom where

import SolidJS.Basic (dynamic, Children)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

text :: forall a. a -> Element
text = unsafeCoerce

div :: forall props. props -> Children -> Element
div = dynamic "div"

div_ ∷ Children -> Element
div_ children = div {} children

button ∷ forall props. props -> Children → Element
button = dynamic "button"
