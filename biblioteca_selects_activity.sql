USE Biblioteca;

# 1- UTILIZANDO O RECURSO "IN", SELECIONAR TODAS AS INFORMACOES DOS AUTORES "JK ROWLING" E "STEPHAN KING";

SELECT * FROM tbl_autor WHERE codigo_autor IN (9,10);

# 2 - UTILIZANDO O RECURSO "IN", SELECIONAR O NOME, AS PAGINAS E A CATEGORIA DE TODOS OS LIVROS DAS CATEGORIAS "CONTOS", "POESIA" E "AVENTURA";

SELECT nome_livro, paginas, tbl_categoria.nome_categoria
FROM tbl_livros 
JOIN tbl_categoria
ON tbl_livros.FK_Categoria = tbl_categoria.codigo_categoria WHERE nome_categoria IN ("CONTOS", "POESIA", "AVENTURA");

# 3 -EXIBIR QUAL CATEGORIA DE LIVROS, NAO TEM NENHUM LIVRO VINICULADO A ELA

SELECT nome_categoria FROM tbl_categoria WHERE codigo_categoria NOT IN (SELECT FK_Categoria FROM tbl_livros);

# 4 - Exibir o nome dos livros cadastrados, juntamente com suas categorias e nome das editoras que o produziram.

SELECT nome_livro, tbl_categoria.nome_categoria, tbl_editora.nome_editora FROM tbl_livros 
JOIN tbl_categoria ON tbl_livros.FK_Categoria = tbl_categoria.codigo_categoria 
JOIN tbl_editora ON tbl_livros.FK_Editora = tbl_editora.codigo_editora;

# 5 - Exibir os autores que produziram livros da categoria de romance e quantos livros cada um produziu ordenando por quem produziu mais primeiro.

SELECT nome_autor, count(codigo_autor) total 
FROM Autor_Livro 
JOIN tbl_Autor ON codigo_autor = FK_Autor
JOIN tbl_Livros ON codigo_livro = FK_Livro
WHERE FK_Categoria IN(SELECT codigo_categoria FROM tbl_Livros JOIN tbl_categoria ON codigo_categoria = FK_Categoria WHERE nome_categoria = "Romance")
GROUP BY nome_autor
ORDER BY total DESC;

# 6 - Exibir os nomes dos autores e o nome dos seus livros

SELECT tbl_autor.nome_autor, tbl_livros.nome_livro
FROM Autor_Livro 
JOIN tbl_Livros ON FK_Livro = codigo_livro
JOIN tbl_Autor ON FK_Autor = codigo_autor;


# 7- Exibir os nomes dos autores e quantos livros cada um produziu em ordem do que tem mais livros para o que tem menos livros.

SELECT nome_autor, COUNT(*) Total 
FROM autor_livro 
JOIN tbl_livros 
ON tbl_livros.codigo_livro = autor_livro.FK_Livro 
JOIN tbl_autor
ON tbl_autor.codigo_autor = autor_livro.FK_autor 
GROUP BY nome_autor 
ORDER BY Total DESC; 

# 8 - Exibir apenas o nome, a sua categoria e valor_unitario para todos os livros que o valor unitario for superior a media dos preços. Ordenar a busca do menor valor para o maior. # dica: utilize subquery e order by.

SELECT tbl_livros.nome_livro, tbl_categoria.nome_categoria, tbl_livros.valor_unitario
FROM tbl_livros 
JOIN tbl_categoria 
ON tbl_livros.FK_Categoria = tbl_categoria.codigo_categoria WHERE valor_unitario > (SELECT AVG (valor_unitario) FROM tbl_Livros)
ORDER BY valor_unitario ASC;

# 9 - Exibir o nome do livro, a quantidade de paginas e o nome da categoria para todos os livros que o numero de paginas seja menor que a media das paginas. Ordernar a busca do maior para o menor valor da coluna paginas.

SELECT tbl_livros.nome_livro, tbl_livros.paginas, tbl_categoria.nome_categoria
FROM tbl_livros
JOIN tbl_categoria
ON tbl_livros.FK_Categoria = tbl_categoria.codigo_categoria
WHERE paginas < (SELECT AVG (paginas) FROM tbl_livros)
ORDER BY paginas desc;
