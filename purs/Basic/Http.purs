module SolidJS.Basic.Http where

import Data.Function.Uncurried (Fn0, runFn0)
import Milkis as M
import Milkis.Impl (FetchImpl)

foreign import isServer :: Boolean

foreign import getFetch :: Fn0 FetchImpl

fetch :: M.Fetch
fetch = M.fetch (runFn0 getFetch)
