module SolidJS.Basic.Start
  ( html
  , head
  , title
  , meta
  , body
  , routes
  , scripts
  , errorBoundary
  , suspense
  , a
  , link
  , outlet
  ) where

import Prelude
import SolidJS.Basic (Component, ComponentWithChildren, createComponent, createComponentChildren, createComponent_)
import SolidJS.Basic.Dom (text)
import SolidJS.Basic.Props (Props, (:=))
import SolidJS.Basic.Types (Children, Element)

foreign import html_ :: forall a. Component a

html :: forall props. props -> Element
html = createComponent html_

foreign import head_ :: forall a. Component a

head :: forall a. ComponentWithChildren a
head = createComponentChildren head_

foreign import title_ :: Component {}

title :: String -> Element
title s = createComponentChildren title_ {} [ text s ]

foreign import meta_ :: forall a. Component a

meta :: forall a. Component a
meta = createComponent meta_

foreign import link_ :: forall a. Component a

link :: forall a. Component a
link = createComponent link_

foreign import body_ :: forall props. Component props

body :: forall a. ComponentWithChildren a
body = createComponentChildren body_

foreign import routes_ :: forall props. Component props

routes :: forall a. ComponentWithChildren a
routes = createComponentChildren routes_

foreign import scripts_ :: Component {}

scripts :: Unit -> Element
scripts _ = createComponent scripts_ {}

foreign import errorBoundary_ :: forall e. Component e

errorBoundary :: forall e. Component e -> Children -> Element
errorBoundary fallback =
  createComponentChildren errorBoundary_
    { fallback
    }

foreign import suspense_ :: forall a. Component a

suspense :: forall a. Element -> Children -> Element
suspense fallback = createComponentChildren suspense_ { fallback }

foreign import a_ :: forall a. Component a

a :: forall props. ComponentWithChildren props
a = createComponentChildren a_

foreign import outlet_ :: forall a. Component a

outlet :: Unit -> Element
outlet _ = createComponentChildren outlet_ [] []
