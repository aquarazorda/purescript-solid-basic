module Main where

import Prelude hiding (div)
import Data.Generic.Rep (class Generic)
import Frontend.Routes.Home as HS
import Frontend.Routes.Home.Data (homeRouteData)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic as G
import SolidJS.Basic (Component, fragment)
import SolidJS.Basic.Dom (text)
import SolidJS.Basic.Router (lazyRoute, route)
import SolidJS.Basic.Start as S

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

-- router :: Component {}
-- router _ =
--   fragment
--     [ route routes
--         { path: Home
--         , lazy: lazyRoute "Home" homeRouteData
--         }
--     , route routes
--         { path: About
--         , lazy: lazyRoute "About" \_ -> unit
--         }
--     ]
default :: Component {}
default _ =
  S.html
    { lang: "en"
    , children:
        [ S.head
            [ S.title "SolidStart PureScript"
            , S.meta { charset: "utf-8" }
            , S.meta { name: "viewport", content: "width=device-width, initial-scale=1" }
            ]
        , S.body
            { class: "bg-slate-800"
            , children:
                [ S.suspense
                    (text "Loading...")
                    [ S.errorBoundary
                        ( \_ ->
                            text "Error"
                        )
                        [ S.routes
                            [ route routes
                                { path: Home
                                , component: HS.default
                                , data: homeRouteData
                                }
                            ]
                        ]
                    ]
                , S.scripts unit
                ]
            }
        ]
    }
