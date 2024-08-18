--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-1.pgdg24.04+1)

-- Started on 2024-08-18 11:39:16 -03

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
-- TOC entry 215 (class 1259 OID 16524)
-- Name: alpha; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alpha (
    id integer NOT NULL,
    description character varying(10) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16529)
-- Name: beta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.beta (
    id integer NOT NULL,
    title character varying(10) NOT NULL
);


--
-- TOC entry 3432 (class 0 OID 16524)
-- Dependencies: 215
-- Data for Name: alpha; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alpha (id, description) FROM stdin;
1	UNO
2	DOS
3	TRES
4	CUATRO
\.


--
-- TOC entry 3433 (class 0 OID 16529)
-- Dependencies: 216
-- Data for Name: beta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.beta (id, title) FROM stdin;
1	ONE
2	TWO
3	THREE
\.


--
-- TOC entry 3287 (class 2606 OID 16528)
-- Name: alpha alpha_id_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alpha
    ADD CONSTRAINT alpha_id_pk PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 16532)
-- Name: beta beta_alpha_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta
    ADD CONSTRAINT beta_alpha_id_fk FOREIGN KEY (id) REFERENCES public.alpha(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2024-08-18 11:39:22 -03

--
-- PostgreSQL database dump complete
--

