-- Creación de la base de datos "sistema_ventas"
CREATE DATABASE sales_system;

-- Creación de la tabla "Clientes"
CREATE TABLE customers (
    id                 UUID         DEFAULT gen_random_uuid() NOT NULL,
    first_name         VARCHAR(50)                            NOT NULL,
    last_name          VARCHAR(50)                            NOT NULL,
    customer_address   VARCHAR(100)                           NOT NULL,
    phone              VARCHAR(20),
    email_address      VARCHAR(50),

    CONSTRAINT customers_id_pk PRIMARY KEY (id)
);

-- Creación de la tabla "Empleados"
CREATE TABLE employees (
    id                 UUID         DEFAULT gen_random_uuid() NOT NULL,
    first_name         VARCHAR(50)                            NOT NULL,
    last_name          VARCHAR(50)                            NOT NULL,
    employee_address   VARCHAR(100)                           NOT NULL,
    phone              VARCHAR(20),
    email_address      VARCHAR(50),
    salary             NUMERIC(10, 2)                         CHECK (salary > 0),
    hiring_date        DATE         DEFAULT now()             NOT NULL,

    CONSTRAINT employees_id_pk PRIMARY KEY (id)
);

-- Creación de la tabla "Proveedores"
CREATE TABLE suppliers (
    id                 UUID         DEFAULT gen_random_uuid() NOT NULL,
    first_name         VARCHAR(50)                            NOT NULL,
    last_name          VARCHAR(50)                            NOT NULL,
    phone              VARCHAR(20),
    email_address      VARCHAR(50),

    CONSTRAINT suppliers_id_pk PRIMARY KEY (id)
);

-- Creación de la tabla "Categorias"
CREATE TABLE categories (
    id                 UUID         DEFAULT gen_random_uuid() NOT NULL,
    title              VARCHAR(50)                            NOT NULL,

    CONSTRAINT categories_id_pk PRIMARY KEY (id)
);

-- Creación de la tabla "Productos"
CREATE TABLE products (
    id                  UUID        DEFAULT gen_random_uuid() NOT NULL,
    product_name        VARCHAR(50)                           NOT NULL,
    product_description TEXT,
    price               NUMERIC(10, 2)                        NOT NULL CHECK (price > 0),
    inventory_quantity  INTEGER                               NOT NULL CHECK (inventory_quantity >= 0),
    supplier_id         UUID                                  NOT NULL,
    categorie_id        UUID                                  NOT NULL,

    CONSTRAINT products_id_pk            PRIMARY KEY (id),
    CONSTRAINT products_suppliers_id_fk  FOREIGN KEY (supplier_id)
        REFERENCES suppliers  (id),
    CONSTRAINT products_categories_id_fk FOREIGN KEY (categorie_id)
        REFERENCES categories (id)
);

-- Creación de la tabla "Ventas"
CREATE TABLE sales (
    id                  UUID        DEFAULT gen_random_uuid() NOT NULL,
    sale_date           DATE        DEFAULT now()             NOT NULL,
    employee_id         UUID                                  NOT NULL,
    customer_id         UUID                                  NOT NULL,

    CONSTRAINT sales_id_pk           PRIMARY KEY (id),
    CONSTRAINT sales_employees_id_fk FOREIGN KEY (employee_id)
        REFERENCES employees (id),
    CONSTRAINT sales_customers_id_fk FOREIGN KEY (customer_id)
        REFERENCES customers (id)
);

-- Creación de la tabla "Detalle_Venta"
CREATE TABLE sale_details (
    sale_id             UUID                                  NOT NULL,
    product_id          UUID                                  NOT NULL,
    price               NUMERIC(10, 2)                        NOT NULL CHECK (price > 0),
    cant                INTEGER                               NOT NULL CHECK (cant > 0),

    CONSTRAINT sale_details_sales_id_fk        FOREIGN KEY (sale_id)
        REFERENCES sales    (id),
    CONSTRAINT sale_details_products_id_fk     FOREIGN KEY (product_id)
        REFERENCES products (id),
    CONSTRAINT sale_details_sale_product_id_pk PRIMARY KEY (sale_id, product_id)
);

-- Creación de la tabla "Facturas"
CREATE TABLE invoices (
    id                  UUID        DEFAULT gen_random_uuid() NOT NULL,
    invoice_date        DATE        DEFAULT now()             NOT NULL,
    employee_id         UUID                                  NOT NULL,
    customer_id         UUID                                  NOT NULL,
    sale_id             UUID                                  NOT NULL,

    CONSTRAINT invoices_id_pk          PRIMARY KEY (id),
    CONSTRAINT invoices_employee_id_fk FOREIGN KEY (employee_id)
        REFERENCES employees (id),
    CONSTRAINT invoices_customer_id_fk FOREIGN KEY (customer_id)
        REFERENCES customers (id),
    CONSTRAINT invoices_sales_id_fk    FOREIGN KEY (sale_id)
        REFERENCES sales     (id)
);

-- Creación de la tabla "Envios"
CREATE TABLE shipments (
    id                  UUID        DEFAULT gen_random_uuid() NOT NULL,
    shipment_date       DATE                                  NOT NULL,
    shipment_status     VARCHAR(100)                          NOT NULL,
    employee_id         UUID                                  NOT NULL,
    customer_id         UUID                                  NOT NULL,

    CONSTRAINT shipments_id_pk          PRIMARY KEY (id),
    CONSTRAINT shipments_employee_id_fk FOREIGN KEY (employee_id)
        REFERENCES employees (id),
    CONSTRAINT shipments_customer_id_fk FOREIGN KEY (customer_id)
        REFERENCES customers (id)
);

-- Creación de la tabla "Detalle_Envio"
CREATE TABLE shipping_details (
    shipment_id         UUID                                  NOT NULL,
    product_id          UUID                                  NOT NULL,
    cant                INTEGER                               NOT NULL CHECK (cant > 0),
    shipping_address    VARCHAR(100)                          NOT NULL,
    shiping_cost        NUMERIC(10, 2)                        NOT NULL,

    CONSTRAINT shipping_details_shipments_id_fk        FOREIGN KEY (shipment_id)
        REFERENCES shipments (id),
    CONSTRAINT shipping_details_products_id_fk         FOREIGN KEY (product_id)
        REFERENCES products  (id),
    CONSTRAINT shipping_details_shipment_product_id_pk PRIMARY KEY (shipment_id, product_id)
);

INSERT INTO customers (first_name, last_name, customer_address, phone, email_address)
VALUES ('Juan', 'Pérez', 'Calle 123, Ciudad X', '555-1234', 'juan.perez@example.com'),
       ('María', 'García', 'Avenida Principal, Ciudad Y', '555-5678', 'maria.garcia@example.com'),
       ('Carlos', 'González', 'Calle 456, Ciudad Z', '555-9012', 'carlos.gonzalez@example.com'),
       ('Laura', 'Hernández', 'Avenida Central, Ciudad A', '555-3456', 'laura.hernandez@example.com'),
       ('Luis', 'Martínez', 'Calle 789, Ciudad B', '555-7890', 'luis.martinez@example.com');

INSERT INTO employees (first_name, last_name, employee_address, phone, email_address, salary, hiring_date)
VALUES ('Juan', 'González', 'Calle 123, Ciudad', '555-1234', 'juan.gonzalez@example.com', 3000.00, '2020-01-15'),
       ('María', 'Rodríguez', 'Av. Principal, Barrio', '555-5678', 'maria.rodriguez@example.com', 3500.00, '2019-05-22'),
       ('Pedro', 'López', 'Calle 45, Sector', '555-9012', 'pedro.lopez@example.com', 2800.00, '2021-02-28'),
       ('Ana', 'Martínez', 'Av. Central, Urbanización', '555-3456', 'ana.martinez@example.com', 3200.00, '2018-11-10'),
       ('Luis', 'Sánchez', 'Calle 67, Conjunto', '555-7890', 'luis.sanchez@example.com', 4000.00, '2022-01-01');

INSERT INTO suppliers (first_name, last_name, phone, email_address)
VALUES ('Proveedora de productos electrónicos', 'Av. Tecnológico 123, Col. Centro, Ciudad de México', '55-1234-5678', 'ventas@proveedora.com'),
       ('Distribuidora de alimentos', 'Calle 5 de Mayo 456, Col. Juárez, Guadalajara', '33-9876-5432', 'ventas@distribuidora.com'),
       ('Fabricante de textiles', 'Carretera a Toluca Km. 17, Toluca', '722-234-5678', 'contacto@fabricante.com'),
       ('Mayorista de artículos deportivos', 'Av. Constitución 789, Col. Zona Centro, Monterrey', '81-3456-7890', 'ventas@mayorista.com'),
       ('Compañía de suministros industriales', 'Calle Reforma 321, Col. Centro, Puebla', '222-876-5432', 'ventas@suministros.com');

INSERT INTO categories (title)
VALUES ('Electrónica'),
       ('Ropa'),
       ('Hogar'),
       ('Alimentos'),
       ('Joyería');

INSERT INTO products (product_name, product_description, price, inventory_quantity, supplier_id, categorie_id)
VALUES ('Laptop HP', 'Laptop de alta gama con procesador i7 y 16GB de RAM', 1200.00, 10, '12365cc4-7adc-47ca-9ada-25d830034eab', '403661bf-7655-4d54-aa5c-f9d4aab9530b'),
       ('Impresora Epson', 'Impresora multifuncional con Wi-Fi', 400.00, 20, '23266542-f4ad-458f-80e6-f1f164724f3c', '62e5927c-45d8-4399-b272-09d787ab51ef'),
       ('Mouse inalámbrico', 'Mouse inalámbrico con diseño ergonómico', 20.00, 50, 'f431bb58-6744-4864-820c-a4074f95c51a', '1fa46fc2-ae0b-426b-b754-16fb0a2ef437'),
       ('Teclado USB', 'Teclado USB resistente al agua', 15.00, 30, '71f33178-d389-49f4-be64-f5184509bf61', '1fa46fc2-ae0b-426b-b754-16fb0a2ef437'),
       ('Monitor Samsung', 'Monitor LED de 27 pulgadas', 350.00, 15, '12365cc4-7adc-47ca-9ada-25d830034eab', '403661bf-7655-4d54-aa5c-f9d4aab9530b');

INSERT INTO sales (sale_date, employee_id, customer_id)
VALUES ('2022-01-15', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '94d847d5-877f-4ade-bbc4-b4ce1fb6224b'),
       ('2022-02-01', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '4810843b-fa99-4eca-befa-1f41447df58b'),
       ('2022-02-10', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '6c2cad11-1ca5-4287-9231-1fedf3a96a9f'),
       ('2022-03-05', '7012327b-d0fd-40be-90ce-4a2490325e97', '3a8ea996-72a6-44f3-b3dd-34c5e81a2032'),
       ('2022-03-12', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '9a63c7b3-5e53-4118-9bc8-ae7c510cf31c');

INSERT INTO sale_details (sale_id, product_id, cant, price)
VALUES ('98c6245e-f4d4-4485-9e54-53aec07c0b03', '5b71df83-113a-4e56-ad54-ba6bd0a55e8f', 1, 1200.00),
       ('98c6245e-f4d4-4485-9e54-53aec07c0b03', '6889c37f-fbee-4cac-a53d-3dd1e8c350a1', 2, 400.00),
       ('34b4e4a7-ff0b-4e06-a4cd-065dd28bea91', '9ae8a603-b354-4e51-9b7b-3bf691f725ca', 1, 20.00),
       ('34b4e4a7-ff0b-4e06-a4cd-065dd28bea91', '7a1dc557-7d19-4e67-8a99-4fc9e02a30b6', 1, 15.00),
       ('e5d6ea98-8cf4-461d-acc0-6dfc789b362f', '73afcdba-273d-4f7c-a8f3-1c79efe0e0c0', 1, 350.00),
       ('8df2d9d4-dec7-4683-b962-02b618d36330', '5b71df83-113a-4e56-ad54-ba6bd0a55e8f', 2, 1200.00),
       ('8df2d9d4-dec7-4683-b962-02b618d36330', '6889c37f-fbee-4cac-a53d-3dd1e8c350a1', 1, 400.00),
       ('9b65e804-6068-4bbf-b6fe-561ed1d4470a', '9ae8a603-b354-4e51-9b7b-3bf691f725ca', 3, 20.00),
       ('9b65e804-6068-4bbf-b6fe-561ed1d4470a', '7a1dc557-7d19-4e67-8a99-4fc9e02a30b6', 2, 15.00),
       ('9b65e804-6068-4bbf-b6fe-561ed1d4470a', '73afcdba-273d-4f7c-a8f3-1c79efe0e0c0', 1, 350.00);

INSERT INTO invoices (invoice_date, employee_id, customer_id, sale_id)
VALUES ('2022-01-15', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '94d847d5-877f-4ade-bbc4-b4ce1fb6224b', '98c6245e-f4d4-4485-9e54-53aec07c0b03'),
       ('2022-02-01', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '4810843b-fa99-4eca-befa-1f41447df58b', '34b4e4a7-ff0b-4e06-a4cd-065dd28bea91'),
       ('2022-02-10', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '6c2cad11-1ca5-4287-9231-1fedf3a96a9f', 'e5d6ea98-8cf4-461d-acc0-6dfc789b362f'),
       ('2022-03-05', '7012327b-d0fd-40be-90ce-4a2490325e97', '3a8ea996-72a6-44f3-b3dd-34c5e81a2032', '8df2d9d4-dec7-4683-b962-02b618d36330'),
       ('2022-03-12', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '9a63c7b3-5e53-4118-9bc8-ae7c510cf31c', '9b65e804-6068-4bbf-b6fe-561ed1d4470a');

INSERT INTO shipments (shipment_date, shipment_status, employee_id, customer_id)
VALUES ('2022-01-10', 'pendiente de entrega', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '94d847d5-877f-4ade-bbc4-b4ce1fb6224b'),
       ('2022-02-05', 'en tránsito', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '9a63c7b3-5e53-4118-9bc8-ae7c510cf31c'),
       ('2022-02-25', 'en tránsito', '7012327b-d0fd-40be-90ce-4a2490325e97', '4810843b-fa99-4eca-befa-1f41447df58b'),
       ('2022-03-10', 'en tránsito', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '6c2cad11-1ca5-4287-9231-1fedf3a96a9f'),
       ('2022-03-20', 'pendiente de entrega', 'c1fff2ce-aa77-47cb-b145-0554595286e0', '3a8ea996-72a6-44f3-b3dd-34c5e81a2032'),
       ('2022-04-05', 'pendiente de entrega', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '94d847d5-877f-4ade-bbc4-b4ce1fb6224b'),
       ('2022-04-15', 'pendiente de entrega', '7012327b-d0fd-40be-90ce-4a2490325e97', '9a63c7b3-5e53-4118-9bc8-ae7c510cf31c'),
       ('2022-05-01', 'entregado', 'c1fff2ce-aa77-47cb-b145-0554595286e0', '6c2cad11-1ca5-4287-9231-1fedf3a96a9f'),
       ('2022-05-20', 'entregado', '68e36a55-b871-4b0b-943d-dda1d1c4ef81', '3a8ea996-72a6-44f3-b3dd-34c5e81a2032'),
       ('2022-06-05', 'entregado', 'c97dce9d-c212-4f92-a2e1-f16d84cf8778', '4810843b-fa99-4eca-befa-1f41447df58b');

INSERT INTO shipping_details (shipment_id, product_id, cant, shipping_address, shiping_cost)
VALUES ('5a7cdb54-3a40-4ba4-8330-06f87e49ec7a', '5b71df83-113a-4e56-ad54-ba6bd0a55e8f', 1, 'Av. Principal 123', 20.00),
       ('5a7cdb54-3a40-4ba4-8330-06f87e49ec7a', '6889c37f-fbee-4cac-a53d-3dd1e8c350a1', 2, 'Calle Norte 456', 30.00),
       ('9934570d-6009-4576-82ae-836e1d7edc74', '7a1dc557-7d19-4e67-8a99-4fc9e02a30b6', 1, 'Av. Sur 789', 80.00),
       ('892def45-aa1e-4513-8c26-d52df9322549', '9ae8a603-b354-4e51-9b7b-3bf691f725ca', 3, 'Calle Este 321', 15.00),
       ('892def45-aa1e-4513-8c26-d52df9322549', '73afcdba-273d-4f7c-a8f3-1c79efe0e0c0', 2, 'Av. Oeste 654', 40.00);


