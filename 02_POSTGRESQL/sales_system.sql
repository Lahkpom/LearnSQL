-- Creación de la base de datos "sistema_ventas"
CREATE DATABASE SALES_SYSTEM;

-- Creación de la tabla "Clientes"
CREATE TABLE CUSTOMERS (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	CUSTOMER_ADDRESS VARCHAR(100) NOT NULL,
	PHONE VARCHAR(20),
	EMAIL_ADDRESS VARCHAR(50),
	CONSTRAINT CUSTOMERS_ID_PK PRIMARY KEY (ID)
);

-- Creación de la tabla "Empleados"
CREATE TABLE EMPLOYEES (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	EMPLOYEE_ADDRESS VARCHAR(100) NOT NULL,
	PHONE VARCHAR(20),
	EMAIL_ADDRESS VARCHAR(50),
	SALARY NUMERIC(10, 2) CHECK (SALARY > 0),
	HIRING_DATE DATE DEFAULT NOW() NOT NULL,
	CONSTRAINT EMPLOYEES_ID_PK PRIMARY KEY (ID)
);

-- Creación de la tabla "Proveedores"
CREATE TABLE SUPPLIERS (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	FIRST_NAME VARCHAR(50) NOT NULL,
	LAST_NAME VARCHAR(50) NOT NULL,
	PHONE VARCHAR(20),
	EMAIL_ADDRESS VARCHAR(50),
	CONSTRAINT SUPPLIERS_ID_PK PRIMARY KEY (ID)
);

-- Creación de la tabla "Categorias"
CREATE TABLE CATEGORIES (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	TITLE VARCHAR(50) NOT NULL,
	CONSTRAINT CATEGORIES_ID_PK PRIMARY KEY (ID)
);

-- Creación de la tabla "Productos"
CREATE TABLE PRODUCTS (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	PRODUCT_NAME VARCHAR(50) NOT NULL,
	PRODUCT_DESCRIPTION TEXT,
	PRICE NUMERIC(10, 2) NOT NULL CHECK (PRICE > 0),
	INVENTORY_QUANTITY INTEGER NOT NULL CHECK (INVENTORY_QUANTITY >= 0),
	SUPPLIER_ID UUID NOT NULL,
	CATEGORIE_ID UUID NOT NULL,
	CONSTRAINT PRODUCTS_ID_PK PRIMARY KEY (ID),
	CONSTRAINT PRODUCTS_SUPPLIERS_ID_FK FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIERS (ID),
	CONSTRAINT PRODUCTS_CATEGORIES_ID_FK FOREIGN KEY (CATEGORIE_ID) REFERENCES CATEGORIES (ID)
);

-- Creación de la tabla "Ventas"
CREATE TABLE SALES (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	SALE_DATE DATE DEFAULT NOW() NOT NULL,
	EMPLOYEE_ID UUID NOT NULL,
	CUSTOMER_ID UUID NOT NULL,
	CONSTRAINT SALES_ID_PK PRIMARY KEY (ID),
	CONSTRAINT SALES_EMPLOYEES_ID_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (ID),
	CONSTRAINT SALES_CUSTOMERS_ID_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (ID)
);

-- Creación de la tabla "Detalle_Venta"
CREATE TABLE SALE_DETAILS (
	SALE_ID UUID NOT NULL,
	PRODUCT_ID UUID NOT NULL,
	PRICE NUMERIC(10, 2) NOT NULL CHECK (PRICE > 0),
	CANT INTEGER NOT NULL CHECK (CANT > 0),
	CONSTRAINT SALE_DETAILS_SALES_ID_FK FOREIGN KEY (SALE_ID) REFERENCES SALES (ID),
	CONSTRAINT SALE_DETAILS_PRODUCTS_ID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS (ID),
	CONSTRAINT SALE_DETAILS_SALE_PRODUCT_ID_PK PRIMARY KEY (SALE_ID, PRODUCT_ID)
);

-- Creación de la tabla "Facturas"
CREATE TABLE INVOICES (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	INVOICE_DATE DATE DEFAULT NOW() NOT NULL,
	EMPLOYEE_ID UUID NOT NULL,
	CUSTOMER_ID UUID NOT NULL,
	SALE_ID UUID NOT NULL,
	CONSTRAINT INVOICES_ID_PK PRIMARY KEY (ID),
	CONSTRAINT INVOICES_EMPLOYEE_ID_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (ID),
	CONSTRAINT INVOICES_CUSTOMER_ID_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (ID),
	CONSTRAINT INVOICES_SALES_ID_FK FOREIGN KEY (SALE_ID) REFERENCES SALES (ID)
);

-- Creación de la tabla "Envios"
CREATE TABLE SHIPMENTS (
	ID UUID DEFAULT GEN_RANDOM_UUID () NOT NULL,
	SHIPMENT_DATE DATE NOT NULL,
	SHIPMENT_STATUS VARCHAR(100) NOT NULL,
	EMPLOYEE_ID UUID NOT NULL,
	CUSTOMER_ID UUID NOT NULL,
	CONSTRAINT SHIPMENTS_ID_PK PRIMARY KEY (ID),
	CONSTRAINT SHIPMENTS_EMPLOYEE_ID_FK FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES (ID),
	CONSTRAINT SHIPMENTS_CUSTOMER_ID_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (ID)
);

-- Creación de la tabla "Detalle_Envio"
CREATE TABLE SHIPPING_DETAILS (
	SHIPMENT_ID UUID NOT NULL,
	PRODUCT_ID UUID NOT NULL,
	CANT INTEGER NOT NULL CHECK (CANT > 0),
	SHIPPING_ADDRESS VARCHAR(100) NOT NULL,
	SHIPING_COST NUMERIC(10, 2) NOT NULL,
	CONSTRAINT SHIPPING_DETAILS_SHIPMENTS_ID_FK FOREIGN KEY (SHIPMENT_ID) REFERENCES SHIPMENTS (ID),
	CONSTRAINT SHIPPING_DETAILS_PRODUCTS_ID_FK FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS (ID),
	CONSTRAINT SHIPPING_DETAILS_SHIPMENT_PRODUCT_ID_PK PRIMARY KEY (SHIPMENT_ID, PRODUCT_ID)
);

INSERT INTO
	CUSTOMERS (
		FIRST_NAME,
		LAST_NAME,
		CUSTOMER_ADDRESS,
		PHONE,
		EMAIL_ADDRESS
	)
VALUES
	(
		'Juan',
		'Pérez',
		'Calle 123, Ciudad X',
		'555-1234',
		'juan.perez@example.com'
	),
	(
		'María',
		'García',
		'Avenida Principal, Ciudad Y',
		'555-5678',
		'maria.garcia@example.com'
	),
	(
		'Carlos',
		'González',
		'Calle 456, Ciudad Z',
		'555-9012',
		'carlos.gonzalez@example.com'
	),
	(
		'Laura',
		'Hernández',
		'Avenida Central, Ciudad A',
		'555-3456',
		'laura.hernandez@example.com'
	),
	(
		'Luis',
		'Martínez',
		'Calle 789, Ciudad B',
		'555-7890',
		'luis.martinez@example.com'
	);

INSERT INTO
	EMPLOYEES (
		FIRST_NAME,
		LAST_NAME,
		EMPLOYEE_ADDRESS,
		PHONE,
		EMAIL_ADDRESS,
		SALARY,
		HIRING_DATE
	)
VALUES
	(
		'Juan',
		'González',
		'Calle 123, Ciudad',
		'555-1234',
		'juan.gonzalez@example.com',
		3000.00,
		'2020-01-15'
	),
	(
		'María',
		'Rodríguez',
		'Av. Principal, Barrio',
		'555-5678',
		'maria.rodriguez@example.com',
		3500.00,
		'2019-05-22'
	),
	(
		'Pedro',
		'López',
		'Calle 45, Sector',
		'555-9012',
		'pedro.lopez@example.com',
		2800.00,
		'2021-02-28'
	),
	(
		'Ana',
		'Martínez',
		'Av. Central, Urbanización',
		'555-3456',
		'ana.martinez@example.com',
		3200.00,
		'2018-11-10'
	),
	(
		'Luis',
		'Sánchez',
		'Calle 67, Conjunto',
		'555-7890',
		'luis.sanchez@example.com',
		4000.00,
		'2022-01-01'
	);

INSERT INTO
	SUPPLIERS (FIRST_NAME, LAST_NAME, PHONE, EMAIL_ADDRESS)
VALUES
	(
		'Proveedora de productos electrónicos',
		'Av. Tecnológico 123, Col. Centro, Ciudad de México',
		'55-1234-5678',
		'ventas@proveedora.com'
	),
	(
		'Distribuidora de alimentos',
		'Calle 5 de Mayo 456, Col. Juárez, Guadalajara',
		'33-9876-5432',
		'ventas@distribuidora.com'
	),
	(
		'Fabricante de textiles',
		'Carretera a Toluca Km. 17, Toluca',
		'722-234-5678',
		'contacto@fabricante.com'
	),
	(
		'Mayorista de artículos deportivos',
		'Av. Constitución 789, Col. Zona Centro, Monterrey',
		'81-3456-7890',
		'ventas@mayorista.com'
	),
	(
		'Compañía de suministros industriales',
		'Calle Reforma 321, Col. Centro, Puebla',
		'222-876-5432',
		'ventas@suministros.com'
	);

INSERT INTO
	CATEGORIES (TITLE)
VALUES
	('Electrónica'),
	('Ropa'),
	('Hogar'),
	('Alimentos'),
	('Joyería');

INSERT INTO
	PRODUCTS (
		PRODUCT_NAME,
		PRODUCT_DESCRIPTION,
		PRICE,
		INVENTORY_QUANTITY,
		SUPPLIER_ID,
		CATEGORIE_ID
	)
VALUES
	(
		'Laptop HP',
		'Laptop de alta gama con procesador i7 y 16GB de RAM',
		1200.00,
		10,
		'12365cc4-7adc-47ca-9ada-25d830034eab',
		'403661bf-7655-4d54-aa5c-f9d4aab9530b'
	),
	(
		'Impresora Epson',
		'Impresora multifuncional con Wi-Fi',
		400.00,
		20,
		'23266542-f4ad-458f-80e6-f1f164724f3c',
		'62e5927c-45d8-4399-b272-09d787ab51ef'
	),
	(
		'Mouse inalámbrico',
		'Mouse inalámbrico con diseño ergonómico',
		20.00,
		50,
		'f431bb58-6744-4864-820c-a4074f95c51a',
		'1fa46fc2-ae0b-426b-b754-16fb0a2ef437'
	),
	(
		'Teclado USB',
		'Teclado USB resistente al agua',
		15.00,
		30,
		'71f33178-d389-49f4-be64-f5184509bf61',
		'1fa46fc2-ae0b-426b-b754-16fb0a2ef437'
	),
	(
		'Monitor Samsung',
		'Monitor LED de 27 pulgadas',
		350.00,
		15,
		'12365cc4-7adc-47ca-9ada-25d830034eab',
		'403661bf-7655-4d54-aa5c-f9d4aab9530b'
	);

INSERT INTO
	SALES (SALE_DATE, EMPLOYEE_ID, CUSTOMER_ID)
VALUES
	(
		'2022-01-15',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'94d847d5-877f-4ade-bbc4-b4ce1fb6224b'
	),
	(
		'2022-02-01',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'4810843b-fa99-4eca-befa-1f41447df58b'
	),
	(
		'2022-02-10',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'6c2cad11-1ca5-4287-9231-1fedf3a96a9f'
	),
	(
		'2022-03-05',
		'7012327b-d0fd-40be-90ce-4a2490325e97',
		'3a8ea996-72a6-44f3-b3dd-34c5e81a2032'
	),
	(
		'2022-03-12',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'9a63c7b3-5e53-4118-9bc8-ae7c510cf31c'
	);

INSERT INTO
	SALE_DETAILS (SALE_ID, PRODUCT_ID, CANT, PRICE)
VALUES
	(
		'98c6245e-f4d4-4485-9e54-53aec07c0b03',
		'5b71df83-113a-4e56-ad54-ba6bd0a55e8f',
		1,
		1200.00
	),
	(
		'98c6245e-f4d4-4485-9e54-53aec07c0b03',
		'6889c37f-fbee-4cac-a53d-3dd1e8c350a1',
		2,
		400.00
	),
	(
		'34b4e4a7-ff0b-4e06-a4cd-065dd28bea91',
		'9ae8a603-b354-4e51-9b7b-3bf691f725ca',
		1,
		20.00
	),
	(
		'34b4e4a7-ff0b-4e06-a4cd-065dd28bea91',
		'7a1dc557-7d19-4e67-8a99-4fc9e02a30b6',
		1,
		15.00
	),
	(
		'e5d6ea98-8cf4-461d-acc0-6dfc789b362f',
		'73afcdba-273d-4f7c-a8f3-1c79efe0e0c0',
		1,
		350.00
	),
	(
		'8df2d9d4-dec7-4683-b962-02b618d36330',
		'5b71df83-113a-4e56-ad54-ba6bd0a55e8f',
		2,
		1200.00
	),
	(
		'8df2d9d4-dec7-4683-b962-02b618d36330',
		'6889c37f-fbee-4cac-a53d-3dd1e8c350a1',
		1,
		400.00
	),
	(
		'9b65e804-6068-4bbf-b6fe-561ed1d4470a',
		'9ae8a603-b354-4e51-9b7b-3bf691f725ca',
		3,
		20.00
	),
	(
		'9b65e804-6068-4bbf-b6fe-561ed1d4470a',
		'7a1dc557-7d19-4e67-8a99-4fc9e02a30b6',
		2,
		15.00
	),
	(
		'9b65e804-6068-4bbf-b6fe-561ed1d4470a',
		'73afcdba-273d-4f7c-a8f3-1c79efe0e0c0',
		1,
		350.00
	);

INSERT INTO
	INVOICES (INVOICE_DATE, EMPLOYEE_ID, CUSTOMER_ID, SALE_ID)
VALUES
	(
		'2022-01-15',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'94d847d5-877f-4ade-bbc4-b4ce1fb6224b',
		'98c6245e-f4d4-4485-9e54-53aec07c0b03'
	),
	(
		'2022-02-01',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'4810843b-fa99-4eca-befa-1f41447df58b',
		'34b4e4a7-ff0b-4e06-a4cd-065dd28bea91'
	),
	(
		'2022-02-10',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'6c2cad11-1ca5-4287-9231-1fedf3a96a9f',
		'e5d6ea98-8cf4-461d-acc0-6dfc789b362f'
	),
	(
		'2022-03-05',
		'7012327b-d0fd-40be-90ce-4a2490325e97',
		'3a8ea996-72a6-44f3-b3dd-34c5e81a2032',
		'8df2d9d4-dec7-4683-b962-02b618d36330'
	),
	(
		'2022-03-12',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'9a63c7b3-5e53-4118-9bc8-ae7c510cf31c',
		'9b65e804-6068-4bbf-b6fe-561ed1d4470a'
	);

INSERT INTO
	SHIPMENTS (
		SHIPMENT_DATE,
		SHIPMENT_STATUS,
		EMPLOYEE_ID,
		CUSTOMER_ID
	)
VALUES
	(
		'2022-01-10',
		'pendiente de entrega',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'94d847d5-877f-4ade-bbc4-b4ce1fb6224b'
	),
	(
		'2022-02-05',
		'en tránsito',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'9a63c7b3-5e53-4118-9bc8-ae7c510cf31c'
	),
	(
		'2022-02-25',
		'en tránsito',
		'7012327b-d0fd-40be-90ce-4a2490325e97',
		'4810843b-fa99-4eca-befa-1f41447df58b'
	),
	(
		'2022-03-10',
		'en tránsito',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'6c2cad11-1ca5-4287-9231-1fedf3a96a9f'
	),
	(
		'2022-03-20',
		'pendiente de entrega',
		'c1fff2ce-aa77-47cb-b145-0554595286e0',
		'3a8ea996-72a6-44f3-b3dd-34c5e81a2032'
	),
	(
		'2022-04-05',
		'pendiente de entrega',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'94d847d5-877f-4ade-bbc4-b4ce1fb6224b'
	),
	(
		'2022-04-15',
		'pendiente de entrega',
		'7012327b-d0fd-40be-90ce-4a2490325e97',
		'9a63c7b3-5e53-4118-9bc8-ae7c510cf31c'
	),
	(
		'2022-05-01',
		'entregado',
		'c1fff2ce-aa77-47cb-b145-0554595286e0',
		'6c2cad11-1ca5-4287-9231-1fedf3a96a9f'
	),
	(
		'2022-05-20',
		'entregado',
		'68e36a55-b871-4b0b-943d-dda1d1c4ef81',
		'3a8ea996-72a6-44f3-b3dd-34c5e81a2032'
	),
	(
		'2022-06-05',
		'entregado',
		'c97dce9d-c212-4f92-a2e1-f16d84cf8778',
		'4810843b-fa99-4eca-befa-1f41447df58b'
	);

INSERT INTO
	SHIPPING_DETAILS (
		SHIPMENT_ID,
		PRODUCT_ID,
		CANT,
		SHIPPING_ADDRESS,
		SHIPING_COST
	)
VALUES
	(
		'5a7cdb54-3a40-4ba4-8330-06f87e49ec7a',
		'5b71df83-113a-4e56-ad54-ba6bd0a55e8f',
		1,
		'Av. Principal 123',
		20.00
	),
	(
		'5a7cdb54-3a40-4ba4-8330-06f87e49ec7a',
		'6889c37f-fbee-4cac-a53d-3dd1e8c350a1',
		2,
		'Calle Norte 456',
		30.00
	),
	(
		'9934570d-6009-4576-82ae-836e1d7edc74',
		'7a1dc557-7d19-4e67-8a99-4fc9e02a30b6',
		1,
		'Av. Sur 789',
		80.00
	),
	(
		'892def45-aa1e-4513-8c26-d52df9322549',
		'9ae8a603-b354-4e51-9b7b-3bf691f725ca',
		3,
		'Calle Este 321',
		15.00
	),
	(
		'892def45-aa1e-4513-8c26-d52df9322549',
		'73afcdba-273d-4f7c-a8f3-1c79efe0e0c0',
		2,
		'Av. Oeste 654',
		40.00
	);