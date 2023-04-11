module SolidJS.Basic where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.Tuple (Tuple)
import Data.UndefinedOr (UndefinedOr)
import Effect (Effect)
import Effect.Aff (Aff)
import SolidJS.Basic.Signals (Accessor)
import SolidJS.Basic.Types (Children, Element)
import Unsafe.Coerce (unsafeCoerce)

type Component props
  = props -> Element

type ComponentWithChildren props
  = props -> Children -> Element

toElement :: forall a. Accessor a -> Element
toElement = unsafeCoerce

foreign import render :: Element -> Element -> Effect Unit

foreign import dynamic :: forall component props. component -> props -> Children -> Element

foreign import createComponent :: forall props. Component props -> props -> Element

foreign import createComponent_ :: Effect Element -> Element

foreign import createComponentChildren :: forall props. Component props -> props -> Children -> Element

foreign import createSignal :: forall a. a -> Effect (Tuple (Accessor a) (a -> Unit))

foreign import createEffect :: Effect (Unit) -> Effect Unit

type ResourceActions
  = { mutate :: Effect Unit, refetch :: Effect Unit }

type Resource a
  = Tuple (Accessor (UndefinedOr a)) ResourceActions

foreign import createResource_ :: forall a. Effect (Promise a) -> Resource a

createResource :: forall a. Aff a -> Resource a
createResource = createResource_ <<< fromAff

foreign import createResourceWithSource :: forall a b. Accessor a -> (a -> Promise b) -> Resource b

createResourceWithSource' :: forall a b. (Unit -> a) -> (a -> Promise b) -> Resource b
createResourceWithSource' = unsafeCoerce createResourceWithSource

type ModuleName
  = String

foreign import data Lazy :: Type -> Type

foreign import lazy :: forall a. ModuleName -> Component a
