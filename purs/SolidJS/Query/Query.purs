module SolidJS.Basic.Query where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.Maybe (Maybe)
import Data.UndefinedOr (UndefinedOr, fromUndefined)
import Effect (Effect)
import Effect.Aff (Aff)
import Record (set)
import Record.Builder (modify)
import SolidJS.Basic (Accessor, ChildrenAsProp, createMemo)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (Element)

type PartialQueryReturn d
  = { isLoading :: Boolean
    , isError :: Boolean
    , isSuccess :: Boolean
    , error ::
        { message :: String
        }
    | d
    }

type QueryReturn a
  = PartialQueryReturn
      ( data :: UndefinedOr a
      )

foreign import data QueryClient :: Type

foreign import getQueryClient :: Unit -> QueryClient

foreign import queryClientProvider :: QueryClient -> ChildrenAsProp -> Element

foreign import createQuery_ :: forall a. Array String -> Effect (Promise a) -> QueryReturn a

createQuery :: forall a. Array String -> Aff a -> QueryReturn a
createQuery queryKeys = createQuery_ queryKeys <<< fromAff
