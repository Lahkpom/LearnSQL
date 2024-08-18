--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)

-- Started on 2024-08-18 11:39:52 -03

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
-- TOC entry 216 (class 1259 OID 16396)
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    persons_id uuid NOT NULL,
    job_name character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 215 (class 1259 OID 16389)
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
-- TOC entry 217 (class 1259 OID 16408)
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    persons_id uuid NOT NULL,
    carrer character varying(50) NOT NULL,
    begging date DEFAULT now() NOT NULL,
    ending date
);


--
-- TOC entry 3448 (class 0 OID 16396)
-- Dependencies: 216
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobs (id, persons_id, job_name, created_at, updated_at) FROM stdin;
805f7b62-9a5b-4c5a-8570-d1fd3a107d0b	084deebb-33ef-4697-b7b3-ae742ea3030e	POLICIA FEDERAL ARGENTINA	2024-08-12 15:55:12.245275	\N
d5d07500-8efa-46db-ad49-90dd68c7ed6e	f96a348c-3da4-46ca-bfe3-9c32f6d39266	REAL STATE AGENT	2024-08-12 15:55:32.371384	\N
\.


--
-- TOC entry 3447 (class 0 OID 16389)
-- Dependencies: 215
-- Data for Name: persons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.persons (id, first_name, last_name, birthday, created_at, updated_at) FROM stdin;
084deebb-33ef-4697-b7b3-ae742ea3030e	LEONEL	HIDALGO	1998-12-03	2024-08-12 15:51:03.111706	\N
ab68d298-996c-4b43-815b-d95fcbc1fd8f	FIORELLA	FLORES JARA	2000-03-28	2024-08-12 15:51:32.753585	\N
f96a348c-3da4-46ca-bfe3-9c32f6d39266	FACUNDO	HIDALGO	2001-08-14	2024-08-12 15:51:54.639494	\N
411ef3fa-49b5-44fd-8ca5-7c39e46251a0	MABEL	NARANJO	1970-06-18	2024-08-12 15:52:17.24979	\N
7f5bad6a-0e07-469a-90e2-a06626cf0a0d	ALEJANDRO	HIDALGO	1966-06-04	2024-08-12 15:52:45.681273	\N
\.


--
-- TOC entry 3449 (class 0 OID 16408)
-- Dependencies: 217
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.students (id, persons_id, carrer, begging, ending) FROM stdin;
603f7a38-7a1a-449a-9a49-c501d65571c4	084deebb-33ef-4697-b7b3-ae742ea3030e	PROGRAMMER	2022-01-01	\N
1d7f4efd-142c-4b41-97bd-afd179e59e02	ab68d298-996c-4b43-815b-d95fcbc1fd8f	CLOTHE DESIGNER	2021-01-01	\N
\.


--
-- TOC entry 3299 (class 2606 OID 16402)
-- Name: jobs jobs_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_id_pk PRIMARY KEY (id);


--
-- TOC entry 3297 (class 2606 OID 16395)
-- Name: persons persons_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persons
    ADD CONSTRAINT persons_id_pk PRIMARY KEY (id);


--
-- TOC entry 3301 (class 2606 OID 16414)
-- Name: students students_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_id_pk PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 16403)
-- Name: jobs jobs_persons_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_persons_id_fk FOREIGN KEY (persons_id) REFERENCES public.persons(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3303 (class 2606 OID 16415)
-- Name: students students_persons_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_persons_id_fk FOREIGN KEY (persons_id) REFERENCES public.persons(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE jobs; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT ON TABLE public.jobs TO lahkpom;


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE persons; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT ON TABLE public.persons TO lahkpom;


--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE students; Type: ACL; Schema: public; Owner: -
--

GRANT SELECT ON TABLE public.students TO lahkpom;


-- Completed on 2024-08-18 11:39:58 -03

--
-- PostgreSQL database dump complete
--

