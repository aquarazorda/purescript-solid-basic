module Main where

import Prelude hiding (div)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Frontend.Routes.Home.Data (homeRouteData)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic as G
import SolidJS.Basic (Component, fragment)
import SolidJS.Basic.Router (lazyRoute, route)

data Route
  = Home
  | About

derive instance genericRoute :: Generic Route _

routes :: RouteDuplex' Route
routes =
  root
    $ G.sum
        { "Home": G.noArgs
        , "About": path "about" G.noArgs
        }

default :: Component { message :: String }
default _ =
  fragment
    [ route routes
        { path: Home
        , lazy: lazyRoute "Home" (Just homeRouteData)
        }
    , route routes
        { path: About
        , lazy: lazyRoute "About" Nothing
        }
    ]
