module SolidJS.Basic.Dom where

import Prelude hiding (div)
import Data.Maybe (Maybe, isJust)
import Data.UndefinedOr (UndefinedOr)
import SolidJS.Basic (Accessor, Children)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

foreign import dynamic :: forall props children. String -> props -> children -> Element

text :: forall a. a -> Element
text = unsafeCoerce

div :: forall props. props -> Children -> Element
div = dynamic "div"

div_ ∷ Children -> Element
div_ children = div {} children

button ∷ forall props. props -> Children → Element
button = dynamic "button"

foreign import show_ :: String

show :: forall a. Accessor a -> Element -> Element -> Element
show when fallback = dynamic show_ { when, fallback }

foreign import toUndefined_ :: forall a. (Maybe a -> Boolean) -> Maybe a -> UndefinedOr a

toUndefined :: forall a. Maybe a -> UndefinedOr a
toUndefined = toUndefined_ isJust

showMaybe :: forall a. Accessor (Maybe a) -> Element -> (a -> Element) -> Element
showMaybe when fallback = dynamic show_ { when: toUndefined <$> when, fallback }
