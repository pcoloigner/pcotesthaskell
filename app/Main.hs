{-# LANGUAGE OverloadedStrings #-}

--import qualified Data.Text as T
--import qualified Data.Text.Lazy as L
import System.Environment (getEnv)
import Web.Scotty (get, param, post, redirect, html, scotty)

import Control.Monad.Trans (liftIO)
--import qualified Data.ByteString.Char8 as B8
--import qualified Database.PostgreSQL.Simple as P

import qualified Model
import qualified View

--type DbTitle = (T.Text, T.Text)

--formatTitles :: [DbTitle] -> T.Text
--formatTitles = T.intercalate "<br/>\n" . map (\ (a, t) -> T.concat [a, " - ", t]) 

--getMusic :: String -> IO T.Text
--getMusic params = do
--    conn <- P.connectPostgreSQL $ B8.pack params
--    titles <- P.query_ conn "SELECT artists.name, titles.name FROM artists \
--                            \ INNER JOIN titles ON artists.id = titles.artist" :: IO [DbTitle]
--    P.close conn
--    return $ formatTitles titles

main :: IO ()
main = do
    dbParams <- getEnv "DATABASE_URL"
    portStr <- getEnv "PORT"
    let port = read portStr

    scotty port $ do
--        get "/" $ do
--            music <- liftIO $ getMusic dbParams
--            html $ L.fromStrict $ music
      get "/" $ do
--        messages <- liftIO Model.selectMessages
        messages <- liftIO  $ Model.selectMessages dbParams 
        html $ View.homeRoute messages

      get "/write" $ html View.writeRoute

      post "/" $ do
        author <- param "author"
        title <- param "title"
        body <- param "body"
        liftIO $ Model.insertMessage dbParams  ( Model.Message author title body )
        redirect "/"

--port = 3000
--main = scotty port $ do
