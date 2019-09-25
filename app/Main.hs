{-# LANGUAGE OverloadedStrings #-}

import qualified Data.Text as T
import qualified Data.Text.Lazy as L
import System.Environment (getEnv)
import Web.Scotty (get, html, scotty)

import Control.Monad.Trans (liftIO)
import qualified Data.ByteString.Char8 as B8
import qualified Database.PostgreSQL.Simple as P

type DbTitle = (T.Text, T.Text)

formatTitles :: [DbTitle] -> T.Text
formatTitles = T.intercalate "<br/>\n" . map (\ (a, t) -> T.concat [a, " - ", t]) 

getMusic :: String -> IO T.Text
getMusic params = do
    conn <- P.connectPostgreSQL $ B8.pack params
    titles <- P.query_ conn "SELECT artists.name, titles.name FROM artists \
                            \ INNER JOIN titles ON artists.id = titles.artist" :: IO [DbTitle]
    P.close conn
    return $ formatTitles titles

main :: IO ()
main = do
    dbParams <- getEnv "DATABASE_URL"
    portStr <- getEnv "PORT"
    let port = read portStr

    scotty port $ do
        get "/" $ do
            music <- liftIO $ getMusic dbParams
            html $ L.fromStrict $ music
