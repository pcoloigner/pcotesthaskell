{-# LANGUAGE OverloadedStrings #-}

module Model where

import qualified Data.Text as T
--import qualified Database.SQLite.Simple as SQL
--import Database.SQLite.Simple.FromRow (FromRow, fromRow, field)
import qualified Data.ByteString.Char8 as B8
import qualified Database.PostgreSQL.Simple as P
import Database.PostgreSQL.Simple.FromRow (FromRow, fromRow, field)


-- Nom du fichier de base de données SQLite.
--dbName = "myblog.db"

data Message = Message 
  { author :: T.Text
  , title  :: T.Text
  , body   :: T.Text
  }

instance FromRow Message where
  fromRow = Message <$> field <*> field <*> field

--sqlite
--selectMessages :: IO [Message]
--selectMessages = do
--  conn <- SQL.open dbName
--  res <- SQL.query_ conn "SELECT author,title,body FROM messages" 
--         :: IO [Message]
--  SQL.close conn
--  return res

--exemple Postgrsql qui marche

--getMusic :: String -> IO T.Text
--getMusic params = do
--    conn <- P.connectPostgreSQL $ B8.pack params
--    titles <- P.query_ conn "SELECT artists.name, titles.name FROM artists \
--                            \ INNER JOIN titles ON artists.id = titles.artist" :: IO [DbTitle]
--    P.close conn
--    return $ formatTitles titles


selectMessages :: String -> IO [Message]  -- T.Text
selectMessages params = do
  conn <- P.connectPostgreSQL $ B8.pack params
  messages <- P.query_ conn "SELECT author,title,body FROM messages" :: IO [Message]
  P.close conn
  return messages

insertMessage :: String -> Message -> IO ()
insertMessage params msg = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq="INSERT INTO messages (author,title,body) VALUES (?,?,?)" 
    P.execute conn rq (author msg, title msg, body msg)
    P.close conn

