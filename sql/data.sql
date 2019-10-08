
-- Table: public.tournoi

DROP TABLE public.tournoi;

CREATE TABLE public.tournoi
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 100 MINVALUE 100 MAXVALUE 100000 CACHE 1 ),
    libelle text COLLATE pg_catalog."default" NOT NULL,
    categorie text COLLATE pg_catalog."default",
    date text COLLATE pg_catalog."default",
    nb_terrains integer
    CONSTRAINT tournoi_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

--ALTER TABLE public.tournoi OWNER to qeefmfcmtfpjxj;