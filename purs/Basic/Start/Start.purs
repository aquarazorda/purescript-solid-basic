module SolidJS.Basic.Start (html, head, title, meta, body, routes, scripts, errorBoundary, suspense) where

import Prelude
import SolidJS.Basic (Children, ComponentWithChildren, Component)
import SolidJS.Basic.Dom (dynamic)
import Web.DOM (Element)
import Web.HTML (HTMLBodyElement, HTMLHeadElement, HTMLMetaElement, HTMLTitleElement)
import Web.HTML.HTMLHtmlElement (HTMLHtmlElement)

foreign import html_ :: HTMLHtmlElement

html :: forall a. ComponentWithChildren a
html = dynamic html_

foreign import head_ :: HTMLHeadElement

head :: Unit -> Children -> Element
head = dynamic head_

foreign import title_ :: HTMLTitleElement

title :: Unit -> String -> Element
title = dynamic title_

foreign import meta_ :: HTMLMetaElement

meta :: forall a. Component a
meta props = dynamic meta_ props []

foreign import body_ :: HTMLBodyElement

body :: forall a. ComponentWithChildren a
body = dynamic body_

foreign import routes_ :: Element

routes :: forall a. ComponentWithChildren a
routes = dynamic routes_

foreign import scripts_ :: Element

scripts :: Element
scripts = dynamic scripts_ {} []

foreign import errorBoundary_ :: Element

errorBoundary :: forall a. ComponentWithChildren a
errorBoundary = dynamic errorBoundary_

foreign import suspense_ :: forall a. ComponentWithChildren a

suspense :: forall a. ComponentWithChildren a
suspense = dynamic suspense_
