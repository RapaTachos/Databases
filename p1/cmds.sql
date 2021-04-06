SELECT @data := CURDATE() AS DATE;


SELECT JOGADOR.Nome, Posicao,
        EQUIPA.Nome AS Equipa,
        IdFederacao, DataNascimento,
        TIMESTAMPDIFF(YEAR,DataNascimento, @data) AS Idade
FROM (JOGADOR  JOIN JOGA_POR USING(IdJogador)
   JOIN EQUIPA USING (IdEquipa))
   JOIN FEDERADO USING(IdJogador);

SELECT EQUIPA.Nome AS Equipa, ESTADIO.Nome AS Estadio, Localidade, Capacidade
FROM EQUIPA JOIN CASA USING(IdEquipa)
        JOIN ESTADIO USING(IdEstadio);

SELECT ESTADIO.Nome AS Estadio,
 IdJogo, DataJogo,
 A.Nome AS EquipaCasa,
 resultado,
 B.Nome AS EquipaFora
FROM ESTADIO JOIN TEM_LUGAR USING(IdEstadio)
              JOIN JOGO USING(IdJogo)
JOIN EQUIPA A ON (IdEquipaCasa = A.IdEquipa)
JOIN EQUIPA B ON (IdEquipaFORA = B.IdEquipa);


SELECT * FROM PARTE_DE;

SELECT IdJogador, Nome, IdJogo,
 CartoesAmarelos, CartoesVermelhos, Golos, Assistencias
 FROM JOGADOR JOIN PARTICIPA USING(IdJogador);

SELECT * FROM CONTACTO;

SELECT * FROM FEDERACAO JOIN MORADA USING(IdFederacao);
