module Main where

import Prelude hiding (div)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Frontend.Routes.Home as H
import Frontend.Routes.Home.Data (homeRouteData)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic as G
import SolidJS.Basic (Component, createComponent, fragment)
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
--         , lazy: lazyRoute "Home" (Just homeRouteData)
--         }
--     , route routes
--         { path: About
--         , lazy: lazyRoute "About" Nothing
--         }
--     ]
default :: Component {}
default _ =
  S.html { lang: "en" }
    [ S.head unit
        [ S.title unit "SolidStart PureScript"
        , S.meta { charset: "utf-8" }
        , S.meta { name: "viewport", content: "width=device-width, initial-scale=1" }
        ]
    , S.body { class: "bg-slate-800" }
        [ S.suspense {}
            [ S.errorBoundary {}
                [ S.routes {}
                    -- [ router {} ]
                    [ route routes
                        { path: Home
                        , component: H.default
                        , data: homeRouteData
                        -- , lazy: lazyRoute "Home" (Just homeRouteData)
                        }
                    ]
                ]
            ]
        , S.scripts unit
        ]
    ]
