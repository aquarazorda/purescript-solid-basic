module SolidJS.Basic.Query where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.UndefinedOr (UndefinedOr)
import Effect (Effect)
import Effect.Aff (Aff)
-- import SolidJS.Basic (ChildrenAsProp)
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

-- foreign import queryClientProvider :: QueryClient -> ChildrenAsProp -> Element
foreign import createQuery_ :: forall a. Array String -> Effect (Promise a) -> QueryReturn a

createQuery :: forall a. Array String -> Aff a -> QueryReturn a
createQuery queryKeys = createQuery_ queryKeys <<< fromAff
