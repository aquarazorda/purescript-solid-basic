module HackerNews.Types where

type IComment
  = { user :: String
    , time_ago :: String
    , content :: String
    -- , comments :: Array IComment
    }

type IStory
  = { id :: Int
    , points :: Int
    , url :: String
    , title :: String
    , domain :: String
    , type :: String
    , time :: Int
    , time_ago :: String
    , user :: String
    , comments_count :: Int
    , comments :: Array IComment
    }
