module Frontend.Routes.Home.Data where

import Prelude
import Fetch (Method(..), fetch)
import Foreign (Foreign)
import Record (get)
import SolidJS.Basic (Resource, createResource)
import Type.Proxy (Proxy(..))

json_ = Proxy :: Proxy "json"

homeRouteData :: Unit -> Resource Foreign
homeRouteData _ = createResource $ get json_ =<< fetch "https://jsonplaceholder.typicode.com/todos/1" { method: GET }
