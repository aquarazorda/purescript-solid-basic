module Components.Nav where

import Prelude
import SolidJS.Basic (Component, createComponent_)
import SolidJS.Basic.Dom as D
import SolidJS.Basic.Start (a)

nav :: Component {}
nav _ =
  createComponent_ do
    pure
      $ D.header { class: "header" }
          [ D.nav { class: "inner" }
              [ a { "href": "/" }
                  [ D.strong {}
                      [ D.text "HN"
                      ]
                  ]
              , a { "href": "/new" }
                  [ D.strong {}
                      [ D.text "New"
                      ]
                  ]
              , a { "href": "/show" }
                  [ D.strong {}
                      [ D.text "Show"
                      ]
                  ]
              , a { "href": "/ask" }
                  [ D.strong {}
                      [ D.text "Ask"
                      ]
                  ]
              , a { "href": "/job" }
                  [ D.strong {}
                      [ D.text "Jobs"
                      ]
                  ]
              , D.a { class: "github", href: "http://github.com/solidjs/solid", target: "_blank", rel: "noreferrer" }
                  [ D.text "Built with Solid + PureScript"
                  ]
              ]
          ]
