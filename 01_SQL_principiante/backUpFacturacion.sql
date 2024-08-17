--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)

-- Started on 2024-08-17 15:35:14 -03

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
-- TOC entry 218 (class 1259 OID 16506)
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoice_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_id uuid NOT NULL,
    product_id uuid NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16494)
-- Name: invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_date date DEFAULT now() NOT NULL,
    person_id uuid NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 16477)
-- Name: persons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(60) NOT NULL,
    last_name character varying(60) NOT NULL,
    birthday date NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 216 (class 1259 OID 16486)
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    product_name character varying(30) NOT NULL,
    price numeric(10,2) NOT NULL
);


--
-- TOC entry 3462 (class 0 OID 16506)
-- Dependencies: 218
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoice_items (id, invoice_id, product_id, price, quantity) FROM stdin;
21106f24-cb79-40d4-b9f6-ddacff29d455	d9ec5cf2-4bd0-4922-83b3-87e442486193	43614f3b-efee-465b-8706-cb8937a589fe	14.11	2
c280e306-611d-4b4d-94ca-6d9ae6b0376d	d9ec5cf2-4bd0-4922-83b3-87e442486193	5a6cc715-1a75-43cb-a75f-fdc8389eae77	1.44	1
6acdf418-fb22-4385-81cc-f994c9d5334f	d9ec5cf2-4bd0-4922-83b3-87e442486193	4c0e4b92-0905-4064-8386-eacb9413da38	21.00	3
fb3f43a4-d4ad-487b-bde6-c5ef62ec6869	2734e9a9-2a56-460d-abdc-779d6110473d	5a6cc715-1a75-43cb-a75f-fdc8389eae77	1.44	3
e172170b-3260-45fd-afb5-16254aa8c51b	2734e9a9-2a56-460d-abdc-779d6110473d	4c0e4b92-0905-4064-8386-eacb9413da38	21.00	12
2ae816d4-09a4-4ac5-a264-7dc1cfc1c0cd	b18cb99c-108e-473f-b6a0-92d7561ed415	43614f3b-efee-465b-8706-cb8937a589fe	14.11	1
14b21b4f-2804-4c15-97e0-08d8b571ad45	b18cb99c-108e-473f-b6a0-92d7561ed415	5a6cc715-1a75-43cb-a75f-fdc8389eae77	1.44	5
9b9bcafe-157a-4d5c-b363-701c0dc54df1	fd7ce1d4-0f2d-42b5-ac8a-83fc2bcaf189	5a6cc715-1a75-43cb-a75f-fdc8389eae77	2.00	5
f1c4e301-660e-40ad-8e9f-d55d1da1a06a	9960da1b-8d8f-44d8-a193-80e6f52b289d	43614f3b-efee-465b-8706-cb8937a589fe	14.11	1
8620f3e7-5350-4a61-a5d2-ea038c351ce7	9960da1b-8d8f-44d8-a193-80e6f52b289d	5a6cc715-1a75-43cb-a75f-fdc8389eae77	1.44	12
\.


--
-- TOC entry 3461 (class 0 OID 16494)
-- Dependencies: 217
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoices (id, invoice_date, person_id) FROM stdin;
d9ec5cf2-4bd0-4922-83b3-87e442486193	2024-08-13	524e3d66-ad0c-4586-83fb-a82726749d2e
2734e9a9-2a56-460d-abdc-779d6110473d	2024-08-13	e25ab795-c706-4dd7-8238-0524f92d693f
b18cb99c-108e-473f-b6a0-92d7561ed415	2024-08-13	4f730c6d-1de4-45e1-bb4e-aeeb48fc4c7d
fd7ce1d4-0f2d-42b5-ac8a-83fc2bcaf189	2024-08-13	a321c98c-01de-446e-bbe4-50030dea68ee
9960da1b-8d8f-44d8-a193-80e6f52b289d	2024-08-13	66799c5d-33fc-4777-bb41-2c0610413715
\.


--
-- TOC entry 3459 (class 0 OID 16477)
-- Dependencies: 215
-- Data for Name: persons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.persons (id, first_name, last_name, birthday, created_at, updated_at) FROM stdin;
524e3d66-ad0c-4586-83fb-a82726749d2e	LEONEL	HIDALGO	1998-12-03	2024-08-13 22:22:32.193854	\N
e25ab795-c706-4dd7-8238-0524f92d693f	FIORELLA	FLORES JARA	2000-03-28	2024-08-13 22:22:32.193854	\N
4f730c6d-1de4-45e1-bb4e-aeeb48fc4c7d	FACUNDO	HIDALGO	2001-08-14	2024-08-13 22:22:32.193854	\N
a321c98c-01de-446e-bbe4-50030dea68ee	MABEL	NARANJO	1970-06-18	2024-08-13 22:22:32.193854	\N
66799c5d-33fc-4777-bb41-2c0610413715	ALEJANDRO	HIDALGO	1966-06-04	2024-08-13 22:22:32.193854	\N
1e596def-b097-4112-ba6a-783169006f07	PRUEBA	PROOF	1900-01-01	2024-08-17 12:55:58.194772	\N
\.


--
-- TOC entry 3460 (class 0 OID 16486)
-- Dependencies: 216
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, product_name, price) FROM stdin;
43614f3b-efee-465b-8706-cb8937a589fe	RICE	12.31
5a6cc715-1a75-43cb-a75f-fdc8389eae77	POTATO	1.44
4c0e4b92-0905-4064-8386-eacb9413da38	MEALT	20.00
\.


--
-- TOC entry 3312 (class 2606 OID 16512)
-- Name: invoice_items invoice_items_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_id_pk PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 16500)
-- Name: invoices invoices_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_id_pk PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 16485)
-- Name: persons persons_first_last_name_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_first_last_name_uk UNIQUE (first_name, last_name);


--
-- TOC entry 3304 (class 2606 OID 16483)
-- Name: persons persons_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_id_pk PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 16491)
-- Name: products products_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_pk PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 16493)
-- Name: products products_product_name_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_name_uk UNIQUE (product_name);


--
-- TOC entry 3314 (class 2606 OID 16513)
-- Name: invoice_items invoice_items_invoice_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_invoice_id_fk FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3315 (class 2606 OID 16518)
-- Name: invoice_items invoice_items_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_product_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3313 (class 2606 OID 16501)
-- Name: invoices invoices_person_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_person_id_fk FOREIGN KEY (person_id) REFERENCES public.persons(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2024-08-17 15:35:22 -03

--
-- PostgreSQL database dump complete
--

