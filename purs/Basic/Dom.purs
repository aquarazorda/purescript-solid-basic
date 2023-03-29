module SolidJS.Basic.Dom where

import Data.Maybe (Maybe, isJust)
import Foreign (Foreign)
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

showMaybe :: forall a. { when :: Maybe a, fallback :: Element } -> Array ((a -> Element)) -> Element
showMaybe props = dynamic show_ props { when = isJust props.when }

showAccessor :: forall a. { when :: Accessor (Maybe a), fallback :: Element } -> (a -> Element) -> Element
showAccessor = dynamic show_
