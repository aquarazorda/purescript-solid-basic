module Main where

import Prelude hiding (div)
import Data.Generic.Rep (class Generic)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic as G
import SolidJS.Basic (Component, access, fragment, lazy)
import SolidJS.Basic.Dom (div, text)
import SolidJS.Basic.Router (route, lazyRoute)

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

main :: Component { message :: String }
main _ =
  fragment
    [ route routes
        { path: Home
        , lazy: lazyRoute "Home"
        }
    , route routes
        { path: About
        , component: testcomp
        }
    ]

testcomp :: Component { message :: String }
testcomp _ = div { className: "flex justify-center" } [ text "About" ]
