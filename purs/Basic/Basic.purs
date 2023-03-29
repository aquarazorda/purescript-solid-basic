module SolidJS.Basic where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.Function.Uncurried (runFn0)
import Data.Maybe (Maybe)
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Data.UndefinedOr (UndefinedOr, fromUndefined)
import Effect (Effect)
import Effect.Aff (Aff)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Component props
  = props -> Element

type Children
  = Array Element

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
  pure x = unsafeCoerce $ x

foreign import render :: Element -> Element -> Effect Unit

foreign import createSignal :: forall a. a -> Effect (Tuple (Accessor a) (a -> Unit))

foreign import createEffect :: (Unit -> Effect Unit) -> Effect Unit

foreign import createMemo :: forall a. (Unit -> a) -> Accessor a

foreign import createComponent :: forall props. (props -> Effect Element) -> Component props

foreign import fragment :: Children -> Element

-- type Resource a
--   = Tuple (Accessor a)
--       ( { state :: String
--         , loading :: Boolean
--         , error :: Foreign
--         , latest :: Accessor a
--         }
--       )
type Resource' a
  = Effect
      ( Tuple (Accessor (UndefinedOr a))
          ( { mutate :: (a -> a) -> Effect Unit
            , refetch :: Unit -> Aff a
            }
          )
      )

type Resource a
  = Effect
      ( Tuple (Accessor (Maybe a))
          ( { mutate :: (a -> a) -> Effect Unit
            , refetch :: Unit -> Aff a
            }
          )
      )

foreign import createResource_ :: forall a. Effect (Promise a) -> Resource' a

createResource :: forall a. Aff a -> Resource a
createResource aff = do
  (d /\ m) <- createResource_ $ fromAff aff
  let
    maybeA = createMemo \_ -> fromUndefined $ access_ d
  pure $ Tuple maybeA m

type ModuleName
  = String

foreign import data Lazy :: Type -> Type

foreign import lazy_ :: forall a. ModuleName -> (a -> Effect Element)

lazy :: forall a. ModuleName -> Component a
lazy = createComponent <<< lazy_
