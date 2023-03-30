module Frontend.Routes.Home.Data where

import Prelude
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect.Aff (attempt)
import Foreign (Foreign)
import Milkis (URL(..), defaultFetchOptions, json)
import SolidJS.Basic (Resource, createResource)
import SolidJS.Basic.Http (fetch)
import Type.Proxy (Proxy(..))

json_ = Proxy :: Proxy "json"

homeRouteData :: Unit -> Resource Foreign
homeRouteData _ =
  createResource do
    res <- attempt $ fetch (URL "https://jsonplaceholder.typicode.com/todos/1") defaultFetchOptions
    case res of
      Left _ -> pure $ Nothing
      Right r -> Just <$> json r
