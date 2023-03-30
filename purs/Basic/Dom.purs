module SolidJS.Basic.Dom where

import Prelude (($), (<$>))
import Data.Maybe (Maybe, isJust)
import Data.UndefinedOr (UndefinedOr)
import SolidJS.Basic (Accessor, Children, Component)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

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

foreign import show_ :: forall a cs. Component { when :: a, fallback :: Element, children :: cs }

show :: forall a cs. a -> Element -> cs -> Element
show when fallback cs = show_ { when, fallback, children: cs }

foreign import toUndefined_ :: forall a. (Maybe a -> Boolean) -> Maybe a -> UndefinedOr a

toUndefined :: forall a. Maybe a -> UndefinedOr a
toUndefined = toUndefined_ isJust

showAccessorMaybe :: forall a. Accessor (Maybe a) -> Element -> (a -> Element) -> Element
showAccessorMaybe when = show $ toUndefined <$> when

showMaybe :: forall a. Maybe a -> Element -> (a -> Element) -> Element
showMaybe when = show $ toUndefined when
