module SolidJS.Basic.Dom where

import Data.Maybe (Maybe, isJust)
import Data.UndefinedOr (UndefinedOr)
import SolidJS.Basic (Component, dynamic)
import SolidJS.Basic.Signals (Accessor)
import SolidJS.Basic.Types (Element, Children)
import Unsafe.Coerce (unsafeCoerce)

type Fallback
  = Element

text :: forall a. a -> Element
text = unsafeCoerce

div :: forall props. props -> Children -> Element
div = dynamic "div"

div_ ∷ Children -> Element
div_ children = div [] children

button ∷ forall props. props -> Children → Element
button = dynamic "button"

header ∷ forall props. props -> Children → Element
header = dynamic "header"

nav ∷ forall props. props -> Children → Element
nav = dynamic "nav"

a ∷ forall props. props -> Children → Element
a = dynamic "a"

strong ∷ forall props. props -> Children → Element
strong = dynamic "strong"

ul ∷ forall props. props -> Children → Element
ul = dynamic "ul"

li ∷ forall props. props -> Children → Element
li = dynamic "li"

span ∷ forall props. props -> Children → Element
span = dynamic "span"

main ∷ forall props. props -> Children → Element
main = dynamic "main"

br ∷ forall props. props -> Element
br _ = dynamic "br" [] []

foreign import show :: forall when when_. when -> Fallback -> (when_ -> Element) -> Element

show_ :: forall when. when -> Fallback -> Children -> Element
show_ = unsafeCoerce show

-- showAccessorMaybe :: forall a. Accessor (Maybe a) -> Fallback -> (a -> Element) -> Element
-- showAccessorMaybe when fb render =
--   createComponent do
--     pure $ show (toUndefined <$> when) fb render
foreign import forEach :: forall a. Accessor (Array a) -> Element -> Component a -> Element

foreign import toUndefined_ :: forall a. (Maybe a -> Boolean) -> Maybe a -> UndefinedOr a

toUndefined :: forall a. Maybe a -> UndefinedOr a
toUndefined = toUndefined_ isJust
