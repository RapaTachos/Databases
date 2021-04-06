DROP TABLE IF EXISTS JOGADOR, EQUIPA, JOGA_POR, ESTADIO,
                      CASA, JOGO, TEM_LUGAR, CAMPEONATO ,
                      PARTE_DE, PARTICIPA, TREINADOR, TREINA,
                      FEDERACAO, FEDERADO, CONTACTO, MORADA;

CREATE TABLE IF NOT EXISTS JOGADOR
(
  IdJogador INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(128) NOT NULL,
  DataNascimento DATE NOT NULL,
  Posicao VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS EQUIPA
(
  IdEquipa INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(64) NOT NULL,
  Cidade VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS JOGA_POR
(
  IdJogador INT NOT NULL,
  IdEquipa INT NOT NULL,
  PRIMARY KEY(IdJogador,IdEquipa),
  FOREIGN KEY(IdJogador) REFERENCES JOGADOR(IdJogador),
  FOREIGN KEY(IdEquipa) REFERENCES EQUIPA(IdEquipa)
);

CREATE TABLE IF NOT EXISTS ESTADIO
(
  IdEstadio INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(64) NOT NULL,
  Localidade VARCHAR(64) NOT NULL,
  Capacidade INT NOT NULL
);

SET FOREIGN_KEY_CHECKS=0; /* para resolver foreign key constraint fails*/
CREATE TABLE IF NOT EXISTS CASA
(
  IdEquipa INT NOT NULL,
  IdEstadio INT NOT NULL,
  PRIMARY KEY (IdEquipa,IdEstadio),
  FOREIGN KEY(IdEquipa) REFERENCES EQUIPA(IdEquipa),
  FOREIGN KEY(IdEstadio) REFERENCES ESTADIO(IdEstadio)
);

CREATE TABLE IF NOT EXISTS JOGO
(
  IdJogo INT PRIMARY KEY AUTO_INCREMENT,
  DataJogo DATE NOT NULL,
  IdEquipaCasa INT NOT NULL,
  IdEquipaFora INT NOT NULL,
  Resultado VARCHAR(10) NOT NULL,
  FOREIGN KEY(IdEquipaFora) REFERENCES EQUIPA(IdEquipa),
  FOREIGN KEY(IdEquipaCasa) REFERENCES EQUIPA(IdEquipa)
);

CREATE TABLE IF NOT EXISTS TEM_LUGAR
(
  IdEstadio INT NOT NULL,
  IdJogo INT NOT NULL,
  PRIMARY KEY(IdEstadio,IdJogo),
  FOREIGN KEY(IdEstadio) REFERENCES ESTADIO(IdEstadio),
  FOREIGN KEY(IdJogo) REFERENCES JOGO(IdJogo)
);

CREATE TABLE IF NOT EXISTS CAMPEONATO
(
  IdCampeonato INT PRIMARY KEY AUTO_INCREMENT,
  DataInicio DATE NOT NULL,
  DataFim DATE
);

CREATE TABLE IF NOT EXISTS PARTE_DE
(
  Idjogo INT NOT NULL,
  IdCampeonato INT NOT NULL,
  PRIMARY KEY(IdJogo, IdCampeonato),
  FOREIGN KEY(IdJogo) REFERENCES JOGO(IdJogo),
  FOREIGN KEY(IdCampeonato) REFERENCES CAMPEONATO(IdCampeonato)
);

CREATE TABLE IF NOT EXISTS PARTICIPA
(
  IdJogador INT NOT NULL,
  IdJogo INT NOT NULL,
  PRIMARY KEY(IdJogador,IdJogo),
  FOREIGN KEY(IdJogador) REFERENCES JOGADOR(IdJogador),
  FOREIGN KEY(IdJogo) REFERENCES JOGO(IdJogo),
  CartoesAmarelos INT DEFAULT 0,
  CartoesVermelhos INT DEFAULT 0,
  Golos INT DEFAULT 0,
  Assistencias INT DEFAULT 0
);


CREATE TABLE IF NOT EXISTS TREINADOR
(
  IdTreinador INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS TREINA
(
  IdTreinador INT NOT NULL,
  IdEquipa INT NOT NULL,
  PRIMARY KEY(IdTreinador,IdEquipa),
  FOREIGN KEY(IdTreinador) REFERENCES TREINADOR(IdTreinador),
  FOREIGN KEY(IdEquipa) REFERENCES EQUIPA(IdEquipa)
);

CREATE TABLE IF NOT EXISTS FEDERACAO
(
  IdFederacao  VARCHAR(8) PRIMARY KEY UNIQUE,
  Nome VARCHAR(64)

);

CREATE TABLE IF NOT EXISTS FEDERADO
(
  IdJogador INT NOT NULL,
  IdFederacao VARCHAR(8) NOT NULL,
  PRIMARY KEY(IdJogador,IdFederacao),
  FOREIGN KEY(IdJogador) REFERENCES JOGADOR(IdJogador),
  FOREIGN KEY(IdFederacao) REFERENCES FEDERACAO(IdFederacao)
);

CREATE TABLE IF NOT EXISTS CONTACTO
(
  IdFederacao VARCHAR(8) NOT NULL,
  Contacto VARCHAR(64) NOT NULL,
  PRIMARY KEY(IdFederacao,Contacto),
  FOREIGN KEY(IdFederacao) REFERENCES FEDERACAO(IdFederacao)
);

CREATE TABLE IF NOT EXISTS MORADA
(
  IdFederacao VARCHAR(8),
  CP VARCHAR(32),
  Rua VARCHAR(64),
  Nr INT,
  Andar INT DEFAULT NULL,
  Localidade VARCHAR(64),
  FOREIGN KEY(IdFederacao) REFERENCES FEDERACAO(IdFederacao)
);

/*--------------------------------------------------------------*/

INSERT INTO JOGADOR(Nome, DataNascimento, Posicao)
VALUES
('Hugo', '1995-10-05','medio'),
('Martins', '1996-04-20','avancado'),
('Jardel', '1994-10-10','guarda-redes'),
('Jorge', '1990-12-25','defesa'),
('Joaquim', '1642-01-01','defesa'),
('Juan', '1989-02-03', 'medio');

INSERT INTO EQUIPA(Nome,Cidade)
VALUES
('F.C.Porto', 'Porto'),
('S.L.Benfica', 'Lisboa'),
('Sporting C.P.', 'Lisboa');

INSERT INTO JOGA_POR(IdJogador,IdEquipa)
VALUES
(1,1),(3,1), /*Hugo e Jardel no Porto*/
(2,2),(4,2), /*Martins e Jorge no Benfica*/
(5,3),(6,3); /*Joaquim e Juan no Zboarding*/

INSERT INTO ESTADIO(Nome, Localidade, Capacidade)
VALUES
('Estadio do Dragao','Porto',50033),
('Estadio da Luz', 'Lisboa',65000),
('Estadio Jose Alvalade','Lisboa',50095);

INSERT INTO CASA VALUES (1,1),(2,2),(3,3); /* self explanatory*/

INSERT INTO JOGO(DataJogo,IdEquipaCasa,IdEquipaFora,Resultado)
  VALUES ('2020-04-04',1,2,'5-0'); /*Porto 5-0 Benfica*/

INSERT INTO TEM_LUGAR VALUES (1,1);

INSERT INTO CAMPEONATO(DataInicio,DataFim)
  VALUES('2019-08-11','2020-05-17');

INSERT INTO PARTE_DE VALUES (1,1);

INSERT INTO PARTICIPA(IdJogador,IdJogo,CartoesAmarelos,CartoesVermelhos,Golos,Assistencias)
VALUES
(1,1,1,0,3,2), /*1 CARTAO AMARELO, 3 GOLOS 2 ASSISTENCIAS*/
(2,1,0,0,2,3), /*2 GOLOS 3 ASSISTENCIAS*/
(3,1,0,1,0,0), /*1 CARTAO VERMELHO*/
(4,1,1,0,0,0); /*1 CARTAO AMARELO*/

INSERT INTO TREINADOR VALUES (1,"Mourinho"),(2,"Camacho");

INSERT INTO TREINA VALUES (1,1),(2,2); /*Mourinho -> Porto, Camacho -> Benfica*/

INSERT INTO FEDERACAO
VALUES ('FPF', 'Federacao Portuguesa de Futebol'),
      ('FEF', 'Real Federacion Espanola de Futbol'),
      ('FFF', 'Federation Francaise de Football');

INSERT INTO FEDERADO
VALUES (1,'FPF'),(2,'FPF'),(3,'FPF'),(4,'FPF'),(5,'FPF'), /* JOGADORES NA FPF*/
(6,'FEF'); /*JUAN NA FEDERACAO ESPANHOLA*/

INSERT INTO CONTACTO
  VALUES ('FPF','+351 213 252 700'), ('FPF','+351 213 252 780'),
          ('FEF', '+34 914 959 800'),
          ('FFF','+33 144 317 300');


INSERT INTO MORADA (IdFederacao,CP,Rua,Nr,Andar,Localidade)
  VALUES
    ('FPF','1495-433','Cidade do Futebol Avenida das Selecoes',120,NULL, 'Cruz-Quebrada'),
    ('FEF','385-28230', 'Ramon y Cajal',355, NULL, 'Madrid'),
    ('FFF', '265-75015', 'Boulevard de Grenelle',87,NULL, 'Paris');
