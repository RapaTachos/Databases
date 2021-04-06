
/*
 * Base de Dados
 * Eduardo R. B. Marques, DCC/FCUP
 *
 * BD para rede social simples.
 * Esquema e dados iniciais.
 */

USE guest;

DROP TABLE IF EXISTS POST_LIKED, COMMENT, HASHTAG, POST, FOLLOWER, USER;

CREATE TABLE IF NOT EXISTS 
USER
(
  Num       INT PRIMARY KEY AUTO_INCREMENT,
  Login     VARCHAR(16) UNIQUE NOT NULL,
  Joined    DATE NOT NULL,
  Name      VARCHAR(128) NOT NULL,
  BirthDate DATE NOT NULL,
  Sex       ENUM('M', 'F') NOT NULL,
  Phone     INT DEFAULT NULL,
  Email     VARCHAR(64) NOT NULL
); 

INSERT INTO 
  USER(Num, Login, Joined, Name, BirthDate, Sex, Phone, Email)
VALUES
 (1, 'joao.pinto', '2019-12-01', 'João Pinto',    '1976-12-19', 'M', NULL,      'azulibranco@fcp.pt'),
 (2, 'semedo',     '2019-12-02', 'Carlos Semedo', '1985-06-02', 'M', 223774327, 'semedo@xpto.com'),
 (3, 'maria',      '2019-12-02', 'Maria Silva',   '2005-11-17', 'F', 939939939, 'maria@xyz.pt'),
 (4, 'pedro',      '2019-12-10', 'Pedro Costa',   '1982-01-03', 'M', NULL,      'pc12345@xpto.com'),
 (5, 'mendocas',   '2019-12-11', 'Filipa Mendes', '2002-05-03', 'F', NULL,      'filipa.mendes@gmail.com'),
 (6, 'eva',        '2019-12-15', 'Eva Mendes',    '1975-11-18', 'F', NULL,      'i_ate_the_apple@paradise.com'),
 (7, 'pedro2',     '2019-12-16', 'Pedro Simões',  '1993-02-22', 'M', 213884445, 'simoes333@gmail.com');

/* Insertions with Num auto-generated and default value of NULL for Phone field. */
INSERT INTO USER(Login, Joined, Name, BirthDate, Sex, Email)
VALUES
 (   'batman',   '2019-12-16',   'Bruce Wayne',    '1939-01-01', 'M', 'batman@dccomics.com'),    /* 8 */
 (   'catwoman', '2019-12-16',   'Selina Kyle',    '1940-01-01', 'F', 'catwoman@dccomics.com'),  /* 9 */
 (   'ziggy',    '2019-12-31',   'Ziggy Stardust', '1972-01-01', 'M', 'ziggy@mars.com'),         /* 10 */
 (   'lady.z',   '2020-01-01',   'Lady Stardust',  '1972-01-01', 'F', 'ladyz@mars.com');         /* 11 */

CREATE TABLE IF NOT EXISTS
FOLLOWER
(
  User INT NOT NULL,
  Follower INT NOT NULL,
  PRIMARY KEY(User,Follower),
  FOREIGN KEY(User) REFERENCES USER(Num) ON DELETE CASCADE,
  FOREIGN KEY(Follower) REFERENCES USER(Num) ON DELETE CASCADE
);
 
INSERT INTO 
  FOLLOWER(User, Follower)
VALUES
  (8,9), (8,1), (8,2), (8,6), /* batman followed by catwoman, joao.pinto, semedo, and eva */
  (9,8), (9,1), (9,6), (9,11), /* catwoman followed by batman, joao.pinto, eva, and lady.z */
  (2,11), (4,3), (4,2), (5,3), (7,11), (2,3), (3,8), (7,10), (10,1), (11,1), /* etc ... */
  (1,2), (3,4), (1,4), (9,5), (7,1), (1,3), (3,1), (10,7), (10,11), (11,10); /* etc ... */

CREATE TABLE IF NOT EXISTS
POST
(
  Num INT PRIMARY KEY AUTO_INCREMENT,
  Author INT NOT NULL,
  Creation DATETIME NOT NULL,
  Content TEXT NOT NULL,
  FOREIGN KEY(Author) REFERENCES USER(Num)
);

INSERT INTO 
  POST(Author,Creation,Content)
VALUES
 /* some famous sayings by João Pinto :) - see https://www.online24.pt/as-melhores-frases-de-joao-pinto/ */
(1, '2020-01-13 12:31:59', 'Comigo, ou sem-migo, o Porto vai ser campeão!'), /* 1 */
(1, '2020-02-01 23:50:59', 'O meu coração só tem uma cor: azul e branco.'), /* 2 */
(1, '2020-02-13 12:31:59', 'Não foi nada de especial, chutei com o pé que estava mais a mão!'), /* 3 */
/* other */
(2, '2019-12-23 23:21:29', 'Nothing to do except posting ... anyone there?'), /* 4 */
(2, '2019-12-24 05:00:00', 'I guess nobody is online!'),  /* 5 */
(8, '2020-01-01 11:23:56', 'Joker, you are dead!'), /*6 */
(8, '2020-02-10 23:00:56', 'Catwoman, I love you!'), /* 7 */
(9, '2020-02-10 23:41:00', 'Batman is a troll! Joker is my sweetheart these days!'), /* 8 */
(9, '2020-02-17 23:51:00', 'Joker and I went out last night ... but pesky Batman had to show up.'), /* 9 */
(9, '2020-02-17 23:51:12', '... we ran away on the Joker-mobile!'), /* 10 */
(9, '2020-02-18 17:00:30', 'Joker is a busy man, he has no time for social networking.'), /* 11 */
(10,'2019-12-31 23:59:59', 'Happy new year star-gazers! 2020 will rock ...'); /* 12 */

CREATE TABLE IF NOT EXISTS
HASHTAG
(
  Post INT NOT NULL,
  Tag VARCHAR(32) NOT NULL,
  PRIMARY KEY(Post,Tag),
  FOREIGN KEY(Post) REFERENCES POST(Num) ON DELETE CASCADE
);

INSERT INTO 
  HASHTAG(Post, Tag)
VALUES
 (1, 'fcp'), 
 (2, 'fcp'), 
 (2, 'azulibranco'), 
 (3, 'fcp'), 
 (4, 'lonely'),
 (5, 'lonely'),
 (6, 'joker'),
 (7, 'kitty'),
 (8, 'batman'),
 (8, 'troll'),
 (9, 'joker'),
 (9, 'batman'),
 (9, 'troll'),
 (10, 'joker'),
 (10, 'batman'),
 (10, 'troll'),
 (11, 'joker'),
 (12, '2020');

CREATE TABLE IF NOT EXISTS
POST_LIKED
(
  User INT NOT NULL,
  Post INT NOT NULL,
  PRIMARY KEY(User, Post),
  FOREIGN KEY(User) REFERENCES USER(Num) ON DELETE CASCADE,
  FOREIGN KEY(Post) REFERENCES POST(Num) ON DELETE CASCADE
);

INSERT INTO 
  POST_LIKED(User,Post)
VALUES
  (1,1), (1,2), (1,3), (1,12),
  (2,1), (2,2), (2,3), (6,1), 
  (10,3), (10,2), (10,12),
  (11,10), (11,11), (11,12), (11,1);


CREATE TABLE IF NOT EXISTS
COMMENT
(
  Num INT PRIMARY KEY AUTO_INCREMENT,
  Post INT NOT NULL, 
  Author INT NOT NULL,
  Creation DATETIME NOT NULL,
  Content TEXT NOT NULL, 
  FOREIGN KEY(Post) REFERENCES POST(Num) ON DELETE CASCADE,
  FOREIGN KEY(Author) REFERENCES USER(Num) ON DELETE CASCADE
);

INSERT INTO 
  COMMENT(Post,Author,Creation,Content)
VALUES
  (1, 2,  '2020-01-13 17:00:12', 'Grande João Pinto!'),
  (1, 3,  '2020-01-13 17:10:23', 'Yes!'),
  (1, 1,  '2020-01-13 17:50:12', 'Obrigado pessoal!'),
  (8, 2,  '2020-02-11 06:12:12', 'Poor Batman!'),
  (8, 9,  '2020-02-11 16:21:33', 'Get a life darling!'),
  (12,11, '2020-01-01 00:00:05', 'You too Z!');
