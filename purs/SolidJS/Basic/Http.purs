module SolidJS.Basic.Http where

import Prelude
import Control.Promise (Promise, toAffE)
import Effect (Effect)
import Effect.Aff (Aff)
import Foreign (Foreign)
import Unsafe.Coerce (unsafeCoerce)

foreign import isServer :: Boolean

foreign import fetch_ :: String -> Effect (Promise Foreign)

foreign import fetchWH :: String -> Headers -> Effect (Promise Foreign)

fetch :: String -> Aff Foreign
fetch = toAffE <<< fetch_

fetchWithHeaders :: String -> Headers -> Aff Foreign
fetchWithHeaders url = toAffE <<< fetchWH url

foreign import data Headers :: Type

mkHeaders :: forall a. Record a -> Headers
mkHeaders = unsafeCoerce
