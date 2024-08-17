CREATE DATABASE joins;

CREATE TABLE alpha (
    id INT NOT NULL,
    description VARCHAR(10) NOT NULL,
    CONSTRAINT alpha_id_pk PRIMARY KEY (id)
);

CREATE TABLE beta (
    id INT NOT NULL,
    title VARCHAR(10) NOT NULL,
    CONSTRAINT beta_alpha_id_fk FOREIGN KEY (id)
        REFERENCES alpha (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

INSERT INTO alpha VALUES (1, 'UNO'), (2, 'DOS'), (3, 'TRES'), (4, 'CUATRO');
INSERT INTO beta VALUES (1, 'ONE'), (2, 'TWO'), (3, 'THREE');

SELECT * FROM alpha, beta;

SELECT * FROM alpha CROSS JOIN beta;

SELECT * FROM alpha NATURAL JOIN beta;

SELECT * FROM alpha AS a INNER JOIN beta AS b ON a.id = b.id;

SELECT * FROM alpha AS a JOIN beta AS b ON a.id = b.id;

SELECT * FROM alpha AS a LEFT JOIN beta AS b ON a.id = b.id;

SELECT * FROM alpha AS a RIGHT JOIN beta AS b ON a.id = b.id;

SELECT * FROM alpha AS a FULL JOIN beta AS b ON a.id = b.id;