module Frontend.Routes.Home.Data where

import Prelude
import Data.Int (fromString)
import Data.Map (Map, fromFoldable, lookup)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Data.UndefinedOr (UndefinedOr, fromUndefined)
import HackerNews.Api (getStories)
import HackerNews.Types (IStory)
import SolidJS.Basic (createResourceWithSource)
import SolidJS.Basic.Router (RouteDataArgs)
import SolidJS.Basic.Signals (Accessor, createMemo)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)

json_ = Proxy :: Proxy "json"

mapStories :: Map String String
mapStories =
  fromFoldable
    [ Tuple "top" "news"
    , Tuple "new" "newest"
    , Tuple "show" "show"
    , Tuple "ask" "ask"
    , Tuple "job" "jobs"
    ]

type StoriesData
  = { page :: Accessor Int
    , typ :: Accessor String
    , stories :: Accessor (Array IStory)
    }

undefinedOr :: forall a. UndefinedOr a -> a -> a
undefinedOr un def = case fromUndefined un of
  Just a -> a
  Nothing -> def

storiesData :: RouteDataArgs { stories :: UndefinedOr String } { page :: UndefinedOr String } StoriesData
storiesData { location, params } = do
  let
    page :: Accessor Int
    page = createMemo \_ -> fromMaybe 1 $ fromString =<< fromUndefined location.query.page

    typ :: Accessor String
    typ = createMemo \_ -> undefinedOr params.stories "top"

    resourceUrl :: Accessor String
    resourceUrl = do
      t <- typ
      p <- page
      createMemo \_ -> fromMaybe "top" (lookup t mapStories) <> "?page=" <> show p

    stories /\ _ = createResourceWithSource resourceUrl getStories

    retVal =
      { typ
      , page
      , stories
      }
  unsafeCoerce $ retVal
