DELIMITER //
CREATE PROCEDURE createComment(RegistNome VARCHAR(25), comTexto VARCHAR(4000), postNome VARCHAR(50))
BEGIN
	DECLARE postID, registID INT;
    SET postID = (SELECT Post_id FROM post WHERE Post_name = postNome);
    SET registID = (SELECT Regist_id FROM registado WHERE Regist_name = RegistNome);
    
    INSERT INTO comentario(Com_texto, Com_data, Post_id)
    VALUES (comTexto, LOCALTIME(), postID);
    
    IF registID is not NULL THEN
		INSERT INTO faz(Regist_id, Com_id)
		VALUES (registID, LAST_INSERT_ID());
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE deleteComment(RegistNome VARCHAR(25), comTexto VARCHAR(4000), postNome VARCHAR(50), comData DATETIME)
BEGIN
	DECLARE postID, registID, comID INT;
    SET postID = (SELECT Post_id FROM post WHERE Post_name = postNome);
    SET registID = (SELECT Regist_id FROM registado WHERE Regist_name = RegistNome);
    SET comID = (SELECT Com_id FROM comentario WHERE Post_id = postID AND Com_texto = comTexto);
    
    IF registID is not NULL THEN
		DELETE FROM faz
		WHERE Regist_id = registID AND Com_id = comID;
    END IF;
    
    DELETE FROM comentario
    WHERE Com_texto = comTexto AND Post_id = postID AND Com_data = comData;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE createPost(RegistNome VARCHAR(25), postNome VARCHAR(50), postConteudo VARCHAR(100), catNome VARCHAR(50))
BEGIN
	DECLARE catID, registID INT;
    SET catID = (SELECT Cat_id FROM categoria WHERE Cat_nome = catNome);
    SET registID = (SELECT Regist_id FROM registado WHERE Regist_name = RegistNome);
    
    INSERT INTO post(Post_name, Post_desc, Post_datacria, Cat_id)
    VALUES (postNome, postConteudo, LOCALTIME(), catID);
    
    INSERT INTO gerir(Regist_id, Post_id)
    VALUES (registID, LAST_INSERT_ID());
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE createCategoria(catNome VARCHAR(50), catConteudo VARCHAR(100))
BEGIN
    INSERT INTO categoria(Cat_nome, Cat_desc)
    VALUES (catNome, catConteudo);
END //
DELIMITER ;