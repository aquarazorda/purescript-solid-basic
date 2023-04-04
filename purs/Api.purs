module HackerNews.Api where

import Prelude
import Control.Promise (Promise, fromAff)
import Data.String.Utils (startsWith)
import Effect.Aff (Aff)
import Effect.Unsafe (unsafePerformEffect)
import Foreign (Foreign)
import HackerNews.Types (IStory)
import SolidJS.Basic.Http (fetchWithHeaders, isServer, mkHeaders)
import Unsafe.Coerce (unsafeCoerce)

story :: String -> String
story path = "https://node-hnapi.herokuapp.com/" <> path

user :: String -> String
user path = "https://hacker-news.firebaseio.com/v0/" <> path <> ".json"

isUserPath :: String -> Boolean
isUserPath path = path `startsWith` "user"

fetchAPI :: String -> Aff Foreign
fetchAPI url = do
  res <- fetchWithHeaders url headers
  pure res
  where
  headers = if isServer then mkHeaders { "User-Agent": "chrome" } else mkHeaders {}

getStories :: String -> Promise (Array IStory)
getStories path = unsafeCoerce $ unsafePerformEffect $ fromAff $ fetchAPI url
  where
  url = story path
