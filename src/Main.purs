module Main where

import Prelude
import Data.Tuple.Nested ((/\))
import Effect.Class.Console (logShow)
import Effect.Console (log)
import SolidJS.Basic (Component, access, createComponent, createEffect, createMemo, createSignal, render)
import SolidJS.Basic.Dom (button, div_, text)

main :: Component { message :: String }
main { message } =
  createComponent do
    (count /\ setCount) <-
      createSignal 0
    createEffect \_ -> do
      logShow (access count)
    pure
      $ div_
          [ text message
          , button
              { children:
                  [ createMemo \_ -> (access count) + 1
                  , count
                  ]
              , onClick: \_ -> setCount $ access count + 1
              }
          ]
