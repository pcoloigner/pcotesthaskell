{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}

module ModelVolley where

import qualified Data.Text as T
import qualified Data.ByteString.Char8 as B8
import qualified Database.PostgreSQL.Simple as P
import Database.PostgreSQL.Simple.FromRow (FromRow, fromRow, field)

data Tournoi = Tournoi 
  { libelleTournoi  :: T.Text
  , categorie    :: T.Text
  , date :: T.Text
  , nbTerrains   :: Int
  , nbPhases     :: Int
  }
instance FromRow Tournoi where
  fromRow = Tournoi <$> field <*> field <*> field <*> field <*> field


data Equipe = Equipe
  { idEquipe :: Int
  , idTournoiEquipe :: Int 
  , nom       :: T.Text
  }
instance FromRow Equipe where
  fromRow = Equipe <$> field <*> field <*> field 


data Terrain = Terrain
  { idTerrain        :: Int
  , idTournoiTerrain :: Int 
  , libelleTerrain   :: T.Text
  }
instance FromRow Terrain where
  fromRow = Terrain <$> field <*> field <*> field 


data Phase = Phase
  { idPhase        :: Int
  , idTournoiPhase :: Int 
  , libellePhase :: T.Text
  }
instance FromRow Phase where
  fromRow = Phase <$> field <*> field <*> field 


data Poule = Poule 
  { idPoule           :: Int
  , idTournoiPoule    :: Int 
  , idPhasePoule      :: Int 
  , libellePoule      :: T.Text
  }
instance FromRow Poule where
  fromRow = Poule <$> field <*> field <*> field <*> field




data TerrainsPoule = TerrainsPoule  
  { idTerrainsPoule           :: Int
  , idTournoiTerrainsPoule    :: Int 
  , idPhaseTerrainsPoule      :: Int 
  , idTerrainTerrainsPoule    :: Int 
  , idPouleTerrainsPoule      :: Int 
  , libelleTp      :: T.Text
  }
instance FromRow TerrainsPoule where
  fromRow = TerrainsPoule <$> field <*> field <*> field <*> field <*> field <*> field


data EquipesTerrainsPoule = EquipesTerrainsPoule  
  { idETP           :: Int 
  , idTournoiETP    :: Int 
  , idPhaseETP      :: Int 
  , idTerrainETP    :: Int 
  , idPouleETP      :: Int 
  , idEquipeETP     :: Int 
  , libelleETP      :: T.Text
  }
instance FromRow EquipesTerrainsPoule where
  fromRow = EquipesTerrainsPoule <$> field <*> field <*> field <*> field <*> field <*> field <*> field


data Matchs = Matchs  
  { idMatch           :: Int 
  , idTournoiMatch    :: Int 
  , idPhaseMatch      :: Int 
  , idTerrainMatch    :: Int 
  , idPouleMatch      :: Int 
  , idEquipe1    :: Int 
  , idEquipe2    :: Int 
  , pointsEquipe1  :: Int 
  , pointsEquipe2  :: Int 
  , setsEquipe1    :: Int 
  , setsEquipe2    :: Int 
  , bMatchTermine  :: Bool
  , bEquipe1Vainqueur  :: Bool
  , bEquipe2Vainqueur  :: Bool
  }
instance FromRow Matchs where
  fromRow = Matchs <$> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field 


selectTournois :: String -> IO [Tournoi] 
selectTournois params = do
  conn <- P.connectPostgreSQL $ B8.pack params
  tournois <- P.query_ conn "SELECT libelle,categorie,date_tournoi, nb_terrains, nb_phases FROM tournoi" :: IO [Tournoi]
  P.close conn
  return tournois 

insertTournoi :: String -> Tournoi -> IO ()
insertTournoi params trn = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq="INSERT INTO tournoi (libelle_tournoi,categorie,date_tournoi, nb_terrains, nb_phases) VALUES (?,?,?,?,?)" 
    P.execute conn rq (libelleTournoi trn, categorie trn, date trn)
    P.close conn

selectEquipes :: String -> IO [Equipe] 
selectEquipes params = do
  conn <- P.connectPostgreSQL $ B8.pack params
  equipes <- P.query_ conn "SELECT id, id_tournoi,nom FROM equipe" :: IO [Equipe]
  P.close conn
  return equipes 

insertEquipe :: String -> Equipe -> IO ()
insertEquipe params eqp = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq="INSERT INTO equipe (id_tournoi,nom) VALUES (?,?)" 
    P.execute conn rq (idTournoiEquipe eqp, nom eqp)
    P.close conn


-- Ancien test
--type DbTitle = (T.Text, T.Text)

--formatTitles :: [DbTitle] -> T.Text
--formatTitles = T.intercalate "<br/>\n" . map (\ (a, t) -> T.concat [a, " - ", t]) 






