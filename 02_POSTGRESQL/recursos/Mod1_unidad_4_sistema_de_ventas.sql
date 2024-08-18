-- Creación de la base de datos "sistema_ventas"
CREATE DATABASE sistema_ventas;

-- Creación de la tabla "Clientes"
CREATE TABLE clientes
(
    id_cliente         SERIAL PRIMARY KEY NOT NULL,
    nombres            VARCHAR(50)        NOT NULL,
    apellidos          VARCHAR(50)        NOT NULL,
    direccion          VARCHAR(100)       NOT NULL,
    telefono           VARCHAR(20),
    correo_electronico VARCHAR(50)
);

-- Creación de la tabla "Empleados"
CREATE TABLE empleados
(
    id_empleado        SERIAL PRIMARY KEY NOT NULL,
    nombres            VARCHAR(50)        NOT NULL,
    apellidos          VARCHAR(50)        NOT NULL,
    direccion          VARCHAR(100)       NOT NULL,
    telefono           VARCHAR(20),
    correo_electronico VARCHAR(50),
    salario            NUMERIC(10, 2),
    fecha_contratacion DATE
);

-- Creación de la tabla "Proveedores"
CREATE TABLE proveedores
(
    id_proveedor       SERIAL PRIMARY KEY NOT NULL,
    nombre             VARCHAR(50)        NOT NULL,
    direccion          VARCHAR(100)       NOT NULL,
    telefono           VARCHAR(20),
    correo_electronico VARCHAR(50)
);

-- Creación de la tabla "Categorias"
CREATE TABLE categorias
(
    id_categoria SERIAL PRIMARY KEY NOT NULL,
    nombre       VARCHAR(50)        NOT NULL
);

-- Creación de la tabla "Productos"
CREATE TABLE productos
(
    id_producto         SERIAL PRIMARY KEY NOT NULL,
    nombre              VARCHAR(50)        NOT NULL,
    descripcion         TEXT,
    precio              NUMERIC(10, 2)     NOT NULL,
    cantidad_inventario INTEGER            NOT NULL,
    proveedor_id        INTEGER REFERENCES proveedores (id_proveedor),
    categoria_id        INTEGER REFERENCES categorias (id_categoria)
);

-- Creación de la tabla "Ventas"
CREATE TABLE ventas
(
    id_venta    SERIAL PRIMARY KEY NOT NULL,
    fecha       DATE               NOT NULL,
    empleado_id INTEGER REFERENCES empleados (id_empleado),
    cliente_id  INTEGER REFERENCES clientes (id_cliente)
);

-- Creación de la tabla "Detalle_Venta"
CREATE TABLE detalle_venta
(
    venta_id    INTEGER REFERENCES ventas (id_venta),
    producto_id INTEGER REFERENCES productos (id_producto),
    cantidad    INTEGER        NOT NULL,
    precio      NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (venta_id, producto_id)
);

-- Creación de la tabla "Facturas"
CREATE TABLE facturas
(
    id_factura  SERIAL PRIMARY KEY NOT NULL,
    fecha       DATE               NOT NULL,
    empleado_id INTEGER REFERENCES empleados (id_empleado),
    cliente_id  INTEGER REFERENCES clientes (id_cliente),
    venta_id    INTEGER REFERENCES ventas (id_venta)
);

-- Creación de la tabla "Envios"
CREATE TABLE envios
(
    id_envio    SERIAL PRIMARY KEY,
    fecha       DATE         NOT NULL,
    estado      VARCHAR(100) NOT NULL,
    empleado_id INTEGER REFERENCES empleados (id_empleado),
    cliente_id  INTEGER REFERENCES clientes (id_cliente)
);

-- Creación de la tabla "Detalle_Envio"
CREATE TABLE detalle_envio
(
    envio_id        INTEGER REFERENCES envios (id_envio),
    producto_id     INTEGER REFERENCES productos (id_producto),
    cantidad        INTEGER        NOT NULL,
    direccion_envio VARCHAR(100)   NOT NULL,
    costo_envio     NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (envio_id, producto_id)
);

INSERT INTO clientes (nombres, apellidos, direccion, telefono, correo_electronico)
VALUES ('Juan', 'Pérez', 'Calle 123, Ciudad X', '555-1234', 'juan.perez@example.com'),
       ('María', 'García', 'Avenida Principal, Ciudad Y', '555-5678', 'maria.garcia@example.com'),
       ('Carlos', 'González', 'Calle 456, Ciudad Z', '555-9012', 'carlos.gonzalez@example.com'),
       ('Laura', 'Hernández', 'Avenida Central, Ciudad A', '555-3456', 'laura.hernandez@example.com'),
       ('Luis', 'Martínez', 'Calle 789, Ciudad B', '555-7890', 'luis.martinez@example.com');


INSERT INTO empleados (nombres, apellidos, direccion, telefono, correo_electronico, salario, fecha_contratacion)
VALUES ('Juan', 'González', 'Calle 123, Ciudad', '555-1234', 'juan.gonzalez@example.com', 3000.00, '2020-01-15'),
       ('María', 'Rodríguez', 'Av. Principal, Barrio', '555-5678', 'maria.rodriguez@example.com', 3500.00,
        '2019-05-22'),
       ('Pedro', 'López', 'Calle 45, Sector', '555-9012', 'pedro.lopez@example.com', 2800.00, '2021-02-28'),
       ('Ana', 'Martínez', 'Av. Central, Urbanización', '555-3456', 'ana.martinez@example.com', 3200.00, '2018-11-10'),
       ('Luis', 'Sánchez', 'Calle 67, Conjunto', '555-7890', 'luis.sanchez@example.com', 4000.00, '2022-01-01');

INSERT INTO proveedores (nombre, direccion, telefono, correo_electronico)
VALUES ('Proveedora de productos electrónicos', 'Av. Tecnológico 123, Col. Centro, Ciudad de México', '55-1234-5678',
        'ventas@proveedora.com'),
       ('Distribuidora de alimentos', 'Calle 5 de Mayo 456, Col. Juárez, Guadalajara', '33-9876-5432',
        'ventas@distribuidora.com'),
       ('Fabricante de textiles', 'Carretera a Toluca Km. 17, Toluca', '722-234-5678', 'contacto@fabricante.com'),
       ('Mayorista de artículos deportivos', 'Av. Constitución 789, Col. Zona Centro, Monterrey', '81-3456-7890',
        'ventas@mayorista.com'),
       ('Compañía de suministros industriales', 'Calle Reforma 321, Col. Centro, Puebla', '222-876-5432',
        'ventas@suministros.com');

INSERT INTO categorias (nombre)
VALUES ('Electrónica'),
       ('Ropa'),
       ('Hogar'),
       ('Alimentos'),
       ('Joyería');

INSERT INTO productos(nombre, descripcion, precio, cantidad_inventario, proveedor_id, categoria_id)
VALUES ('Laptop HP', 'Laptop de alta gama con procesador i7 y 16GB de RAM', 1200.00, 10, 2, 1),
       ('Impresora Epson', 'Impresora multifuncional con Wi-Fi', 400.00, 20, 1, 2),
       ('Mouse inalámbrico', 'Mouse inalámbrico con diseño ergonómico', 20.00, 50, 3, 3),
       ('Teclado USB', 'Teclado USB resistente al agua', 15.00, 30, 4, 3),
       ('Monitor Samsung', 'Monitor LED de 27 pulgadas', 350.00, 15, 2, 1);

INSERT INTO ventas (fecha, empleado_id, cliente_id)
VALUES ('2022-01-15', 1, 3),
       ('2022-02-01', 2, 4),
       ('2022-02-10', 1, 2),
       ('2022-03-05', 3, 1),
       ('2022-03-12', 2, 5);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad, precio)
VALUES (1, 1, 1, 1200.00),
       (1, 2, 2, 400.00),
       (2, 3, 1, 20.00),
       (2, 4, 1, 15.00),
       (3, 5, 1, 350.00),
       (4, 1, 2, 1200.00),
       (4, 2, 1, 400.00),
       (5, 3, 3, 20.00),
       (5, 4, 2, 15.00),
       (5, 5, 1, 350.00);

INSERT INTO facturas(fecha, empleado_id, cliente_id, venta_id)
VALUES ('2022-01-15', 1, 3, 1),
       ('2022-02-01', 2, 4, 2),
       ('2022-02-10', 1, 2, 3),
       ('2022-03-05', 3, 1, 4),
       ('2022-03-12', 2, 5, 5);

INSERT INTO envios (fecha, estado, empleado_id, cliente_id)
VALUES ('2022-01-10', 'pendiente de entrega', 2, 3),
       ('2022-02-05', 'en tránsito', 1, 5),
       ('2022-02-25', 'en tránsito', 3, 4),
       ('2022-03-10', 'en tránsito', 2, 2),
       ('2022-03-20', 'pendiente de entrega', 4, 1),
       ('2022-04-05', 'pendiente de entrega', 1, 3),
       ('2022-04-15', 'pendiente de entrega', 3, 5),
       ('2022-05-01', 'entregado', 4, 2),
       ('2022-05-20', 'entregado', 2, 1),
       ('2022-06-05', 'entregado', 1, 4);

INSERT INTO detalle_envio (envio_id, producto_id, cantidad, direccion_envio, costo_envio)
VALUES (1, 1, 1, 'Av. Principal 123', 20.00),
       (1, 2, 2, 'Calle Norte 456', 30.00),
       (2, 4, 1, 'Av. Sur 789', 80.00),
       (3, 3, 3, 'Calle Este 321', 15.00),
       (3, 5, 2, 'Av. Oeste 654', 40.00);



