module SolidJS.Basic.Dom where

import Data.Maybe (Maybe, isJust)
import Data.UndefinedOr (UndefinedOr)
import Prelude (pure, ($), (<$>))
import SolidJS.Basic (Accessor, Children, Component, createComponent, createComponent_)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Fallback
  = Element

type PropsWithChildren props
  = Record ( children :: Children | props )

foreign import dynamic :: forall props component children. component -> props -> children -> Element

text :: forall a. a -> Element
text = unsafeCoerce

div :: forall props. props -> Children -> Element
div = dynamic "div"

div_ ∷ Children -> Element
div_ children = div {} children

button ∷ forall props. props -> Children → Element
button = dynamic "button"

foreign import toUndefined_ :: forall a. (Maybe a -> Boolean) -> Maybe a -> UndefinedOr a

toUndefined :: forall a. Maybe a -> UndefinedOr a
toUndefined = toUndefined_ isJust

foreign import show :: forall when when_. when -> Fallback -> (when_ -> Element) -> Element

showAccessorMaybe :: forall a. Accessor (Maybe a) -> Fallback -> (a -> Element) -> Element
showAccessorMaybe when fb render =
  createComponent do
    pure $ show (toUndefined <$> when) fb render
