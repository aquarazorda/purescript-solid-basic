module Main where

import Prelude hiding (div)
import Components.Nav (nav)
import Data.Generic.Rep (class Generic)
import Frontend.Routes.Home.Data (storiesData)
import Routing.Duplex (RouteDuplex', path, root)
import Routing.Duplex.Generic as G
import SolidJS.Basic (Component, createComponent, createComponent_)
import SolidJS.Basic.Dom (text)
import SolidJS.Basic.Router (lazyRoute, route)
import SolidJS.Basic.Start (outlet)
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
router _ =
  createComponent_ do
    pure
      $ text
          [ route
              { path: "*all"
              , lazy: lazyRoute "Home" storiesData
              , children:
                  [ route
                      { path: "/:stories"
                      }
                  , route
                      { path: "/"
                      }
                  ]
              }
          ]

default :: Component {}
default _ = do
  S.html
    { lang: "en"
    , children:
        [ S.head {}
            [ S.title "SolidStart PureScript Tailwind - Hacker News"
            , S.meta { charset: "utf-8" }
            , S.meta { name: "viewport", content: "width=device-width, initial-scale=1" }
            , S.meta { name: "description", content: "Hacker News clone built with PureScript" }
            ]
        , S.body {}
            [ nav {}
            , S.suspense
                (text "Loading...")
                $ [ S.routes {}
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
