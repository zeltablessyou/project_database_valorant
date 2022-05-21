-- Name of script :
--              Prototype 1

-- Author Serge Sicot
-- Last update :
--               -/-/2021

-- Database : db_valorant
-- User : 
-- Password : 

-- --------------------------------------------------------
-- -----------------    ***    ----------------------------
-- --------------------------------------------------------

--
-- Création de la base de donnée db_valorant
--


CREATE DATABASE IF NOT EXISTS db_valorant CHARACTER SET utf8;
USE db_valorant;

-- --------------------------------------------------------


--
-- Suppression des tables
--

DROP TABLE IF EXISTS PORTER;
DROP TABLE IF EXISTS ACHETER;
DROP TABLE IF EXISTS CHOISIR;
DROP TABLE IF EXISTS POSSEDER;
DROP TABLE IF EXISTS TAGGUER;
DROP TABLE IF EXISTS AFFICHER;
DROP TABLE IF EXISTS ACCROCHER;
DROP TABLE IF EXISTS JOUER_AVEC;
DROP TABLE IF EXISTS Compte;
DROP TABLE IF EXISTS Joueur;
DROP TABLE IF EXISTS Skins;
DROP TABLE IF EXISTS Armes;
DROP TABLE IF EXISTS Partie;
DROP TABLE IF EXISTS Type_arme;
DROP TABLE IF EXISTS Sort;
DROP TABLE IF EXISTS Personnage;
DROP TABLE IF EXISTS Ranks;
DROP TABLE IF EXISTS Porte_bonheur;
DROP TABLE IF EXISTS Banniere;
DROP TABLE IF EXISTS Graffiti;
DROP TABLE IF EXISTS Maps;
DROP TABLE IF EXISTS Mode_de_jeu;

--
--Création des tables
--

CREATE TABLE Mode_de_jeu(
   idMode INT,
   nomMode VARCHAR(50),
   PRIMARY KEY(idMode)
)ENGINE=InnoDB;

CREATE TABLE Maps(
   idMap INT,
   nomMap VARCHAR(50),
   PRIMARY KEY(idMap)
)ENGINE=InnoDB;

CREATE TABLE Graffiti(
   idGraffi INT,
   nomGraffi VARCHAR(50),
   PRIMARY KEY(idGraffi)
)ENGINE=InnoDB;

CREATE TABLE Banniere(
   idBan INT,
   nomBan VARCHAR(50),
   PRIMARY KEY(idBan)
)ENGINE=InnoDB;

CREATE TABLE Porte_bonheur(
   idPortebonheur INT,
   nomPortebonheur VARCHAR(50),
   PRIMARY KEY(idPortebonheur)
)ENGINE=InnoDB;

CREATE TABLE Ranks(
   idRanks INT,
   nomRank VARCHAR(50),
   PRIMARY KEY(idRanks)
)ENGINE=InnoDB;

CREATE TABLE Personnage(
   idPerso INT,
   nomPerso VARCHAR(50),
   typePerso VARCHAR(50),
   PRIMARY KEY(idPerso)
)ENGINE=InnoDB;

CREATE TABLE Sort(
   idSort INT,
   nomSort VARCHAR(50),
   idPerso INT NOT NULL,
   PRIMARY KEY(idSort),
   CONSTRAINT idPerso_fk1 FOREIGN KEY(idPerso) REFERENCES Personnage(idPerso)
)ENGINE=InnoDB;

CREATE TABLE Type_arme(
   idTypeArme INT,
   typeArme VARCHAR(50),
   PRIMARY KEY(idTypeArme)
)ENGINE=InnoDB;

CREATE TABLE Partie(
   idPartie INT,
   datePartie DATE,
   idMode INT NOT NULL,
   idMap INT NOT NULL,
   PRIMARY KEY(idPartie),
   CONSTRAINT idMode_fk1 FOREIGN KEY(idMode) REFERENCES Mode_de_jeu(idMode),
   CONSTRAINT idMap_fk1 FOREIGN KEY(idMap) REFERENCES Maps(idMap)
)ENGINE=InnoDB;

CREATE TABLE Armes(
   idArmes INT,
   nomArme VARCHAR(50),
   idTypeArme INT NOT NULL,
   PRIMARY KEY(idArmes),
   CONSTRAINT idTypeArme_fk1 FOREIGN KEY(idTypeArme) REFERENCES Type_arme(idTypeArme)
)ENGINE=InnoDB;

CREATE TABLE Skins(
   idSkin INT,
   nomSkin VARCHAR(50),
   idArmes INT NOT NULL,
   PRIMARY KEY(idSkin),
   CONSTRAINT idArmes_fk1 FOREIGN KEY(idArmes) REFERENCES Armes(idArmes)
)ENGINE=InnoDB;

CREATE TABLE Joueur(
   idJoueur INT,
   pseudoJoueur VARCHAR(30),
   idRanks INT NOT NULL,
   idPartie INT NOT NULL,
   PRIMARY KEY(idJoueur),
   CONSTRAINT idRanks_fk1 FOREIGN KEY(idRanks) REFERENCES Ranks(idRanks),
   CONSTRAINT idPartie_fk1 FOREIGN KEY(idPartie) REFERENCES Partie(idPartie)
)ENGINE=InnoDB;

CREATE TABLE Compte(
   idCompte INT,
   email VARCHAR(50),
   mdpCompte VARCHAR(50),
   idJoueur INT NOT NULL,
   PRIMARY KEY(idCompte),
   UNIQUE(idJoueur),
   CONSTRAINT idJoueur_fk1 FOREIGN KEY(idJoueur) REFERENCES Joueur(idJoueur)
)ENGINE=InnoDB;

CREATE TABLE JOUER_AVEC(
   idJoueur INT,
   idJoueur_1 INT,
   PRIMARY KEY(idJoueur, idJoueur_1),
   CONSTRAINT idJoueur_fk2 FOREIGN KEY(idJoueur) REFERENCES Joueur(idJoueur),
   CONSTRAINT idJoueur_fk3 FOREIGN KEY(idJoueur_1) REFERENCES Joueur(idJoueur)
)ENGINE=InnoDB;

CREATE TABLE ACCROCHER(
   idCompte INT,
   idPortebonheur INT,
   PRIMARY KEY(idCompte, idPortebonheur),
   CONSTRAINT idCompte_fk1 FOREIGN KEY(idCompte) REFERENCES Compte(idCompte),
   CONSTRAINT idPortebonheur_fk1 FOREIGN KEY(idPortebonheur) REFERENCES Porte_bonheur(idPortebonheur)
)ENGINE=InnoDB;

CREATE TABLE AFFICHER(
   idCompte INT,
   idBan INT,
   PRIMARY KEY(idCompte, idBan),
   CONSTRAINT idBan_fk1 FOREIGN KEY(idBan) REFERENCES Banniere(idBan),
   CONSTRAINT idCompte_fk2 FOREIGN KEY(idCompte) REFERENCES Compte(idCompte)
)ENGINE=InnoDB;

CREATE TABLE TAGGUER(
   idCompte INT,
   idGraffi INT,
   PRIMARY KEY(idCompte, idGraffi),
   CONSTRAINT idCompte_fk3 FOREIGN KEY(idCompte) REFERENCES Compte(idCompte),
   CONSTRAINT idGraffi_fk1 FOREIGN KEY(idGraffi) REFERENCES Graffiti(idGraffi)
)ENGINE=InnoDB;

CREATE TABLE POSSEDER(
   idCompte INT,
   idPerso INT,
   PRIMARY KEY(idCompte, idPerso),
   CONSTRAINT idCompte_fk4 FOREIGN KEY(idCompte) REFERENCES Compte(idCompte)
)ENGINE=InnoDB;

CREATE TABLE CHOISIR(
   idJoueur INT,
   idPerso INT,
   PRIMARY KEY(idJoueur, idPerso),
   CONSTRAINT idJoueur_fk4 FOREIGN KEY(idJoueur) REFERENCES Joueur(idJoueur),
   CONSTRAINT idPerso_fk3 FOREIGN KEY(idPerso) REFERENCES Personnage(idPerso)
)ENGINE=InnoDB;

CREATE TABLE ACHETER(
   idJoueur INT,
   idArmes INT,
   PRIMARY KEY(idJoueur, idArmes),
   CONSTRAINT idJoueur_fk5 FOREIGN KEY(idJoueur) REFERENCES Joueur(idJoueur),
   CONSTRAINT idArmes_fk2 FOREIGN KEY(idArmes) REFERENCES Armes(idArmes)
)ENGINE=InnoDB;

CREATE TABLE PORTER(
   idCompte INT,
   idSkin INT,
   PRIMARY KEY(idCompte, idSkin),
   CONSTRAINT idCompte_fk5 FOREIGN KEY(idCompte) REFERENCES Compte(idCompte),
   CONSTRAINT idSkin_fk1 FOREIGN KEY(idSkin) REFERENCES Skins(idSkin)
)ENGINE=InnoDB;

-- Insertion des valeurs dans la table Mode_de_jeu --

INSERT INTO Mode_de_jeu (idMode, nomMode) VALUES
(1, 'NON CLASSE'),
(2, 'COMPETITION'),
(3, 'SPIKE RUSH'),
(4, 'COMBAT A MORT'),
(5, 'INTENSIFICATION'),
(6, 'PARTIE PERSONNALISEE');


-- Insertion des valeurs dans la table Maps --

INSERT INTO Maps (idMap, nomMap) VALUES
(1, 'Bind'),
(2, 'Haven'),
(3, 'Split'),
(4, 'Ascent'),
(5, 'Icebox'),
(6, 'Shooting Range');


-- Insertion des valeurs dans la table Graffiti --

INSERT INTO Graffiti (idGraffi, nomGraffi) VALUES
(1, 'You Better Run'),
(2, 'Danger'),
(3, 'On Target'),
(4, 'Solar Flair'),
(5, 'Take Flight'),
(6, 'Getting Reps');

-- Insertion des valeurs dans la table Banniere --

INSERT INTO Banniere (idBan, nomBan) VALUES
(1, 'Ascent'),
(2, 'Sunrise'),
(3, 'Valorant Breach'),
(4, 'Valorant Brimstone'),
(5, 'Code Red'),
(6, 'Rising Up');

-- Insertion des valeurs dans la table Porte_bonheur --

INSERT INTO Porte_bonheur (idPortebonheur, nomPortebonheur) VALUES
(1, 'Marteau du temps copain'),
(2, 'Bullet Buddy'),
(3, 'Copain de pièce bêta fermée'),
(4, 'Blast Pin'),
(5, 'Donut Buddy'),
(6, 'Ascent Rising Buddy');


-- Insertion des valeurs dans la table Ranks --

INSERT INTO Ranks (idRanks, nomRank) VALUES
(1, 'Fer 1'),
(2, 'Fer 2'),
(3, 'Fer 3'),
(4, 'Argent 1'),
(5, 'Argent 2'),
(6, 'Argent 3'),
(7, 'Or 1'),
(8, 'Or 2'),
(9, 'Or 3'),
(10, 'Platine 1'),
(11, 'Platine 2'),
(12, 'Platine 3'),
(13, 'Diamant 1'),
(14, 'Diamant 2'),
(15, 'Diamant 3'),
(16, 'Immortel 1'),
(17, 'Immortel 2'),
(18, 'Immortel 3'),
(19, 'Radiant');


-- Insertion des valeurs dans la table Personnage --

INSERT INTO Personnage (idPerso, nomPerso, typePerso) VALUES
(1, 'Astra', 'Controller'),
(2, 'Breach', 'Initiator'),
(3, 'Brimstone', 'Controller'),
(4, 'Cypher', 'Sentinel'),
(5, 'Jett', 'Duelist'),
(6, 'Killjoy', 'Sentinel'),
(7, 'Omen', 'Controller'),
(8, 'Phoenix', 'Duelist'),
(9, 'Raze', 'Duelist'),
(10, 'Reyna', 'Duelist'),
(11, 'Sage', 'Sentinel'),
(12, 'Skye', 'Initiator'),
(13, 'Sova', 'Initiator'),
(14, 'Viper', 'Controller'),
(15, 'Yoru', 'Duelist');


-- Insertion des valeurs dans la table Sort --

INSERT INTO Sort (idSort, nomSort, idPerso) VALUES
(1, 'Gravity Well', 1),
(2, 'Nova Pulse', 1),
(3, 'Nebula/Dissipate', 1),
(4, 'Astral From', 1),
(5, 'Cosmic Divide', 1),
(6, 'Aftershock', 2),
(7, 'Flashpoint', 2),
(8, 'Fault Line', 2),
(9, 'Rolling Thunder', 2),
(11, 'Stim Beacon', 3),
(12, 'Incendiary', 3),
(13, 'Sky Smoke', 3),
(14, 'Orbital Strike', 3),
(15, 'Trapwire', 4),
(16, 'Cyber Cage', 4),
(17, 'Spycam', 4),
(18, 'Neutral Theft', 4),
(19, 'Cloudburst', 5),
(20, 'Updraft', 5),
(21, 'Tailwind', 5),
(23, 'Blade Strom', 5),
(24, 'Nanoswarm', 6),
(25, 'Alarmbot', 6),
(26, 'Turret', 6),
(27, 'Lockdown', 6),
(28, 'Shrouded Step', 7),
(29, 'Paranoia', 7),
(30, 'Dark Cover', 7),
(31, 'From The Shadows', 7),
(32, 'Blaze', 8),
(33, 'Curveball', 8),
(34, 'Hot Hands', 8),
(35, 'Run it Back', 8),
(36, 'Boom Bot', 9),
(37, 'Blast Pack', 9),
(38, 'Paint Shells', 9),
(39, 'Showstopper', 9),
(40, 'Leer', 10),
(41, 'Devour', 10),
(42, 'Dismiss', 10),
(43, 'Empress', 10),
(44, 'Barrier Orb', 11),
(45, 'Slow Orb', 11),
(46, 'Healing Orb', 11),
(47, 'Resurrection', 11),
(48, 'Regrowth', 12),
(49, 'Trailblazer', 12),
(50, 'Guiding Light', 12),
(51, 'Seekers', 12),
(52, 'Owl Drone', 13),
(53, 'Shock Bolt', 13),
(54, 'Recon', 13),
(55, 'Hunters Fury', 13),
(56, 'Snake Bite', 14),
(57, 'Poison Cloud', 14),
(58, 'Toxic Screen', 14),
(59, 'Vipers Pit', 14),
(60, 'Fakeout', 15),
(61, 'Blindside', 15),
(62, 'Gatecrash', 15),
(63, 'Dimensional Drift', 15);


-- Insertion des valeurs dans la table Type_armes --

INSERT INTO Type_arme (idTypeArme, typeArme) VALUES
(1, 'Mitraillette '),
(2, 'Fusil'),
(3, 'Fusil à pompe'),
(4, ' Sniper'),
(5, 'Arme secondaire'),
(6, 'Fusil lourd'),
(7, 'Couteau'),
(8, 'Tout sauf Knife');


--Insertion des valeurs dans la table Partie--

INSERT INTO Partie (idPartie, datePartie, idMode, idMap) VALUES
(1, '2021-02-28', 2, 1),
(2, '2021-03-01', 2, 4),
(3, '2021-03-02', 4, 5),
(4, '2021-03-04', 1, 2);

--Insertion des valeurs dans la table Armes--

INSERT INTO Armes (idArmes, nomArme, idTypeArme) VALUES
(1, 'Classic', 5),
(2, 'Shorty', 5),
(3, 'Frenzy', 5),
(4, 'Ghost', 5),
(5, 'Sheriff', 5),
(6, 'Stinger', 1),
(7, 'Spectre', 1),
(8, 'Bucky', 3),
(9, 'Judge', 3),
(10, 'Bulldog', 2),
(11, 'Guardian', 2),
(12, 'Phantom', 2),
(13, 'Vandal', 2),
(14, 'Marshal', 4),
(15, 'Operator', 4),
(16, 'Ares', 6),
(17, 'Odin', 6),
(18, 'Knife', 7),
(19,'All', 8);

-- Insertion des valeurs dans la table Skin --

INSERT INTO Skins (idSkin, nomSkin, idArmes) VALUES
(1, 'Kingdom Collection', 19),
(2, 'Couture Collection', 19),
(3, 'POLYfox Collection', 19),
(4, 'Red Alert Collection', 19),
(5, 'Hivemind Collection', 19),
(6, 'Ruin Collection', 19),
(7, 'Serenity Collection', 19),
(8, 'Surge Collection', 19);


-- Insertion des valeurs dans la table Joueur --

INSERT INTO Joueur (idJoueur, pseudoJoueur, idRanks, idPartie ) VALUES
(1, 'Xx_Karim_xX', 1, 1),
(2, 'Oddysse', 15, 1),
(3, 'cOrOnAvIRUs', 5, 1),
(4, 'Mache89', 11, 1),
(5, 'Neptune69', 9, 1),
(6, 'Omnysant', 19, 1),
(7, 'Momo74', 13, 1),
(8, 'UBetter2Run', 3, 1),
(9, 'jeje7', 17, 1),
(10, 'iamGroot', 16, 1);



-- Insertion des valeurs dans la table Compte --

INSERT INTO Compte (idCompte, email, mdpCompte, idJoueur) VALUES
(1, 'karim92@hotmail.com', 'karimlebogoss92', 1),
(2, 'olivier.fauchard@gmail.com', 'olioli1992@', 2),
(3, 'pedros123@free.fr', 'Ioapdk9&', 3),
(4, 'julie.laporte@gmail.com', 'Juju2000', 4),
(5, 'press.lucy9@hotmail.com', 'passw0rd1', 5),
(6, 'supercarl981@gmail.com', 'Sup3rcar1', 6),
(7, 'maurice.kalhed@hotmail.com', 'kAlhedmomo7', 7),
(8, 'kalistasssix@gmail.com', 'Lpanfs27', 8),
(9, 'jaaysonn.smith@gmail.com', 'Odcnad123', 9),
(10, 'groot@gmail.com', 'iamGr00t', 10);




-- Insertion des valeurs dans la table JOUER_AVEC --

INSERT INTO JOUER_AVEC(idJoueur, idJoueur_1) VALUES
(1,6),
(2,7),
(3,8),
(4,9),
(5,10);


-- Insertion des valeurs dans la table ACCROCHER --

INSERT INTO ACCROCHER(idCompte, idPortebonheur) VALUES
(1,1),
(1,6),
(5,3),
(5,2),
(8,1);


-- Insertion des valeurs dans la table AFFICHER --

INSERT INTO AFFICHER(idCompte, idBan) VALUES
(1,1),
(3,6),
(5,5),
(2,3),
(8,1);


-- Insertion des valeurs dans la table TAGGUER --

INSERT INTO TAGGUER(idCompte, idGraffi) VALUES
(1,5),
(3,6),
(5,2),
(2,1),
(8,1);


-- Insertion des valeurs dans la table POSSEDER --

INSERT INTO POSSEDER(idCompte, idPerso) VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,7),
(1,9),
(1,10),
(1,6),
(1,15),
(2,2),
(2,6),
(2,8),
(2,12),
(3,1),
(3,3),
(3,7),
(3,8),
(3,9),
(3,13),
(4,3),
(4,4),
(4,6),
(4,7),
(4,10),
(4,13),
(4,14),
(4,15),
(5,1),
(5,2),
(5,3),
(5,4),
(5,7),
(5,9),
(5,10),
(5,6),
(5,15),
(6,2),
(6,6),
(6,8),
(6,12),
(7,1),
(7,3),
(7,7),
(7,8),
(7,9),
(7,13),
(8,3),
(8,4),
(8,7),
(8,10),
(8,13),
(8,14),
(8,15),
(9,1),
(9,3),
(9,7),
(9,8),
(9,9),
(9,13),
(10,3),
(10,4),
(10,7),
(10,10),
(10,13),
(10,14);


-- Insertion des valeurs dans la table CHOISIR --

INSERT INTO CHOISIR(idJoueur, idPerso) VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,7),
(1,9),
(1,10),
(1,6),
(1,15),
(2,2),
(2,6),
(2,8),
(2,12),
(3,1),
(3,3),
(3,7),
(3,8),
(3,9),
(3,13),
(4,3),
(4,4),
(4,6),
(4,7),
(4,10),
(4,13),
(4,14),
(4,15),
(5,1),
(5,2),
(5,3),
(5,4),
(5,7),
(5,9),
(5,10),
(5,6),
(5,15),
(6,2),
(6,6),
(6,8),
(6,12),
(7,1),
(7,3),
(7,7),
(7,8),
(7,9),
(7,13),
(8,3),
(8,4),
(8,7),
(8,10),
(8,13),
(8,14),
(8,15),
(9,1),
(9,3),
(9,7),
(9,8),
(9,9),
(9,13),
(10,3),
(10,4),
(10,7),
(10,10),
(10,13),
(10,14);



-- Insertion des valeurs dans la table ACHETER --

INSERT INTO ACHETER(idJoueur, idArmes) VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(1,11),
(1,12),
(1,13),
(1,14),
(1,15),
(1,16),
(1,17),
(1,18),
(1,19),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(2,6),
(2,7),
(2,8),
(2,9),
(2,10),
(2,11),
(2,12),
(2,13),
(2,14),
(2,15),
(2,16),
(2,17),
(2,18),
(2,19),
(3,1),
(3,2),
(3,3),
(3,4),
(3,5),
(3,6),
(3,7),
(3,8),
(3,9),
(3,10),
(3,11),
(3,12),
(3,13),
(3,14),
(3,15),
(3,16),
(3,17),
(3,18),
(3,19),
(4,1),
(4,2),
(4,3),
(4,4),
(4,5),
(4,6),
(4,7),
(4,8),
(4,9),
(4,10),
(4,11),
(4,12),
(4,13),
(4,14),
(4,15),
(4,16),
(4,17),
(4,18),
(4,19),
(5,1),
(5,2),
(5,3),
(5,4),
(5,5),
(5,6),
(5,7),
(5,8),
(5,9),
(5,10),
(5,11),
(5,12),
(5,13),
(5,14),
(5,15),
(5,16),
(5,17),
(5,18),
(5,19),
(6,1),
(6,2),
(6,3),
(6,4),
(6,5),
(6,6),
(6,7),
(6,8),
(6,9),
(6,10),
(6,11),
(6,12),
(6,13),
(6,14),
(6,15),
(6,16),
(6,17),
(6,18),
(6,19),
(7,1),
(7,2),
(7,3),
(7,4),
(7,5),
(7,6),
(7,7),
(7,8),
(7,9),
(7,10),
(7,11),
(7,12),
(7,13),
(7,14),
(7,15),
(7,16),
(7,17),
(7,18),
(7,19),
(8,1),
(8,2),
(8,3),
(8,4),
(8,5),
(8,6),
(8,7),
(8,8),
(8,9),
(8,10),
(8,11),
(8,12),
(8,13),
(8,14),
(8,15),
(8,16),
(8,17),
(8,18),
(8,19),
(9,1),
(9,2),
(9,3),
(9,4),
(9,5),
(9,6),
(9,7),
(9,8),
(9,9),
(9,10),
(9,11),
(9,12),
(9,13),
(9,14),
(9,15),
(9,16),
(9,17),
(9,18),
(9,19),
(10,1),
(10,2),
(10,3),
(10,4),
(10,5),
(10,6),
(10,7),
(10,8),
(10,9),
(10,10),
(10,11),
(10,12),
(10,13),
(10,14),
(10,15),
(10,16),
(10,17),
(10,18),
(10,19);


-- Insertion des valeurs dans la table PORTER --

INSERT INTO PORTER(idCompte, idSkin) VALUES
(1,5),
(3,6),
(5,2),
(2,1),
(8,1);



----CREATE VIEW----


-- Affiche les infos chaque joueur à l'ordre d'alphabétique de leurs pseudos sans afficher le mdp en raison de sécurité--
--Ce view permet de gagner du temps mais aussi qu'un compte SQL limité de pouvoir d'accéder les infos sans voir les infos sensibles comme le mdp--


DROP VIEW IF EXISTS INFO_JOUEUR;

CREATE VIEW INFO_JOUEUR AS 
SELECT Joueur.idJoueur, pseudoJoueur, idCompte, email
FROM Compte
INNER JOIN Joueur ON Compte.idJoueur=Joueur.idJoueur
ORDER BY pseudoJoueur ASC;



-- Affiche les infos entre les personnages et leurs sorts--
--Gain de temps d'afficher les infos des personnages--


DROP VIEW IF EXISTS INFO_PERSONNAGE;

CREATE VIEW INFO_PERSONNAGE AS 
SELECT Personnage.idPerso, nomPerso, idSort, nomSort
FROM Sort 
INNER JOIN Personnage ON Sort.idPerso=Personnage.idPerso
GROUP BY nomPerso, nomSort;




-- Suppression de clé étrangère
ALTER TABLE PORTER
DROP CONSTRAINT idSkin_fk1;

-- Ajout de clé étrangère
ALTER TABLE POSSEDER
ADD CONSTRAINT idPerso_fk2 FOREIGN KEY(idPerso) REFERENCES Personnage(idPerso);

-- Suppression de colonne
--Pas possible dans cette situation

-- Ajout de colonne
ALTER TABLE Sort
ADD tempsSeconde INT;

-- Suppression de ligne sans clause WHERE
DELETE FROM TAGGUER;

-- Suppression de ligne avec clause WHERE
DELETE FROM Sort
WHERE idPerso = 3;

-- UPDATE sans WHERE
UPDATE Type_arme
SET typeArme = "Armes létales";

-- UPDATE avec WHERE ciblant une seule ligne
UPDATE Armes
SET idTypeArme = 6
WHERE nomArme = "Ghost";

-- UPDATE avec WHERE ciblant plusieurs lignes mais pas toute
UPDATE Armes
SET idTypeArme = 6
WHERE idTypeArme = 5;

-- UPDATE avec opération arithmétique sur un champ numérique
UPDATE Armes
SET idTypeArme = idTypeArme - 1
WHERE idTypeArme = 6;

-- UPDATE sur chaine de caractère
UPDATE Armes
SET nomArme = "pistolet trop fort"
WHERE nomArme = "Ghost";

