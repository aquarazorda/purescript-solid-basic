module SolidJS.Basic.Http where

import Prelude
import Control.Promise (Promise, toAffE)
import Effect (Effect)
import Effect.Aff (Aff)
import Foreign (Foreign)

foreign import isServer :: Boolean

foreign import fetch_ :: String -> Effect (Promise Foreign)

fetch :: String -> Aff Foreign
fetch = toAffE <<< fetch_
