{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module View 
    ( homeRoute
    , writeRoute
    ) where

import qualified Data.Text as T
import qualified Data.Text.Lazy as L
import           Lucid

import qualified Model

homeRoute :: [Model.Message] -> L.Text
homeRoute messages = renderText $ do
  doctype_
  html_ $ body_ $ do
      h1_ "Mon blog sur Haskell"
      mapM_ formatMessage messages
      a_ [href_ "write"] "Écrire un message..."
  where formatMessage :: Model.Message -> Html ()
        formatMessage message = div_ $ do
          strong_ $ toHtml $ Model.title message
          toHtml $ T.concat [ " par ", Model.author message ]
          div_ $ toHtml $ Model.body message
          br_ []

writeRoute :: L.Text
writeRoute = renderText $ do
  doctype_
  html_ $ body_ $ do
    h1_ "Écrire un message"
    form_ [action_ "/", method_ "post"] $ do
      p_ "auteur: " >> input_ [name_ "author"]
      p_ "titre: " >> input_ [name_ "title"]
      p_ "corps: " >> 
        textarea_ [name_ "body", rows_ "5", cols_ "60"] ""
      p_ $ input_ [type_ "submit", value_ "Valider"]
    form_ [action_ "/", method_ "get"] $ 
      input_ [type_ "submit", value_ "Annuler"]

