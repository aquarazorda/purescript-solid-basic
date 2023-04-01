module Main where

import Prelude hiding (div)
import Data.Generic.Rep (class Generic)
import Frontend.Routes.Home.Data (homeRouteData)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic as G
import SolidJS.Basic (Component, createComponent_)
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

router :: Component {}
router =
  createComponent_ \_ ->
    text
      [ route routes
          { path: Home
          , lazy: lazyRoute "Home" homeRouteData
          }
      , route routes
          { path: About
          , lazy: lazyRoute "About" \_ -> unit
          }
      ]

default :: Component {}
default _ =
  S.html
    { lang: "en"
    , children:
        [ S.head {} \_ ->
            [ S.title "SolidStart PureScript Tailwind - Hacker News"
            , S.meta { charset: "utf-8" }
            , S.meta { name: "viewport", content: "width=device-width, initial-scale=1" }
            , S.meta { name: "description", content: "Hacker News clone build with PureScript" }
            ]
        , S.body {} \_ ->
            [ S.suspense {} \_ ->
                [ S.routes {} \_ ->
                    [ router {}
                    ]
                ]
            , S.scripts unit
            ]
        ]
    }

-- $ children \_ ->
--                         [ S.errorBoundary
--                             ( \_ ->
--                                 text "Error"
--                             )
--                             $ children \_ ->
--                                 [ S.routes
--                                     $ children \_ ->
--                                         [ route
--                                             { path: "/"
--                                             , component: HS.default
--                                             , data: homeRouteData
--                                             -- , lazy: lazyRoute "Home" homeRouteData
--                                             }
--                                         ]
--                                 -- [ router {}
--                                 -- ]
--                                 ]
--                         ]
