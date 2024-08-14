--? SE CREA OTRA BASE DE DATOS PARA OTROS EJEMPLOS

CREATE DATABASE facturacion;

CREATE TABLE persons (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    birthday DATE NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP,
    CONSTRAINT persons_id_pk PRIMARY KEY (id),
    CONSTRAINT persons_first_last_name_uk UNIQUE (first_name, last_name)
);

CREATE TABLE products (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    product_name VARCHAR(30) NOT NULL,
    price NUMERIC (10,2) NOT NULL,
    CONSTRAINT products_id_pk PRIMARY KEY (id),
    CONSTRAINT products_product_name_uk UNIQUE (product_name)
);

CREATE TABLE invoices (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    invoice_date DATE DEFAULT now() NOT NULL,
    person_id UUID NOT NULL,
    CONSTRAINT invoices_id_pk PRIMARY KEY (id),
    CONSTRAINT invoices_person_id_fk FOREIGN KEY (person_id)
        REFERENCES persons (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

-- SE VUELVE A PONER EL PRECIO PARA FIJARLO EN LA FACTURA YA QUE EL ORIGINAL PUEDE CAMBIAR
CREATE TABLE invoice_items (
    id UUID DEFAULT gen_random_uuid() NOT NULL,
    invoice_id UUID NOT NULL,
    product_id UUID NOT NULL,
    price NUMERIC (10,2) NOT NULL,
    QUANTITY INT DEFAULT 1 NOT NULL,
    CONSTRAINT invoice_items_id_pk PRIMARY KEY (id),
    CONSTRAINT invoice_items_invoice_id_fk FOREIGN KEY (invoice_id)
        REFERENCES invoices (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT invoice_items_product_id_fk FOREIGN KEY (product_id)
        REFERENCES products (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

INSERT INTO persons
VALUES (DEFAULT, 'LEONEL', 'HIDALGO', '1998-12-03', DEFAULT, NULL),
    (DEFAULT, 'FIORELLA', 'FLORES JARA', '2000-03-28', DEFAULT, NULL),
    (DEFAULT, 'FACUNDO', 'HIDALGO', '2001-08-14', DEFAULT, NULL),
    (DEFAULT, 'MABEL', 'NARANJO', '1970-06-18', DEFAULT, NULL),
    (DEFAULT, 'ALEJANDRO', 'HIDALGO', '1966-06-04', DEFAULT, NULL);

INSERT INTO products
VALUES (DEFAULT, 'RICE', 12.31),
    (DEFAULT, 'POTATO', 1.44),
    (DEFAULT, 'MEALT', 20);

--! RETURNING DEVUELVE EL VALOR DE LA/S VARIABLES INDICADAS
INSERT INTO invoices (person_id) 
VALUES ('524e3d66-ad0c-4586-83fb-a82726749d2e')
RETURNING id;

--! USAMOS EL VALOR OBTENIDO DEL RETURNING id PARA COMPLETAR EL 2DO CAMPO
INSERT INTO invoice_items
VALUES (DEFAULT, 'd9ec5cf2-4bd0-4922-83b3-87e442486193', '43614f3b-efee-465b-8706-cb8937a589fe', 14.11, 2),
    (DEFAULT, 'd9ec5cf2-4bd0-4922-83b3-87e442486193', '5a6cc715-1a75-43cb-a75f-fdc8389eae77', 1.44, 1),
    (DEFAULT, 'd9ec5cf2-4bd0-4922-83b3-87e442486193', '4c0e4b92-0905-4064-8386-eacb9413da38', 21, 3);


INSERT INTO invoices (person_id) 
VALUES ('e25ab795-c706-4dd7-8238-0524f92d693f')
RETURNING id;

INSERT INTO invoice_items
VALUES (DEFAULT, '2734e9a9-2a56-460d-abdc-779d6110473d', '5a6cc715-1a75-43cb-a75f-fdc8389eae77', 1.44, 3),
    (DEFAULT, '2734e9a9-2a56-460d-abdc-779d6110473d', '4c0e4b92-0905-4064-8386-eacb9413da38', 21, 12);


INSERT INTO invoices (person_id) 
VALUES ('4f730c6d-1de4-45e1-bb4e-aeeb48fc4c7d')
RETURNING id;

INSERT INTO invoice_items
VALUES (DEFAULT, 'b18cb99c-108e-473f-b6a0-92d7561ed415', '43614f3b-efee-465b-8706-cb8937a589fe', 14.11, 1),
    (DEFAULT, 'b18cb99c-108e-473f-b6a0-92d7561ed415', '5a6cc715-1a75-43cb-a75f-fdc8389eae77', 1.44, 5);


INSERT INTO invoices (person_id) 
VALUES ('a321c98c-01de-446e-bbe4-50030dea68ee')
RETURNING id;

INSERT INTO invoice_items
VALUES (DEFAULT, 'fd7ce1d4-0f2d-42b5-ac8a-83fc2bcaf189', '5a6cc715-1a75-43cb-a75f-fdc8389eae77', 2, 5);


INSERT INTO invoices (person_id) 
VALUES ('66799c5d-33fc-4777-bb41-2c0610413715')
RETURNING id;

INSERT INTO invoice_items
VALUES (DEFAULT, '9960da1b-8d8f-44d8-a193-80e6f52b289d', '43614f3b-efee-465b-8706-cb8937a589fe', 14.11, 1),
    (DEFAULT, '9960da1b-8d8f-44d8-a193-80e6f52b289d', '5a6cc715-1a75-43cb-a75f-fdc8389eae77', 1.44, 12);

SELECT DISTINCT last_name FROM persons;