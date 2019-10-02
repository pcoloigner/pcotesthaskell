{-# LANGUAGE OverloadedStrings #-}

import System.Environment (getEnv)
import Web.Scotty (get, param, post, redirect, html, scotty)

import Control.Monad.Trans (liftIO)

import qualified Model
import qualified View
import qualified ModelVolley


-- SET DATABASE_URL=postgresql://postgres:baohan@localhost:5432/postgres

main :: IO ()
main = do
    dbParams <- getEnv "DATABASE_URL"
    portStr <- getEnv "PORT"
    let port = read portStr

    scotty port $ do
      get "/" $ do
        messages <- liftIO  $ Model.selectMessages dbParams 
        html $ View.homeRoute messages

      get "/write" $ html View.writeRoute

      post "/" $ do
        author <- param "author"
        title <- param "title"
        body <- param "body"
        liftIO $ Model.insertMessage dbParams  ( Model.Message author title body )
        redirect "/"

      get "/equipes" $ do
        equipes <- liftIO  $ ModelVolley.selectEquipes dbParams 
        html $ View.equipeRoute equipes

      get "/tournois" $ do
        tournois <- liftIO  $ ModelVolley.selectTournois dbParams 
        html $ View.tournoiRoute tournois
