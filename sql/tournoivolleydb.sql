
-- Table: public.tournoi

DROP TABLE public.matchs;
DROP TABLE public.poule;
DROP TABLE public.terrains_poule;
DROP TABLE public.equipes_terrain_poule;

DROP TABLE public.phase;
DROP TABLE public.terrain;
DROP TABLE public.equipe;

DROP TABLE public.tournoi;



CREATE TABLE public.tournoi
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 100 MINVALUE 100 MAXVALUE 100000 CACHE 1 ),
    libelle text COLLATE pg_catalog."default" NOT NULL,
    categorie text COLLATE pg_catalog."default",
    date_tournoi text COLLATE pg_catalog."default",
    nb_terrains integer,
    nb_phases integer,
    CONSTRAINT tournoi_pkey PRIMARY KEY (id)
);


-- Table: public.terrain
CREATE TABLE public.terrain
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    libelle text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT terrain_tournoi_pkey PRIMARY KEY (id)
);



-- Table: public.equipe
CREATE TABLE public.equipe
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 0 MINVALUE 0 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    nom text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT equipe_pkey PRIMARY KEY (id)
);


-- Table: public.phase
CREATE TABLE public.phase
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    libelle text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT phase_tournoi_pkey PRIMARY KEY (id)
);


-- Table: public.poule
CREATE TABLE public.poule
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    id_phase integer NOT NULL,
    libelle text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT poule_tournoi_pkey PRIMARY KEY (id)
);


-- Table: public.terrains_poule
CREATE TABLE public.terrains_poule
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    id_phase integer NOT NULL,
    id_terrain integer NOT NULL,
    id_poule integer NOT NULL,
    libelle text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT terrains_poule_pkey PRIMARY KEY (id)
);

 -- Table: public.equipes_terrain_poule
CREATE TABLE public.equipes_terrain_poule
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 100000 CACHE 1 ),
    id_tournoi integer NOT NULL,
    id_phase integer NOT NULL,
    id_terrain integer NOT NULL,
    id_poule integer NOT NULL,
    id_equipe integer NOT NULL,
    libelle text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT equipes_terrain_poule_pkey PRIMARY KEY (id)
);


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


