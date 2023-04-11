module Frontend.Routes.Home (default) where

import Prelude hiding (div)
import Data.Array (length)
import Data.UndefinedOr (isUndefined, toUndefined)
import Effect (Effect)
import Frontend.Routes.Home.Data (StoriesData)
import HackerNews.Components.Story (storyComponent)
import SolidJS.Basic (Component, Resource, createComponent_)
import SolidJS.Basic.Dom (forEach, show_)
import SolidJS.Basic.Dom as D
import SolidJS.Basic.Router (useRouteData)
import SolidJS.Basic.Signals (access, createMemo, memoProp)
import SolidJS.Basic.Start (a)

type ResourceData
  = Resource { title :: String }

default ∷ Component {}
default _ =
  createComponent_ do
    { page, stories, typ } <- useRouteData :: Effect StoriesData
    pure
      $ D.div
          { class: "news-view" }
          [ D.div
              { "class": "news-list-nav" }
              [ D.show_ (createMemo \_ -> access page > 1)
                  ( D.span { class: "page-link disabled", ariaDisabled: "true" }
                      [ D.text "< prev"
                      ]
                  )
                  [ a
                      { class: "page-link"
                      , href: memoProp $ createMemo \_ -> "/" <> access typ <> "?page=" <> show (access page - 1)
                      , ariaLabel: "Previous Page"
                      }
                      [ D.text "< prev"
                      ]
                  ]
              , D.span {} [ D.text $ createMemo \_ -> "page " <> show (access page) ]
              , D.show_
                  (createMemo \_ -> (not (isUndefined $ toUndefined $ access stories)) && ((length $ access stories)) > 28)
                  ( D.span { class: "page-link disabled", ariaDisabled: "true" }
                      [ D.text "more >"
                      ]
                  )
                  [ a
                      { class: "page-link"
                      , href: memoProp $ createMemo \_ -> "/" <> access typ <> "?page=" <> show ((access page) + 1)
                      , ariaLabel: "Next Page"
                      }
                      [ D.text "more >" ]
                  ]
              ]
          , D.main
              { class: "news-list" }
              [ show_ (createMemo \_ -> length $ access stories) (D.text $ createMemo \_ -> "No " <> access typ <> " found")
                  [ D.ul {}
                      [ forEach stories (D.text "") storyComponent
                      ]
                  ]
              ]
          ]
