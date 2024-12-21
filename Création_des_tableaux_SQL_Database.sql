
--- CREATION DES TABLES

-- Création de la table Bien


CREATE TABLE Bien (
    Id_Bien INT  ,
    BTQ  VARCHAR(50) , 
    No_voie INT ,
    Type_de_voie VARCHAR(50) , 
    Voie VARCHAR(50) , 
    Surface_Carrez float, 
    Appartement VARCHAR(50) , 
    Surface_reelle_bati float , 
    Total_piece INT , 
    Nom_Com VARCHAR(50) , 
    Code_commune INT
);


DROP TABLE IF EXISTS Vente;

CREATE TABLE Vente (
    Id_Vente INTEGER,
    Date DATE,
    Valeur NUMERIC
);



CREATE TABLE Region (
    REG Integer,
	CHEFLIEU numeric,
	TNCC INT ,
	NCC Varchar(50),
	NCCENR Varchar(50),
	LIBELLE Varchar(50)
);



CREATE TABLE Commune (
    CODREG INT,
	CODDEP Varchar(50),
	CODARR Varchar(50) ,
	CODCOM INT,
	COM Varchar(50),
	PTOT numeric
);


---- Ajout des clé primaires pour faire la references aux tables concernés
ALTER TABLE Commune 
ADD CONSTRAINT fk_codreg 
FOREIGN KEY (CODREG) 
REFERENCES Region (REG);

---- Ajout des clés primaires pour chaque tables 

ALTER TABLE Bien
ADD CONSTRAINT PK_Bien PRIMARY KEY (Id_Bien);

ALTER TABLE Region
ADD CONSTRAINT PK_Region PRIMARY KEY (REG);

ALTER TABLE Vente DROP COLUMN Id_Vente;
ALTER TABLE vente
ADD column Id_vente SERIAL PRIMARY KEY; 

ALTER TABLE commune ADD COLUMN Commune_Id SERIAL PRIMARY KEY;

ALTER TABLE Bien Rename COLUMN Appartement to type_locale;




