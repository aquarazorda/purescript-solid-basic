module Frontend.Routes.Home.Data where

import Prelude
import Foreign (Foreign)
import SolidJS.Basic (Resource, createResource)
import SolidJS.Basic.Http (fetch)
import Type.Proxy (Proxy(..))

json_ = Proxy :: Proxy "json"

homeRouteData :: Unit -> Resource Foreign
homeRouteData _ = createResource $ fetch "https://jsonplaceholder.typicode.com/todos/1"
