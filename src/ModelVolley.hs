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

terrainIndetermine :: Terrain
terrainIndetermine = Terrain 0 1 "Terrain indetermine"

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
  }
instance FromRow TerrainsPoule where
  fromRow = TerrainsPoule <$> field <*> field <*> field <*> field <*> field 


data EquipesPoule = EquipesPoule  
  { idEP           :: Int 
  , idTournoiEP    :: Int 
  , idPhaseEP      :: Int 
  , idPouleEP      :: Int 
  , idEquipeEP     :: Int 
  }
instance FromRow EquipesPoule where
  fromRow = EquipesPoule <$> field <*> field <*> field <*> field <*> field


data Match = Match  
  { idMatch           :: Int 
  , idTournoiMatch    :: Int 
  , idPhaseMatch      :: Int 
  , idTerrainMatch    :: Int 
  , idPouleMatch      :: Int 
  , idEquipeMatch1    :: Int 
  , idEquipeMatch2    :: Int 
  , idEquipeArbitreMatch :: Int
  , pointsEquipe1  :: Int 
  , pointsEquipe2  :: Int 
  , setsEquipe1    :: Int 
  , setsEquipe2    :: Int 
  , bMatchTermine  :: Bool
  , bEquipe1Vainqueur  :: Bool
  , bEquipe2Vainqueur  :: Bool
  }
instance FromRow Match where
  fromRow = Match <$> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field 

data SimpleMatch = SimpleMatch  
  { idEquipe1    :: Int 
  , idEquipe2    :: Int 
  , idEquipeArbitre :: Int
  }
instance FromRow SimpleMatch where
  fromRow = SimpleMatch <$> field <*> field <*> field  


selectTournois :: String -> IO [Tournoi] 
selectTournois params = do
  conn <- P.connectPostgreSQL $ B8.pack params
  tournois <- P.query_ conn "SELECT libelle,categorie,date_tournoi, nb_terrains, nb_phases FROM tournoi" :: IO [Tournoi]
  P.close conn
  return tournois 

insertTournoi :: String -> Tournoi -> IO ()
insertTournoi params trn = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq="INSERT INTO tournoi (libelle_tournoi,categorie,date_tournoi, nb_terrains, nb_phases) VALUES (?,?,?,1,1)" 
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

--formatMatchs :: [Match] -> T.Text
--formatMatchs = T.intercalate "<br/>\n" . map (\ (a, t) -> T.concat [a, " - ", t]) 


--selectMatchs :: String -> Int -> Int -> Int -> IO [Match]
----selectMatchs :: String -> String -> String -> String -> IO [Match]
--selectMatchs params idtournoi idphase idpoule = do
--    conn <- P.connectPostgreSQL $ B8.pack params
--    --    let rq = "SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_tournoi = ? and  matchs.id_phase = ? and  matchs.id_poule = ?"
--    let rq = "SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_tournoi = 100 and  matchs.id_phase = 1 and  matchs.id_poule = 1"
----    let rq2 = "SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_tournoi = 100 and  matchs.id_phase = 1 and  matchs.id_poule = ?"
--    --    matchs <- P.query_ conn "SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_tournoi = " ++ B8.pack (toString idtournoi) ++ " and  matchs.id_phase = " ++ B8.pack (toString idphase) ++ " and  matchs.id_poule = " ++ B8.pack (toString idpoule)   :: IO [Match]
--    --    matchs <- P.query_ conn $ mconcat ["SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_tournoi = ", toString idtournoi , " and  matchs.id_phase = ", (toString idphase) , " and  matchs.id_poule = " , (toString idpoule) ]  :: IO [Match]
--    --    matchs <- P.query_ conn $ mconcat ["SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_tournoi = ? "  :: IO [Match]
--    matchs <- P.query_ conn rq :: IO [Match]
----    matchs <- P.query_ conn (rq2 idpoule) :: IO [Match]
--  --    matchs <- P.query_ conn (rq (idtournoi, idphase, idpoule)) :: IO [Match]
--    P.close conn
--    return matchs
----    return $ formatTitles titles



--Retourne les matchs d'une poule, d'un tour, d'un tournoi donné.
selectMatchs :: String -> Int -> Int -> Int -> IO [Match]
selectMatchs params idtournoi idphase idpoule = do
    conn <- P.connectPostgreSQL $ B8.pack params
    let rq = "SELECT * FROM matchs WHERE matchs.id_tournoi = 100 and  matchs.id_phase = 1 and  matchs.id_poule = 1"
    matchs <- P.query_ conn rq :: IO [Match]
--    matchs <- P.query_ conn (rq2 idpoule) :: IO [Match]
  --    matchs <- P.query_ conn (rq (idtournoi, idphase, idpoule)) :: IO [Match]
    P.close conn
    return matchs




----Retourne les matchs d'une poule, d'un tour, d'un tournoi donné.
--selectSimpleMatchs :: String -> Int -> IO [SimpleMatch]
--selectSimpleMatchs params idpoule = do
--    conn <- P.connectPostgreSQL $ B8.pack params
--    let rq2 = "SELECT matchs.id_equipe_1 , matchs.id_equipe_2 , matchs.id_equipe_arbitre FROM matchs WHERE matchs.id_poule = ?"
--    matchs <- P.query_ conn (rq2 idpoule) :: IO [SimpleMatch]
--    P.close conn
--    return matchs



--insertMessage :: String -> Message -> IO ()
--insertMessage params msg = do
--    conn <- P.connectPostgreSQL $ B8.pack params
--    let rq="INSERT INTO messages (author,title,body) VALUES (?,?,?)" 
--    P.execute conn rq (author msg, title msg, body msg)
--    P.close conn







--selectMatchs :: String -> IO T.Text
--selectMatchs params = do
--    conn <- P.connectPostgreSQL $ B8.pack params
--    titles <- P.query_ conn "SELECT artists.name, titles.name FROM artists \
--                            \ INNER JOIN titles ON artists.id = titles.artist" :: IO [DbTitle]
--    P.close conn
--    return $ formatTitles titles


