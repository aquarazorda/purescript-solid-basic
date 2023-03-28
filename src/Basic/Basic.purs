module SolidJS.Basic where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.Function.Uncurried (runFn0)
import Data.Tuple (Tuple)
import Effect (Effect)
import Effect.Aff (Aff)
import Foreign (Foreign)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type Component props
  = props -> Element

type Children
  = Array Element

foreign import data Accessor :: Type -> Type

foreign import render :: Element -> Element -> Effect Unit

foreign import createSignal :: forall a. a -> Effect (Tuple (Accessor a) (a -> Unit))

foreign import createEffect :: (Unit -> Effect Unit) -> Effect Unit

foreign import createMemo :: forall a. (Unit -> a) -> Accessor a

foreign import createComponent :: forall props. (props -> Effect Element) -> Component props

foreign import dynamic :: forall props. String -> props -> Children -> Element

foreign import fragment :: Children -> Element

-- type Resource a
--   = Tuple (Accessor a)
--       ( { state :: String
--         , loading :: Boolean
--         , error :: Foreign
--         , latest :: Accessor a
--         }
--       )
type Resource a
  = Aff
      ( Tuple (Accessor a)
          ( { mutate :: (a -> a) -> Effect Unit
            , refetch :: Unit -> Aff a
            }
          )
      )

foreign import createResource_ :: forall a. Effect (Promise a) -> Resource Foreign

createResource :: forall a. Aff a -> Resource Foreign
createResource = createResource_ <<< fromAff

type ModuleName
  = String

foreign import data Lazy :: Type -> Type

foreign import lazy_ :: forall a. ModuleName -> (a -> Effect Element)

lazy :: forall a. ModuleName -> Component a
lazy = createComponent <<< lazy_

access :: forall a. Accessor a -> a
access = unsafeCoerce runFn0
