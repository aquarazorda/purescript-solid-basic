module SolidJS.Basic.Dom where

import Data.Maybe (Maybe, isJust)
import Data.UndefinedOr (UndefinedOr)
import Prelude (pure, ($), (<$>), (<<<))
import SolidJS.Basic (Accessor, Children, ChildrenAsProp, children, createComponent)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Fallback
  = Element

foreign import dynamic :: forall props component. component -> props -> Children -> Element

dyn :: forall props component. component -> props -> ChildrenAsProp -> Element
dyn name ps = dynamic name ps <<< children

text :: forall a. a -> Element
text = unsafeCoerce

div :: forall props. props -> ChildrenAsProp -> Element
div = dyn "div"

div_ ∷ ChildrenAsProp -> Element
div_ children = div {} children

button ∷ forall props. props -> ChildrenAsProp → Element
button = dyn "button"

foreign import toUndefined_ :: forall a. (Maybe a -> Boolean) -> Maybe a -> UndefinedOr a

toUndefined :: forall a. Maybe a -> UndefinedOr a
toUndefined = toUndefined_ isJust

foreign import show :: forall when when_. when -> Fallback -> (when_ -> Element) -> Element

showAccessorMaybe :: forall a. Accessor (Maybe a) -> Fallback -> (a -> Element) -> Element
showAccessorMaybe when fb render =
  createComponent do
    pure $ show (toUndefined <$> when) fb render
