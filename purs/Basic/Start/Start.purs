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
  ) where

import Prelude
import SolidJS.Basic (Children, Component, cc, children, createComponent_)
import Web.DOM (Element)

foreign import html_ :: forall a. Component a

html :: forall props. props -> Element
html = createComponent_ html_

foreign import head_ :: forall a. Component a

head :: forall props. props -> Children -> Element
head = cc head_

foreign import title_ :: Component { children :: String }

title :: String -> Element
title children = createComponent_ title_ { children }

foreign import meta_ :: forall a. Component a

meta :: forall a. Component a
meta = createComponent_ meta_

foreign import link_ :: forall a. Component a

link :: forall a. Component a
link = createComponent_ link_

foreign import body_ :: forall props. Component props

body :: forall props. props -> Children -> Element
body = cc body_

foreign import routes_ :: forall props. Component props

routes :: forall props. props -> Children -> Element
routes = cc routes_

foreign import scripts_ :: Component {}

scripts :: Unit -> Element
scripts _ = createComponent_ scripts_ {}

foreign import errorBoundary_ :: forall e. Component e

errorBoundary :: forall e. Component e -> Children -> Element
errorBoundary fallback children = cc errorBoundary_ { fallback } children

foreign import suspense_ :: forall a. Component a

suspense :: forall a. a -> (Unit -> Array Element) -> Element
suspense props = cc suspense_ props <<< children

foreign import a_ :: forall a. Component a

a :: forall props. props -> Children -> Element
a children props = createComponent_ a_ { children, props }
