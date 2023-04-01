module SolidJS.Basic where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.Function.Uncurried (mkFn0, runFn0)
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple)
import Effect (Effect)
import Effect.Aff (Aff)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Component props
  = props -> Element

type ComponentWithChildren props
  = props -> Children -> Element

data ChildrenProp a
  = Children (Accessor a)

type Children
  = ChildrenProp (Array Element)

data Accessor a
  = Accessor a

access_ :: forall a. Accessor a -> a
access_ = unsafeCoerce runFn0

access :: forall a b. (a -> b) -> Accessor a -> Accessor b
access = map

toElement :: forall a. Accessor a -> Element
toElement = unsafeCoerce

instance functorAccessor :: Functor Accessor where
  map f x = createMemo \_ -> f $ access_ x

instance applyAccessor :: Apply Accessor where
  apply f x = createMemo \_ -> access_ f $ access_ x

instance bindAccessor :: Bind Accessor where
  bind acc fn = unsafeCoerce $ createMemo \_ -> fn $ access_ acc

instance applicativeAccessor :: Applicative Accessor where
  pure x = unsafeCoerce $ mkFn0 (\_ -> x)

foreign import render :: Element -> Element -> Effect Unit

foreign import createSignal :: forall a. a -> Effect (Tuple (Accessor a) (a -> Unit))

foreign import createEffect :: (Unit -> Effect Unit) -> Effect Unit

foreign import createMemo :: forall a. (Unit -> a) -> Accessor a

foreign import createMemo_ :: forall a. Effect a -> Effect (Accessor a)

foreign import createComponent :: Effect Element -> Element

foreign import createComponent_ :: forall props. (Component props) -> props -> Element

foreign import cc :: forall props. (Component props) -> props -> Children -> Element

foreign import fragment :: Children -> Element

-- type Resource a
--   = Tuple (Accessor a)
--       ( { state :: String
--         , loading :: Boolean
--         , error :: Foreign
--         , latest :: Accessor a
--         }
--       )
type ResourceActions
  = { mutate :: Effect Unit, refetch :: Effect Unit }

type Resource a
  = Tuple (Accessor (Maybe a)) ResourceActions

foreign import createResource_ :: forall initial a. Maybe initial -> Effect (Promise (Maybe a)) -> Resource a

createResource :: forall a. Aff (Maybe a) -> Resource a
createResource aff = createResource_ Nothing $ fromAff aff

type ModuleName
  = String

foreign import data Lazy :: Type -> Type

foreign import lazy :: forall a. ModuleName -> Component a

foreign import data Props :: Type -> Type

foreign import props :: forall a. a -> Props a

foreign import toGetterProp :: forall a. String -> (Unit -> a) -> Props a

foreign import children :: (Unit -> Array Element) -> Children
