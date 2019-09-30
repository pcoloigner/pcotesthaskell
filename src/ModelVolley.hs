{-# LANGUAGE OverloadedStrings #-}

module ModelVolley where

import qualified Data.Text as T
import qualified Data.ByteString.Char8 as B8
import qualified Database.PostgreSQL.Simple as P
import Database.PostgreSQL.Simple.FromRow (FromRow, fromRow, field)

data Tournoi = Tournoi 
  { libelle    :: T.Text
  , categorie  :: T.Text
  , date       :: T.Text
  }

instance FromRow Tournoi where
  fromRow = Tournoi <$> field <*> field <*> field

data Equipe = Equipe
  { idTournoi :: Int 
  , nom       :: T.Text
  }

instance FromRow Equipe where
  fromRow = Equipe <$> field <*> field 


selectTournois :: String -> IO [Tournoi] 
selectTournois params = do
  conn <- P.connectPostgreSQL $ B8.pack params
  tournois <- P.query_ conn "SELECT libelle,categorie,date FROM tournoi" :: IO [Tournoi]
  P.close conn
  return tournois 

insertTournoi :: String -> Tournoi -> IO ()
insertTournoi params trn = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq="INSERT INTO tournoi (libelle,categorie,date) VALUES (?,?,?)" 
    P.execute conn rq (libelle trn, categorie trn, date trn)
    P.close conn

selectEquipes :: String -> IO [Equipe] 
selectEquipes params = do
  conn <- P.connectPostgreSQL $ B8.pack params
  equipes <- P.query_ conn "SELECT id_tournoi,nom FROM equipe" :: IO [Equipe]
  P.close conn
  return equipes 

insertEquipe :: String -> Equipe -> IO ()
insertEquipe params eqp = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq="INSERT INTO equipe (id_tournoi,nom) VALUES (?,?)" 
    P.execute conn rq (idTournoi eqp, nom eqp)
    P.close conn


-- Ancien test
--type DbTitle = (T.Text, T.Text)

--formatTitles :: [DbTitle] -> T.Text
--formatTitles = T.intercalate "<br/>\n" . map (\ (a, t) -> T.concat [a, " - ", t]) 

