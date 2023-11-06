CREATE DATABASE grupos;

USE grupos;

CREATE TABLE Professor(
	idProfessor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    disciplina VARCHAR(45)
)AUTO_INCREMENT = 10000;

INSERT INTO Professor VALUES
	(null, 'Vivian', 'Banco de dados'),
    (null, 'Mônica', 'Tecnologia da Informação'),
    (null, 'Caio', 'Algoritmos'),
    (null, 'JP', 'Algoritmos'),
    (null, 'Fernanda', 'Projeto e Inovação');
    
CREATE TABLE Grupos(
	idGrupo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(200)
)AUTO_INCREMENT = 1;

INSERT INTO Grupos VALUES
	(null, 'Fruit Tech', 'Monitoramento no Transporte de Frutas'),
    (null, 'TechApulus', 'Monitoramento no Armazenamento de Café'),
    (null, 'Termo Tech', 'Monitoramento de Extrusoras de Plástico');
    
CREATE TABLE Aluno(
	RA CHAR(8) PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(45),
    fkGrupo INT,
    CONSTRAINT fkGrupo FOREIGN KEY (fkGrupo)
		REFERENCES Grupos(idGrupo)
);

INSERT INTO Aluno VALUES
	('01232099', 'Isaac', 'isaac@sptech.school', 1),
    ('01232432', 'Diego', 'diego@sptech.school', 1),
    ('01232734', 'Leonardo', 'leonardo@sptech.school', 1),
    ('01232091', 'Matheus', 'matheus@sptech.school', 2),
    ('01232012', 'Kelvin', 'kelvin@sptech.school', 2),
    ('01232054', 'Julia', 'julia@sptech.school', 2),
    ('01232543', 'Kaua', 'kaua@sptech.school', 3),
    ('01232283', 'Gabriel', 'gabriel@sptech.school', 3),
    ('01232097', 'Cláudio', 'claudio@sptech.school', 3);

CREATE TABLE Avaliacoes(
	idAvaliacao INT AUTO_INCREMENT,
    idProfessorAV INT,
    idGrupoAV INT, PRIMARY KEY(idAvaliacao, idProfessorAV, idGrupoAV),
    dtAvaliacao DATETIME,
    nota INT,
    CONSTRAINT fkAvaliacaoProfessor FOREIGN KEY (idProfessorAV)
		REFERENCES Professor(idProfessor),
	CONSTRAINT fkAvaliacaoGrupos FOREIGN KEY (idGrupoAV)
		REFERENCES Grupos(idGrupo)
)AUTO_INCREMENT = 1000;

INSERT INTO Avaliacoes VALUES
	(null, 10000, 1, '2023-09-12 14:37:09', 8),
    (null, 10004, 2, '2023-07-06 15:48:59', 7),
    (null, 10001, 2, '2023-07-12 15:36:54', 10),
    (null, 10003, 3, '2023-04-02 13:01:09', 6),
    (null, 10002, 3, '2023-09-10 12:14:57', 9);
    
SELECT * FROM Aluno;
SELECT * FROM Professor;
SELECT * FROM Grupos;
SELECT * FROM Avaliacoes;

SELECT * FROM Grupos JOIN Aluno
	ON idGrupo = fkGrupo;
    
SELECT* FROM Grupos JOIN Aluno
	ON idGrupo = fkGrupo
		WHERE idGrupo = 2;
        
SELECT avg(nota) FROM Avaliacoes;

SELECT p.nome AS 'Nome do Professor', p.disciplina AS 'Disciplina', g.nome AS 'Nome do Grupo', g.descricao AS 'Descrição do Projeto', a.dtAvaliacao AS 'Data da Avaliação' 
	FROM Professor AS p
		JOIN Avaliacoes AS a ON idProfessorAV = idProfessor
			JOIN Grupos AS g ON idGrupoAV = idGrupo;
            
SELECT p.nome AS 'Nome do Professor', p.disciplina AS 'Disciplina', g.nome AS 'Nome do Grupo', g.descricao AS 'Descrição do Projeto', a.dtAvaliacao AS 'Data da Avaliação' 
	FROM Professor AS p
		JOIN Avaliacoes AS a ON idProfessorAV = idProfessor
			JOIN Grupos AS g ON idGrupoAV = idGrupo
				WHERE idGrupo = 2;
                
SELECT p.nome AS 'Nome do Professor', g.nome AS 'Nome do Grupo' 
	FROM Professor AS p
		JOIN Avaliacoes AS a ON idProfessorAV = idProfessor
			JOIN Grupos AS g ON idGrupoAV = idGrupo
				WHERE p.nome = 'Mônica';
                
SELECT p.nome AS 'Nome do Professor', p.disciplina AS 'Disciplina', g.nome AS 'Nome do Grupo', 
	g.descricao AS 'Descrição do Projeto', v.dtAvaliacao AS 'Data da Avaliação', a.RA AS 'RA do Aluno', a.nome AS 'Nome do Aluno', a.email AS 'Email do ALuno'
		FROM Professor AS p
			JOIN Avaliacoes AS v ON idProfessorAV = idProfessor
				JOIN Grupos AS g ON idGrupoAV = idGrupo
					JOIN Aluno AS a ON fkGrupo = idGrupo;
				
SELECT DISTINCT nota FROM Avaliacoes;

SELECT p.nome AS 'Nome do Professor', round(avg(v.nota), 1) AS 'Média das Notas', sum(v.nota) AS 'Soma das Notas'
	FROM Professor AS p JOIN Avaliacoes AS v
		ON idProfessorAV = idProfessor
			GROUP BY p.nome;
            
SELECT g.nome AS 'Nome do Grupo', round(avg(v.nota), 1) AS 'Média das Notas', sum(v.nota) AS 'Soma das Notas'
	FROM Grupos AS g JOIN Avaliacoes AS v
		ON idGrupoAV = idGrupo
			GROUP BY g.nome;
            
SELECT p.nome AS 'Nome do Professor', max(v.nota) AS 'Nota Máxima', min(v.nota) AS 'Nota Mínima'
	FROM Professor AS p JOIN Avaliacoes AS v
		ON idProfessorAV = idProfessor
			GROUP BY p.nome;
            
SELECT g.nome AS 'Nome do Grupo', max(v.nota) AS 'Nota Máxima', min(v.nota) AS 'Nota Mínima'
	FROM Grupos AS g JOIN Avaliacoes AS v
		ON idGrupoAV = idGrupo
			GROUP BY g.nome;