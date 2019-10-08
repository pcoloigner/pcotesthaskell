{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module View 
    ( homeRoute
    , writeRoute
    , tournoiRoute
    , equipeRoute
    ) where

import qualified Data.Text as T
import qualified Data.Text.Lazy as L
import           Lucid

import qualified Model
import qualified ModelVolley


homeRoute :: [Model.Message] -> L.Text
homeRoute messages = renderText $ do
  doctype_
  html_ $ body_ $ do
      h1_ "Mon blog sur Haskell"
      mapM_ formatMessage messages
      a_ [href_ "write"] "Écrire un message..."
      br_ []
      br_ []
      a_ [href_ "tournois"] "Tournois"
      br_ []
      br_ []
      a_ [href_ "equipes"] "Équipes"
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


tournoiRoute :: [ModelVolley.Tournoi] -> L.Text
tournoiRoute tournois = renderText $ do
  doctype_
  html_ $ body_ $ do
      h1_ "Mon programme de tournoi de volleyblog sur Haskell"
      mapM_ formatTournoi tournois
      --a_ [href_ "write"] "Écrire un message..."
  where formatTournoi :: ModelVolley.Tournoi -> Html ()
        formatTournoi tournoi = div_ $ do
          strong_ $ toHtml $ ModelVolley.libelleTournoi tournoi
          toHtml $ T.concat [ " par ", ModelVolley.categorie tournoi ]
          div_ $ toHtml $ ModelVolley.date tournoi
          br_ []

equipeRoute :: [ModelVolley.Equipe] -> L.Text
equipeRoute equipes = renderText $ do
  doctype_
  html_ $ body_ $ do
      h1_ "Les équipes du tournoi de volley Haskell"
      mapM_ formatEquipe equipes
  where formatEquipe :: ModelVolley.Equipe -> Html ()
        formatEquipe equipe = div_ $ do
          toHtml $ T.concat [ T.pack $ show $ ModelVolley.idEquipe equipe, " - ", ModelVolley.nom equipe ]
--          toHtml $ T.concat [ " - ", ModelVolley.nom equipe ]
          br_ []
