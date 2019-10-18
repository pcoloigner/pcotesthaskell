
-- Donnees

--INSERT INTO public.tournoi(id, libelle, categorie, date_tournoi, nb_terrains, nb_phases) VALUES (?, ?, ?, ?, ?, ?);
--INSERT INTO public.equipe(id, id_tournoi, nom) VALUES (?, ?, ?);

INSERT INTO public.tournoi(libelle, categorie, date_tournoi, nb_terrains, nb_phases) 
VALUES ('Tournoi du Téléthon 2019', 'Loisirs', '07/10/2019', 3, 1);


INSERT INTO public.terrain(id_tournoi, libelle)  VALUES (100, 'Terrain 1');
INSERT INTO public.terrain(id_tournoi, libelle)  VALUES (100, 'Terrain 2');
INSERT INTO public.terrain(id_tournoi, libelle)  VALUES (100, 'Terrain 3');


INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 1');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 2');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 3');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 4');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 5');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 6');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 7');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 8');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 9');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 10');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 11');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 12');
INSERT INTO public.equipe(id_tournoi, nom) VALUES (100, 'Equipe 13');

INSERT INTO public.phase(id_tournoi, libelle) VALUES (100, 'Tour unique');

INSERT INTO public.poule(id_tournoi, id_phase, libelle) VALUES (100, 1, 'Poule unique');


INSERT INTO public.terrains_poule(id_tournoi, id_phase, id_terrain, id_poule) VALUES(100, 1, 1, 1);
INSERT INTO public.terrains_poule(id_tournoi, id_phase, id_terrain, id_poule) VALUES(100, 1, 2, 1);
INSERT INTO public.terrains_poule(id_tournoi, id_phase, id_terrain, id_poule) VALUES(100, 1, 3, 1);

INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 1);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 2);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 3);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 4);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 5);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 6);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 7);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 8);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 9);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 10);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 11);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 12);
INSERT INTO public.equipes_poule(id_tournoi, id_phase, id_poule, id_equipe) VALUES( 100, 1, 1, 13);

 

-- Table: public.matchs
CREATE TABLE public.matchs
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    id_phase integer NOT NULL,
    id_terrain integer NOT NULL,
    id_poule integer NOT NULL,
    id_equipe_1 integer NOT NULL,
    id_equipe_2 integer NOT NULL,
    id_equipe_arbitre integer,
    points_eq1 integer,
    points_eq2 integer,
    sets_eq1 integer,
    sets_eq2 integer,
    b_match_fini boolean,
    b_eq1_vainqueur boolean,
    b_eq2_vainqueur boolean,
    CONSTRAINT matchs_pkey PRIMARY KEY (id)
);

--INSERT INTO public.matchs(
--	id, id_tournoi, id_phase, id_terrain, id_poule,   id_equipe_1, id_equipe_2, id_equipe_arbitre, points_eq1, points_eq2, sets_eq1, sets_eq2, b_match_fini, b_eq1_vainqueur, b_eq2_vainqueur)
--	VALUES (?, 100, 1, 1, 1,   	1, 2, ?, ?, ?, ?, ?, ?, ?, ?);

INSERT INTO public.matchs(id_tournoi, id_phase, id_terrain, id_poule, id_equipe_1, id_equipe_2) VALUES (100, 1, 1, 1,  1, 2);	
INSERT INTO public.matchs(id_tournoi, id_phase, id_terrain, id_poule, id_equipe_1, id_equipe_2) VALUES (100, 1, 1, 1,  3, 4);	
INSERT INTO public.matchs(id_tournoi, id_phase, id_terrain, id_poule, id_equipe_1, id_equipe_2) VALUES (100, 1, 1, 1,  5, 6);	
INSERT INTO public.matchs(id_tournoi, id_phase, id_terrain, id_poule, id_equipe_1, id_equipe_2) VALUES (100, 1, 1, 1,  7, 8);	
