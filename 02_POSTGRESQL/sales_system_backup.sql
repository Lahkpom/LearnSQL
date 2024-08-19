--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)

-- Started on 2024-08-19 00:49:00 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16611)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(50) NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16586)
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    customer_address character varying(100) NOT NULL,
    phone character varying(20),
    email_address character varying(50)
);


--
-- TOC entry 216 (class 1259 OID 16597)
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    employee_address character varying(100) NOT NULL,
    phone character varying(20),
    email_address character varying(50),
    salary numeric(10,2),
    hiring_date date DEFAULT now() NOT NULL,
    CONSTRAINT employees_salary_check CHECK ((salary > (0)::numeric))
);


--
-- TOC entry 222 (class 1259 OID 16671)
-- Name: invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_date date DEFAULT now() NOT NULL,
    employee_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    sale_id uuid NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 16617)
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    product_name character varying(50) NOT NULL,
    product_description text,
    price numeric(10,2) NOT NULL,
    inventory_quantity integer NOT NULL,
    supplier_id uuid NOT NULL,
    categorie_id uuid NOT NULL,
    CONSTRAINT products_inventory_quantity_check CHECK ((inventory_quantity >= 0)),
    CONSTRAINT products_price_check CHECK ((price > (0)::numeric))
);


--
-- TOC entry 221 (class 1259 OID 16654)
-- Name: sale_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sale_details (
    sale_id uuid NOT NULL,
    product_id uuid NOT NULL,
    price numeric(10,2) NOT NULL,
    cant integer NOT NULL,
    CONSTRAINT sale_details_cant_check CHECK ((cant > 0)),
    CONSTRAINT sale_details_price_check CHECK ((price > (0)::numeric))
);


--
-- TOC entry 220 (class 1259 OID 16637)
-- Name: sales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sale_date date DEFAULT now() NOT NULL,
    employee_id uuid NOT NULL,
    customer_id uuid NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16725)
-- Name: sales2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sales2 (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    sale_date date DEFAULT now() NOT NULL,
    sale_detail jsonb NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16693)
-- Name: shipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    shipment_date date NOT NULL,
    shipment_status character varying(100) NOT NULL,
    employee_id uuid NOT NULL,
    customer_id uuid NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16709)
-- Name: shipping_details; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_details (
    shipment_id uuid NOT NULL,
    product_id uuid NOT NULL,
    cant integer NOT NULL,
    shipping_address character varying(100) NOT NULL,
    shiping_cost numeric(10,2) NOT NULL,
    CONSTRAINT shipping_details_cant_check CHECK ((cant > 0))
);


--
-- TOC entry 217 (class 1259 OID 16605)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suppliers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    supplier_name character varying(50) NOT NULL,
    supplier_address character varying(50) NOT NULL,
    phone character varying(20),
    email_address character varying(50)
);


--
-- TOC entry 3534 (class 0 OID 16611)
-- Dependencies: 218
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, title) FROM stdin;
403661bf-7655-4d54-aa5c-f9d4aab9530b	Electrónica
62e5927c-45d8-4399-b272-09d787ab51ef	Ropa
1fa46fc2-ae0b-426b-b754-16fb0a2ef437	Hogar
759cfc3f-d277-4ff4-9b29-0503ec587db4	Alimentos
7a133a06-2228-43ea-9ccb-053b981f88ae	Joyería
\.


--
-- TOC entry 3531 (class 0 OID 16586)
-- Dependencies: 215
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customers (id, first_name, last_name, customer_address, phone, email_address) FROM stdin;
3a8ea996-72a6-44f3-b3dd-34c5e81a2032	Juan	Pérez	Calle 123, Ciudad X	555-1234	juan.perez@example.com
6c2cad11-1ca5-4287-9231-1fedf3a96a9f	María	García	Avenida Principal, Ciudad Y	555-5678	maria.garcia@example.com
94d847d5-877f-4ade-bbc4-b4ce1fb6224b	Carlos	González	Calle 456, Ciudad Z	555-9012	carlos.gonzalez@example.com
4810843b-fa99-4eca-befa-1f41447df58b	Laura	Hernández	Avenida Central, Ciudad A	555-3456	laura.hernandez@example.com
9a63c7b3-5e53-4118-9bc8-ae7c510cf31c	Luis	Martínez	Calle 789, Ciudad B	555-7890	luis.martinez@example.com
\.


--
-- TOC entry 3532 (class 0 OID 16597)
-- Dependencies: 216
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.employees (id, first_name, last_name, employee_address, phone, email_address, salary, hiring_date) FROM stdin;
c97dce9d-c212-4f92-a2e1-f16d84cf8778	Juan	González	Calle 123, Ciudad	555-1234	juan.gonzalez@example.com	3000.00	2020-01-15
68e36a55-b871-4b0b-943d-dda1d1c4ef81	María	Rodríguez	Av. Principal, Barrio	555-5678	maria.rodriguez@example.com	3500.00	2019-05-22
7012327b-d0fd-40be-90ce-4a2490325e97	Pedro	López	Calle 45, Sector	555-9012	pedro.lopez@example.com	2800.00	2021-02-28
c1fff2ce-aa77-47cb-b145-0554595286e0	Ana	Martínez	Av. Central, Urbanización	555-3456	ana.martinez@example.com	3200.00	2018-11-10
270e01cb-0e88-4bfa-8305-b5b8ab942799	Luis	Sánchez	Calle 67, Conjunto	555-7890	luis.sanchez@example.com	4000.00	2022-01-01
\.


--
-- TOC entry 3538 (class 0 OID 16671)
-- Dependencies: 222
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoices (id, invoice_date, employee_id, customer_id, sale_id) FROM stdin;
290066d4-0aed-484a-bef2-972c63dfc4b7	2022-01-15	c97dce9d-c212-4f92-a2e1-f16d84cf8778	94d847d5-877f-4ade-bbc4-b4ce1fb6224b	98c6245e-f4d4-4485-9e54-53aec07c0b03
fb27fbf8-c780-47c4-ad4f-30cfe5174c72	2022-02-01	68e36a55-b871-4b0b-943d-dda1d1c4ef81	4810843b-fa99-4eca-befa-1f41447df58b	34b4e4a7-ff0b-4e06-a4cd-065dd28bea91
610966ee-a8e9-4ef1-a03e-b88479d9f6ab	2022-02-10	c97dce9d-c212-4f92-a2e1-f16d84cf8778	6c2cad11-1ca5-4287-9231-1fedf3a96a9f	e5d6ea98-8cf4-461d-acc0-6dfc789b362f
edab47e9-036e-479d-aebc-0473a00ab572	2022-03-05	7012327b-d0fd-40be-90ce-4a2490325e97	3a8ea996-72a6-44f3-b3dd-34c5e81a2032	8df2d9d4-dec7-4683-b962-02b618d36330
1a633f57-1fda-4f24-8aa4-9a556ae862f3	2022-03-12	68e36a55-b871-4b0b-943d-dda1d1c4ef81	9a63c7b3-5e53-4118-9bc8-ae7c510cf31c	9b65e804-6068-4bbf-b6fe-561ed1d4470a
\.


--
-- TOC entry 3535 (class 0 OID 16617)
-- Dependencies: 219
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, product_name, product_description, price, inventory_quantity, supplier_id, categorie_id) FROM stdin;
5b71df83-113a-4e56-ad54-ba6bd0a55e8f	Laptop HP	Laptop de alta gama con procesador i7 y 16GB de RAM	1200.00	10	12365cc4-7adc-47ca-9ada-25d830034eab	403661bf-7655-4d54-aa5c-f9d4aab9530b
6889c37f-fbee-4cac-a53d-3dd1e8c350a1	Impresora Epson	Impresora multifuncional con Wi-Fi	400.00	20	23266542-f4ad-458f-80e6-f1f164724f3c	62e5927c-45d8-4399-b272-09d787ab51ef
9ae8a603-b354-4e51-9b7b-3bf691f725ca	Mouse inalámbrico	Mouse inalámbrico con diseño ergonómico	20.00	50	f431bb58-6744-4864-820c-a4074f95c51a	1fa46fc2-ae0b-426b-b754-16fb0a2ef437
7a1dc557-7d19-4e67-8a99-4fc9e02a30b6	Teclado USB	Teclado USB resistente al agua	15.00	30	71f33178-d389-49f4-be64-f5184509bf61	1fa46fc2-ae0b-426b-b754-16fb0a2ef437
73afcdba-273d-4f7c-a8f3-1c79efe0e0c0	Monitor Samsung	Monitor LED de 27 pulgadas	350.00	15	12365cc4-7adc-47ca-9ada-25d830034eab	403661bf-7655-4d54-aa5c-f9d4aab9530b
\.


--
-- TOC entry 3537 (class 0 OID 16654)
-- Dependencies: 221
-- Data for Name: sale_details; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sale_details (sale_id, product_id, price, cant) FROM stdin;
98c6245e-f4d4-4485-9e54-53aec07c0b03	5b71df83-113a-4e56-ad54-ba6bd0a55e8f	1200.00	1
98c6245e-f4d4-4485-9e54-53aec07c0b03	6889c37f-fbee-4cac-a53d-3dd1e8c350a1	400.00	2
34b4e4a7-ff0b-4e06-a4cd-065dd28bea91	9ae8a603-b354-4e51-9b7b-3bf691f725ca	20.00	1
34b4e4a7-ff0b-4e06-a4cd-065dd28bea91	7a1dc557-7d19-4e67-8a99-4fc9e02a30b6	15.00	1
e5d6ea98-8cf4-461d-acc0-6dfc789b362f	73afcdba-273d-4f7c-a8f3-1c79efe0e0c0	350.00	1
8df2d9d4-dec7-4683-b962-02b618d36330	5b71df83-113a-4e56-ad54-ba6bd0a55e8f	1200.00	2
8df2d9d4-dec7-4683-b962-02b618d36330	6889c37f-fbee-4cac-a53d-3dd1e8c350a1	400.00	1
9b65e804-6068-4bbf-b6fe-561ed1d4470a	9ae8a603-b354-4e51-9b7b-3bf691f725ca	20.00	3
9b65e804-6068-4bbf-b6fe-561ed1d4470a	7a1dc557-7d19-4e67-8a99-4fc9e02a30b6	15.00	2
9b65e804-6068-4bbf-b6fe-561ed1d4470a	73afcdba-273d-4f7c-a8f3-1c79efe0e0c0	350.00	1
\.


--
-- TOC entry 3536 (class 0 OID 16637)
-- Dependencies: 220
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sales (id, sale_date, employee_id, customer_id) FROM stdin;
98c6245e-f4d4-4485-9e54-53aec07c0b03	2022-01-15	c97dce9d-c212-4f92-a2e1-f16d84cf8778	94d847d5-877f-4ade-bbc4-b4ce1fb6224b
34b4e4a7-ff0b-4e06-a4cd-065dd28bea91	2022-02-01	68e36a55-b871-4b0b-943d-dda1d1c4ef81	4810843b-fa99-4eca-befa-1f41447df58b
e5d6ea98-8cf4-461d-acc0-6dfc789b362f	2022-02-10	c97dce9d-c212-4f92-a2e1-f16d84cf8778	6c2cad11-1ca5-4287-9231-1fedf3a96a9f
8df2d9d4-dec7-4683-b962-02b618d36330	2022-03-05	7012327b-d0fd-40be-90ce-4a2490325e97	3a8ea996-72a6-44f3-b3dd-34c5e81a2032
9b65e804-6068-4bbf-b6fe-561ed1d4470a	2022-03-12	68e36a55-b871-4b0b-943d-dda1d1c4ef81	9a63c7b3-5e53-4118-9bc8-ae7c510cf31c
\.


--
-- TOC entry 3541 (class 0 OID 16725)
-- Dependencies: 225
-- Data for Name: sales2; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sales2 (id, sale_date, sale_detail) FROM stdin;
4380a18c-f555-4b52-8a79-669811422145	2023-02-28	{"dni": "6775699LP", "total": 26.75, "cliente": "Juan Perez", "direccion": {"nro": "7B", "ciudad": "La Paz", "descripcion": "Avenida 6 de Agosto"}, "productos": [{"nombre": "Producto 1", "precio": 10.50, "cantidad": 2}, {"nombre": "Producto 2", "precio": 5.75, "cantidad": 1}]}
8f4a3b02-0bbd-4bbe-bb18-7f9e01751b00	2023-02-28	{"dni": "5663345SC", "total": 15.55, "cliente": "William Barra Paredes", "direccion": {"nro": "1234", "ciudad": "Bogotá", "descripcion": "Plaza del estudiante"}, "productos": [{"nombre": "Producto 1", "precio": 10.50, "cantidad": 2}, {"nombre": "Producto 3", "precio": 10.75, "cantidad": 1}]}
ccabe823-ac6d-4d0f-9143-3f62a819edec	2023-02-28	{"dni": "1234CB", "total": 10.50, "cliente": "Pepito Pep", "direccion": {"nro": "1234", "ciudad": "La Paz", "descripcion": "Plaza del estudiante"}, "productos": [{"nombre": "Producto 1", "precio": 10.50, "cantidad": 2}]}
\.


--
-- TOC entry 3539 (class 0 OID 16693)
-- Dependencies: 223
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipments (id, shipment_date, shipment_status, employee_id, customer_id) FROM stdin;
5a7cdb54-3a40-4ba4-8330-06f87e49ec7a	2022-01-10	pendiente de entrega	68e36a55-b871-4b0b-943d-dda1d1c4ef81	94d847d5-877f-4ade-bbc4-b4ce1fb6224b
9934570d-6009-4576-82ae-836e1d7edc74	2022-02-05	en tránsito	c97dce9d-c212-4f92-a2e1-f16d84cf8778	9a63c7b3-5e53-4118-9bc8-ae7c510cf31c
892def45-aa1e-4513-8c26-d52df9322549	2022-02-25	en tránsito	7012327b-d0fd-40be-90ce-4a2490325e97	4810843b-fa99-4eca-befa-1f41447df58b
3e9fc438-c471-491b-b151-6a5c86c1cdd4	2022-03-10	en tránsito	68e36a55-b871-4b0b-943d-dda1d1c4ef81	6c2cad11-1ca5-4287-9231-1fedf3a96a9f
d084e72a-da77-42a0-b177-498995c6a435	2022-03-20	pendiente de entrega	c1fff2ce-aa77-47cb-b145-0554595286e0	3a8ea996-72a6-44f3-b3dd-34c5e81a2032
3b21e13c-bfb0-4bcc-893e-7fdd911243ee	2022-04-05	pendiente de entrega	c97dce9d-c212-4f92-a2e1-f16d84cf8778	94d847d5-877f-4ade-bbc4-b4ce1fb6224b
d5df1102-89ab-446b-845d-2bbda81078eb	2022-04-15	pendiente de entrega	7012327b-d0fd-40be-90ce-4a2490325e97	9a63c7b3-5e53-4118-9bc8-ae7c510cf31c
1b2e51d9-15f0-49e8-a18e-dda7416cfb06	2022-05-01	entregado	c1fff2ce-aa77-47cb-b145-0554595286e0	6c2cad11-1ca5-4287-9231-1fedf3a96a9f
56ca0f3a-3f91-45f4-bccc-a6522ad1464d	2022-05-20	entregado	68e36a55-b871-4b0b-943d-dda1d1c4ef81	3a8ea996-72a6-44f3-b3dd-34c5e81a2032
0db1da67-974b-43ce-b6a5-78dcd2361c20	2022-06-05	entregado	c97dce9d-c212-4f92-a2e1-f16d84cf8778	4810843b-fa99-4eca-befa-1f41447df58b
\.


--
-- TOC entry 3540 (class 0 OID 16709)
-- Dependencies: 224
-- Data for Name: shipping_details; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_details (shipment_id, product_id, cant, shipping_address, shiping_cost) FROM stdin;
5a7cdb54-3a40-4ba4-8330-06f87e49ec7a	5b71df83-113a-4e56-ad54-ba6bd0a55e8f	1	Av. Principal 123	20.00
5a7cdb54-3a40-4ba4-8330-06f87e49ec7a	6889c37f-fbee-4cac-a53d-3dd1e8c350a1	2	Calle Norte 456	30.00
9934570d-6009-4576-82ae-836e1d7edc74	7a1dc557-7d19-4e67-8a99-4fc9e02a30b6	1	Av. Sur 789	80.00
892def45-aa1e-4513-8c26-d52df9322549	9ae8a603-b354-4e51-9b7b-3bf691f725ca	3	Calle Este 321	15.00
892def45-aa1e-4513-8c26-d52df9322549	73afcdba-273d-4f7c-a8f3-1c79efe0e0c0	2	Av. Oeste 654	40.00
\.


--
-- TOC entry 3533 (class 0 OID 16605)
-- Dependencies: 217
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.suppliers (id, supplier_name, supplier_address, phone, email_address) FROM stdin;
23266542-f4ad-458f-80e6-f1f164724f3c	Proveedora de productos electrónicos	Av. Tecnológico 123, Col. Centro, Ciudad de México	55-1234-5678	ventas@proveedora.com
12365cc4-7adc-47ca-9ada-25d830034eab	Distribuidora de alimentos	Calle 5 de Mayo 456, Col. Juárez, Guadalajara	33-9876-5432	ventas@distribuidora.com
f431bb58-6744-4864-820c-a4074f95c51a	Fabricante de textiles	Carretera a Toluca Km. 17, Toluca	722-234-5678	contacto@fabricante.com
71f33178-d389-49f4-be64-f5184509bf61	Mayorista de artículos deportivos	Av. Constitución 789, Col. Zona Centro, Monterrey	81-3456-7890	ventas@mayorista.com
dabafdb3-4581-488e-9380-f7fd3c15a8be	Compañía de suministros industriales	Calle Reforma 321, Col. Centro, Puebla	222-876-5432	ventas@suministros.com
\.


--
-- TOC entry 3356 (class 2606 OID 16616)
-- Name: categories categories_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_id_pk PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 16738)
-- Name: categories categories_title_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_title_uk UNIQUE (title);


--
-- TOC entry 3342 (class 2606 OID 16740)
-- Name: customers customers_email_address_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_address_uk UNIQUE (email_address);


--
-- TOC entry 3344 (class 2606 OID 16591)
-- Name: customers customers_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_id_pk PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 16742)
-- Name: employees employees_email_address_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_address_uk UNIQUE (email_address);


--
-- TOC entry 3348 (class 2606 OID 16604)
-- Name: employees employees_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_id_pk PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 16677)
-- Name: invoices invoices_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_id_pk PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 16626)
-- Name: products products_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_pk PRIMARY KEY (id);


--
-- TOC entry 3362 (class 2606 OID 16744)
-- Name: products products_name_description_supplier_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_description_supplier_uk UNIQUE (product_name, product_description, supplier_id);


--
-- TOC entry 3366 (class 2606 OID 16660)
-- Name: sale_details sale_details_sale_product_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_details
    ADD CONSTRAINT sale_details_sale_product_id_pk PRIMARY KEY (sale_id, product_id);


--
-- TOC entry 3374 (class 2606 OID 16733)
-- Name: sales2 sales2_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales2
    ADD CONSTRAINT sales2_id_pk PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 16643)
-- Name: sales sales_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_id_pk PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 16698)
-- Name: shipments shipments_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_id_pk PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 16714)
-- Name: shipping_details shipping_details_shipment_product_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_details
    ADD CONSTRAINT shipping_details_shipment_product_id_pk PRIMARY KEY (shipment_id, product_id);


--
-- TOC entry 3350 (class 2606 OID 16748)
-- Name: suppliers suppliers_email_address_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_email_address_uk UNIQUE (email_address);


--
-- TOC entry 3352 (class 2606 OID 16610)
-- Name: suppliers suppliers_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_id_pk PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 16746)
-- Name: suppliers suppliers_name_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_name_uk UNIQUE (supplier_name);


--
-- TOC entry 3381 (class 2606 OID 16683)
-- Name: invoices invoices_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_customer_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3382 (class 2606 OID 16678)
-- Name: invoices invoices_employee_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_employee_id_fk FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- TOC entry 3383 (class 2606 OID 16688)
-- Name: invoices invoices_sales_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_sales_id_fk FOREIGN KEY (sale_id) REFERENCES public.sales(id);


--
-- TOC entry 3375 (class 2606 OID 16632)
-- Name: products products_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_categories_id_fk FOREIGN KEY (categorie_id) REFERENCES public.categories(id);


--
-- TOC entry 3376 (class 2606 OID 16627)
-- Name: products products_suppliers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_suppliers_id_fk FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id);


--
-- TOC entry 3379 (class 2606 OID 16666)
-- Name: sale_details sale_details_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_details
    ADD CONSTRAINT sale_details_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3380 (class 2606 OID 16661)
-- Name: sale_details sale_details_sales_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sale_details
    ADD CONSTRAINT sale_details_sales_id_fk FOREIGN KEY (sale_id) REFERENCES public.sales(id);


--
-- TOC entry 3377 (class 2606 OID 16649)
-- Name: sales sales_customers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_customers_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3378 (class 2606 OID 16644)
-- Name: sales sales_employees_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_employees_id_fk FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- TOC entry 3384 (class 2606 OID 16704)
-- Name: shipments shipments_customer_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_customer_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- TOC entry 3385 (class 2606 OID 16699)
-- Name: shipments shipments_employee_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_employee_id_fk FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- TOC entry 3386 (class 2606 OID 16720)
-- Name: shipping_details shipping_details_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_details
    ADD CONSTRAINT shipping_details_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 3387 (class 2606 OID 16715)
-- Name: shipping_details shipping_details_shipments_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_details
    ADD CONSTRAINT shipping_details_shipments_id_fk FOREIGN KEY (shipment_id) REFERENCES public.shipments(id);


-- Completed on 2024-08-19 00:49:06 -03

--
-- PostgreSQL database dump complete
--

