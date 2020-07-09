CREATE SCHEMA assureautoo;
USE assureautoo;

CREATE TABLE contrat IF NOT EXISTS(
CO_ID INT NOT NULL PRIMARY KEY,
CO_date DATE NOT NULL,
CO_catagorie VARCHAR(30) NOT NULL,
CO_avenant VARCHAR (20) NOT NULL,
CO_bonus VARCHAR (20) NOT NULL,
CO_Manus VARCHAR (20) NOT NULL);


CREATE TABLE clients IF NOT EXISTS(
CL_ID INT NOT NULL,
CL_Nom VARCHAR (20) NOT NULL,
CL_Prenom VARCHAR (20) NOT NULL,
CL_Adresse VARCHAR (20) NOT NULL,
CL_Vill VARCHAR (20) NOT NULL,
CL_Tel VARCHAR (20) NOT NULL,
CL_CONTRAT_FK INT NOT NULL,
FOREIGN KEY (CL_CONTRAT_FK) REFERENCES contrat(CO_ID));

INSERT INTO contrat(CO_ID,CO_date,CO_catagorie,CO_avenant,CO_bonus,CO_Manus) VALUES
(1,'2020-06-10', 'commerciel', 'not done', 5,2),
(2,'2020-06-10', 'utilite', 'yet to done', 3,2),
(3,'2020-06-10', 'commerciel', 'done', 2,2),
(4,'2020-06-10', 'utilite', 'done', 1,2);

INSERT INTO clients(CL_ID,CL_Nom,CL_Prenom,CL_Adresse,CL_Vill,CL_Tel,CL_CONTRAT_FK) VALUES
(9, 'PAUL', 'DEBO', '22 avenue', 'cannes', 067809890, 3),
(5, 'Bonnet', 'CHARELES', '33 avenue', 'Antibes', 908798098, 4);

SELECT * FROM contrat;

SELECT * FROM clients;

