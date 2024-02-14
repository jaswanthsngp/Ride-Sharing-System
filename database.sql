--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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
-- Name: companion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companion (
    cab_no character varying NOT NULL,
    user_id integer,
    loc_x integer DEFAULT 0,
    loc_y integer DEFAULT 0,
    occupied boolean DEFAULT false
);


ALTER TABLE public.companion OWNER TO postgres;

--
-- Name: places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.places (
    place_id integer NOT NULL,
    place_name character varying NOT NULL,
    loc_x integer DEFAULT 0 NOT NULL,
    loc_y integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.places OWNER TO postgres;

--
-- Name: places_place_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.places_place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.places_place_id_seq OWNER TO postgres;

--
-- Name: places_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.places_place_id_seq OWNED BY public.places.place_id;


--
-- Name: ride; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ride (
    ride_id integer NOT NULL,
    companion_id character varying NOT NULL,
    traveler_id integer NOT NULL,
    source_id integer NOT NULL,
    destination_id integer NOT NULL
);


ALTER TABLE public.ride OWNER TO postgres;

--
-- Name: ride_ride_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ride_ride_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ride_ride_id_seq OWNER TO postgres;

--
-- Name: ride_ride_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ride_ride_id_seq OWNED BY public.ride.ride_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    role character varying DEFAULT 'traveller'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: places place_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places ALTER COLUMN place_id SET DEFAULT nextval('public.places_place_id_seq'::regclass);


--
-- Name: ride ride_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride ALTER COLUMN ride_id SET DEFAULT nextval('public.ride_ride_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: companion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companion (cab_no, user_id, loc_x, loc_y, occupied) FROM stdin;
AB16CD1234	2	9	7	f
AB07CD6789	14	9	7	f
AB01CD1234	17	0	0	f
KA07BC1234	18	0	0	f
AB15CD5678	16	6	6	f
\.


--
-- Data for Name: places; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.places (place_id, place_name, loc_x, loc_y) FROM stdin;
1	A	3	5
2	B	2	6
3	C	6	2
4	D	9	7
5	E	6	6
6	F	1	4
7	G	4	8
8	H	3	2
9	I	2	9
10	O	0	0
\.


--
-- Data for Name: ride; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ride (ride_id, companion_id, traveler_id, source_id, destination_id) FROM stdin;
5	AB16CD1234	1	8	4
7	AB07CD6789	15	1	4
8	AB15CD5678	2	2	5
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, email, password, role) FROM stdin;
1	admin	admin	admin	admin
2	user1	user1@example.com	user1	companion
3	user2	user2@example.com	user2	traveller
13	user3	user3@example.com	user3	traveler
14	user4	user4@example.com	user4	companion
15	user5	user5@email.com	user5	traveler
16	user6	user6@email.com	user6	companion
17	user7	user7@email.com	user7	companion
18	user13	user13@example.com	user13	companion
\.


--
-- Name: places_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.places_place_id_seq', 10, true);


--
-- Name: ride_ride_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ride_ride_id_seq', 8, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 18, true);


--
-- Name: companion companion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_pkey PRIMARY KEY (cab_no);


--
-- Name: places places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_pkey PRIMARY KEY (place_id);


--
-- Name: places places_place_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.places
    ADD CONSTRAINT places_place_name_key UNIQUE (place_name);


--
-- Name: ride ride_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_pkey PRIMARY KEY (ride_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: companion companion_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: ride ride_companion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_companion_id_fkey FOREIGN KEY (companion_id) REFERENCES public.companion(cab_no);


--
-- Name: ride ride_destination_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_destination_id_fkey FOREIGN KEY (destination_id) REFERENCES public.places(place_id);


--
-- Name: ride ride_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.places(place_id);


--
-- Name: ride ride_traveler_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ride
    ADD CONSTRAINT ride_traveler_id_fkey FOREIGN KEY (traveler_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

