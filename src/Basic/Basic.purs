module SolidJS.Basic where

import Prelude
import Data.Function.Uncurried (runFn0)
import Data.Tuple (Tuple)
import Effect (Effect)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Component props
  = props -> Effect Element

foreign import data Accessor :: Type -> Type

foreign import render :: Element -> Element -> Effect Unit

foreign import createSignal :: forall a. a -> Effect (Tuple (Accessor a) (a -> Unit))

foreign import createEffect :: (Unit -> Effect Unit) -> Effect Unit

foreign import createMemo :: forall a. (Unit -> a) -> Accessor a

foreign import createComponent :: Effect Element -> Effect Element

foreign import dynamic :: forall props. String -> props -> Element

access :: forall a. Accessor a -> a
access = unsafeCoerce runFn0
