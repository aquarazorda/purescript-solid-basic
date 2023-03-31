module SolidJS.Basic.Start (html, head, title, meta, body, routes, scripts, errorBoundary, suspense) where

import Prelude
import SolidJS.Basic (Component, Children, createComponent_)
import Web.DOM (Element)

foreign import html_ :: forall a. Component a

html :: forall props. props -> Element
html = createComponent_ html_

foreign import head_ :: Component { children :: Children }

head :: Children -> Element
head children = createComponent_ head_ { children }

foreign import title_ :: Component { children :: String }

title :: String -> Element
title children = createComponent_ title_ { children }

foreign import meta_ :: forall a. Component a

meta :: forall a. Component a
meta = createComponent_ meta_

foreign import body_ :: forall props. Component props

body :: forall props. props -> Element
body = createComponent_ body_

foreign import routes_ :: Component { children :: Children }

routes :: Children -> Element
routes children = createComponent_ routes_ { children }

foreign import scripts_ :: Component {}

scripts :: Unit -> Element
scripts _ = createComponent_ scripts_ {}

type WithFallbackProps fb
  = { fallback :: fb, children :: Children }

foreign import errorBoundary_ :: forall e. Component (WithFallbackProps (Component e))

errorBoundary :: forall e. Component e -> Children -> Element
errorBoundary fallback children = createComponent_ errorBoundary_ { fallback, children }

foreign import suspense_ :: Component (WithFallbackProps Element)

suspense :: Element -> Children -> Element
suspense fallback children = createComponent_ suspense_ { fallback, children }
