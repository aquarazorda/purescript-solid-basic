module HackerNews.Components.Story where

import Prelude
import Data.UndefinedOr (empty)
import HackerNews.Types (IStory)
import SolidJS.Basic (Component, createComponent, createComponent_)
import SolidJS.Basic.Dom as D
import SolidJS.Basic.Props ((:=))
import SolidJS.Basic.Start (a)
import Unsafe.Coerce (unsafeCoerce)

storyComponent :: Component IStory
storyComponent story =
  createComponent_ do
    pure
      $ D.li { class: "news-item" }
          [ D.span { class: "score" } [ D.text story.points ]
          , D.span { class: "title" }
              [ D.show_ story.url
                  (a { "href": "/item/" <> show story.id } [ D.text story.title ])
                  $ [ D.a
                        { href: story.url, target: "_blank", rel: "noreferrer" }
                        [ D.text story.title ]
                    , D.span { class: "host" } [ D.text $ " (" <> story.domain <> ")" ]
                    ]
              ]
          , D.br {}
          , D.span { class: "meta" }
              [ D.show_ (story.type /= "job")
                  (a { href: "/stories/" <> show story.id } [ D.text story.time_ago ])
                  [ D.text "by "
                  , a { href: "/users/" <> story.user } [ D.text story.user ]
                  , D.text $ " " <> story.time_ago <> " | "
                  , a { href: "/stories/" <> show story.id }
                      [ D.text
                          $ if story.comments_count > 0 then
                              show story.comments_count <> " comments"
                            else
                              "discuss"
                      ]
                  ]
              ]
          , D.show_ (story.type /= "link") (unsafeCoerce empty)
              $ [ D.text " "
                , D.span { class: "label" } [ D.text story.type ]
                ]
          ]
