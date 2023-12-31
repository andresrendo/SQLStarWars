PGDMP     2                    {            starwarsdef    15.3    15.3 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16791    starwarsdef    DATABASE     �   CREATE DATABASE starwarsdef WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Venezuela.1252';
    DROP DATABASE starwarsdef;
                postgres    false            n           1247    16793 	   dieta_dom    DOMAIN     s  CREATE DOMAIN public.dieta_dom AS character varying(20)
	CONSTRAINT dieta_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Herbívoro'::character varying)::text, ('Carnívoro'::character varying)::text, ('Omnívoros'::character varying)::text, ('Carroñeros'::character varying)::text, ('Geófagos'::character varying)::text, ('Electrófago'::character varying)::text])));
    DROP DOMAIN public.dieta_dom;
       public          postgres    false            r           1247    16796 
   genero_dom    DOMAIN       CREATE DOMAIN public.genero_dom AS character varying(5)
	CONSTRAINT genero_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('M'::character varying)::text, ('F'::character varying)::text, ('Desc'::character varying)::text, ('Otro'::character varying)::text])));
    DROP DOMAIN public.genero_dom;
       public          postgres    false            v           1247    16799    medio_tipo_ps_dom    DOMAIN     �   CREATE DOMAIN public.medio_tipo_ps_dom AS character varying(15)
	CONSTRAINT medio_tipo_ps_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Animada'::character varying)::text, ('Live-action'::character varying)::text, ('Otro'::character varying)::text])));
 &   DROP DOMAIN public.medio_tipo_ps_dom;
       public          postgres    false            z           1247    16802    tipo_actor_dom    DOMAIN     �   CREATE DOMAIN public.tipo_actor_dom AS character varying(20)
	CONSTRAINT tipo_actor_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Interpreta'::character varying)::text, ('Presta su voz'::character varying)::text])));
 #   DROP DOMAIN public.tipo_actor_dom;
       public          postgres    false            ~           1247    16805    tipo_af_dom    DOMAIN     �   CREATE DOMAIN public.tipo_af_dom AS character varying(20)
	CONSTRAINT tipo_af_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Organización'::character varying)::text, ('Facción'::character varying)::text, ('Gobierno'::character varying)::text])));
     DROP DOMAIN public.tipo_af_dom;
       public          postgres    false            �           1247    16808    tipo_tripulacion_dom    DOMAIN     (  CREATE DOMAIN public.tipo_tripulacion_dom AS character varying(20)
	CONSTRAINT tipo_tripulacion_dom_check CHECK (((VALUE)::text = ANY (ARRAY[('Piloto'::character varying)::text, ('Copiloto'::character varying)::text, ('Artillero'::character varying)::text, ('Otro'::character varying)::text])));
 )   DROP DOMAIN public.tipo_tripulacion_dom;
       public          postgres    false            �            1255    16810    calculo_ganancia()    FUNCTION       CREATE FUNCTION public.calculo_ganancia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.Ganancia = NEW.Ingreso_taquilla - NEW.coste_prod;
	IF NEW.Ganancia < 0 THEN
		RAISE NOTICE 'La ganancia es negativa. ¿Desea continuar?';
	END IF;
RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.calculo_ganancia();
       public          postgres    false            �            1255    16811    validar_modelo_nave()    FUNCTION     `  CREATE FUNCTION public.validar_modelo_nave() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (NEW.Modelo = 'Destructor Estelar') AND ((NEW.Longitud < 900) OR (NEW.Uso != 'Combate')) THEN
RAISE EXCEPTION 'Los Destructores Estelares deben tener una longitud mayor a 900 metros y su uso es únicamente de Combate';
	END IF;
	RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.validar_modelo_nave();
       public          postgres    false            �            1259    16812    actor    TABLE       CREATE TABLE public.actor (
    nombre_actor character varying(255) NOT NULL,
    apellido_actor character varying(255) NOT NULL,
    fecha_nacimiento character varying(255),
    nacionalidad character varying(255),
    genero public.genero_dom,
    tipo public.tipo_actor_dom
);
    DROP TABLE public.actor;
       public         heap    postgres    false    882    890            �            1259    16817 
   afiliacion    TABLE     �   CREATE TABLE public.afiliacion (
    nombre_af character varying(255) NOT NULL,
    tipo_af public.tipo_af_dom,
    nombre_planeta character varying(255)
);
    DROP TABLE public.afiliacion;
       public         heap    postgres    false    894            �            1259    16822    afiliado    TABLE     �   CREATE TABLE public.afiliado (
    nombre_af character varying(255) NOT NULL,
    fecha_af date NOT NULL,
    nombre_personaje character varying(255) NOT NULL
);
    DROP TABLE public.afiliado;
       public         heap    postgres    false            �            1259    16827    aparece    TABLE     t   CREATE TABLE public.aparece (
    nombre_personaje character varying(255) NOT NULL,
    idmedio integer NOT NULL
);
    DROP TABLE public.aparece;
       public         heap    postgres    false            �            1259    16830    aparece_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.aparece_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.aparece_idmedio_seq;
       public          postgres    false    217                       0    0    aparece_idmedio_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.aparece_idmedio_seq OWNED BY public.aparece.idmedio;
          public          postgres    false    218            �            1259    16831    ciudad    TABLE     �   CREATE TABLE public.ciudad (
    nombre_ciudad character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
    DROP TABLE public.ciudad;
       public         heap    postgres    false            �            1259    16836    combate    TABLE     �   CREATE TABLE public.combate (
    participante1 character varying(255) NOT NULL,
    participante2 character varying(255) NOT NULL,
    idmedio integer NOT NULL,
    fecha_combate date NOT NULL,
    lugar_combate character varying(255)
);
    DROP TABLE public.combate;
       public         heap    postgres    false            �            1259    16841    combate_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.combate_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.combate_idmedio_seq;
       public          postgres    false    220                       0    0    combate_idmedio_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.combate_idmedio_seq OWNED BY public.combate.idmedio;
          public          postgres    false    221            �            1259    16842    criatura    TABLE     �   CREATE TABLE public.criatura (
    color_piel character varying(255),
    dieta public.dieta_dom,
    id_especie integer NOT NULL
);
    DROP TABLE public.criatura;
       public         heap    postgres    false    878            �            1259    16847    criatura_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.criatura_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.criatura_id_especie_seq;
       public          postgres    false    222                       0    0    criatura_id_especie_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.criatura_id_especie_seq OWNED BY public.criatura.id_especie;
          public          postgres    false    223            �            1259    16848    dueño    TABLE     �   CREATE TABLE public."dueño" (
    id_nave integer NOT NULL,
    nombre_personaje character varying(255) NOT NULL,
    fecha_compra date NOT NULL
);
    DROP TABLE public."dueño";
       public         heap    postgres    false            �            1259    16851    dueño_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE public."dueño_id_nave_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public."dueño_id_nave_seq";
       public          postgres    false    224                       0    0    dueño_id_nave_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."dueño_id_nave_seq" OWNED BY public."dueño".id_nave;
          public          postgres    false    225            �            1259    16852    especie    TABLE     d   CREATE TABLE public.especie (
    idioma character varying(255),
    id_especie integer NOT NULL
);
    DROP TABLE public.especie;
       public         heap    postgres    false            �            1259    16855    especie_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.especie_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.especie_id_especie_seq;
       public          postgres    false    226                       0    0    especie_id_especie_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.especie_id_especie_seq OWNED BY public.especie.id_especie;
          public          postgres    false    227            �            1259    16856    humano    TABLE     �   CREATE TABLE public.humano (
    fecha_nacimiento date,
    fecha_muerte date,
    id_especie integer NOT NULL,
    CONSTRAINT fecha_muerte_ck CHECK ((fecha_nacimiento < fecha_muerte))
);
    DROP TABLE public.humano;
       public         heap    postgres    false            �            1259    16860    humano_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.humano_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.humano_id_especie_seq;
       public          postgres    false    228                       0    0    humano_id_especie_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.humano_id_especie_seq OWNED BY public.humano.id_especie;
          public          postgres    false    229            �            1259    16861    idiomas    TABLE     �   CREATE TABLE public.idiomas (
    idioma character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
    DROP TABLE public.idiomas;
       public         heap    postgres    false            �            1259    16866    interpretado    TABLE     �   CREATE TABLE public.interpretado (
    nombre_personaje character varying(255) NOT NULL,
    nombre_actor character varying(255) NOT NULL,
    apellido_actor character varying(255) NOT NULL,
    id_medio integer NOT NULL
);
     DROP TABLE public.interpretado;
       public         heap    postgres    false            �            1259    16871    lugares_interes    TABLE     �   CREATE TABLE public.lugares_interes (
    lugar character varying(255) NOT NULL,
    nombre_ciudad character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
 #   DROP TABLE public.lugares_interes;
       public         heap    postgres    false            �            1259    16876    medio    TABLE       CREATE TABLE public.medio (
    id integer NOT NULL,
    titulo character varying(255),
    fecha_estreno date,
    rating double precision,
    sinopsis text,
    CONSTRAINT rating_ck CHECK (((rating <= (5)::double precision) AND (rating >= (1)::double precision)))
);
    DROP TABLE public.medio;
       public         heap    postgres    false            �            1259    16882    medio_id_seq    SEQUENCE     �   CREATE SEQUENCE public.medio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.medio_id_seq;
       public          postgres    false    233                       0    0    medio_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.medio_id_seq OWNED BY public.medio.id;
          public          postgres    false    234            �            1259    16883    nave    TABLE     �   CREATE TABLE public.nave (
    id_nave integer NOT NULL,
    nombre_nave character varying(255),
    fabricante character varying(255),
    longitud double precision,
    uso character varying(255),
    modelo character varying(255)
);
    DROP TABLE public.nave;
       public         heap    postgres    false            �            1259    16888    nave_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE public.nave_id_nave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.nave_id_nave_seq;
       public          postgres    false    235                       0    0    nave_id_nave_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.nave_id_nave_seq OWNED BY public.nave.id_nave;
          public          postgres    false    236            �            1259    16889    origen    TABLE     �   CREATE TABLE public.origen (
    nombre_personaje character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
    DROP TABLE public.origen;
       public         heap    postgres    false            �            1259    16894    pelicula    TABLE        CREATE TABLE public.pelicula (
    idmedio integer NOT NULL,
    duracion integer,
    distribuidor character varying(255),
    coste_prod double precision,
    tipo_pelicula public.medio_tipo_ps_dom,
    ingreso_taquilla double precision,
    ganancia double precision,
    nombre_director character varying(255),
    apellido_director character varying(255),
    CONSTRAINT pelicula_valores_ck CHECK (((duracion > 0) AND (coste_prod > (0)::double precision) AND (ingreso_taquilla > (0)::double precision)))
);
    DROP TABLE public.pelicula;
       public         heap    postgres    false    886            �            1259    16900    pelicula_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.pelicula_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pelicula_idmedio_seq;
       public          postgres    false    238                       0    0    pelicula_idmedio_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.pelicula_idmedio_seq OWNED BY public.pelicula.idmedio;
          public          postgres    false    239            �            1259    16901 	   personaje    TABLE     f  CREATE TABLE public.personaje (
    nombre_personaje character varying(255) NOT NULL,
    nombre_planeta character varying(255),
    genero public.genero_dom,
    altura double precision,
    peso double precision,
    id_especie integer NOT NULL,
    CONSTRAINT alturapeso_ck CHECK (((altura > (0)::double precision) AND (peso > (0)::double precision)))
);
    DROP TABLE public.personaje;
       public         heap    postgres    false    882            �            1259    16907    personaje_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.personaje_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.personaje_id_especie_seq;
       public          postgres    false    240                       0    0    personaje_id_especie_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.personaje_id_especie_seq OWNED BY public.personaje.id_especie;
          public          postgres    false    241            �            1259    16908    planeta    TABLE     �   CREATE TABLE public.planeta (
    nombre_planeta character varying(255) NOT NULL,
    sistema_solar character varying(255) NOT NULL,
    sector character varying(255),
    clima character varying(255)
);
    DROP TABLE public.planeta;
       public         heap    postgres    false            �            1259    16913    plataformas    TABLE     q   CREATE TABLE public.plataformas (
    idmedio integer NOT NULL,
    plataforma character varying(50) NOT NULL
);
    DROP TABLE public.plataformas;
       public         heap    postgres    false            �            1259    16916    plataformas_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.plataformas_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.plataformas_idmedio_seq;
       public          postgres    false    243                       0    0    plataformas_idmedio_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.plataformas_idmedio_seq OWNED BY public.plataformas.idmedio;
          public          postgres    false    244            �            1259    16917    robot    TABLE     �   CREATE TABLE public.robot (
    creador character varying(255),
    clase character varying(255),
    id_especie integer NOT NULL
);
    DROP TABLE public.robot;
       public         heap    postgres    false            �            1259    16922    robot_id_especie_seq    SEQUENCE     �   CREATE SEQUENCE public.robot_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.robot_id_especie_seq;
       public          postgres    false    245                       0    0    robot_id_especie_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.robot_id_especie_seq OWNED BY public.robot.id_especie;
          public          postgres    false    246            �            1259    16923    sede_principal    TABLE     �   CREATE TABLE public.sede_principal (
    nombre_af character varying(255) NOT NULL,
    nombre_planeta character varying(255) NOT NULL
);
 "   DROP TABLE public.sede_principal;
       public         heap    postgres    false            �            1259    16928    serie    TABLE     �   CREATE TABLE public.serie (
    idmedio integer NOT NULL,
    nombre_creador character varying(255),
    apellido_creador character varying(255),
    total_episodio integer,
    canal character varying(255),
    tipo_serie public.medio_tipo_ps_dom
);
    DROP TABLE public.serie;
       public         heap    postgres    false    886            �            1259    16933    serie_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.serie_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.serie_idmedio_seq;
       public          postgres    false    248                       0    0    serie_idmedio_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.serie_idmedio_seq OWNED BY public.serie.idmedio;
          public          postgres    false    249            �            1259    16934    tripula    TABLE     �   CREATE TABLE public.tripula (
    id_nave integer NOT NULL,
    nombre_personaje character varying(255) NOT NULL,
    tipo_tripulacion public.tipo_tripulacion_dom
);
    DROP TABLE public.tripula;
       public         heap    postgres    false    898            �            1259    16939    tripula_id_nave_seq    SEQUENCE     �   CREATE SEQUENCE public.tripula_id_nave_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tripula_id_nave_seq;
       public          postgres    false    250                       0    0    tripula_id_nave_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tripula_id_nave_seq OWNED BY public.tripula.id_nave;
          public          postgres    false    251            �            1259    16940 
   videojuego    TABLE     �   CREATE TABLE public.videojuego (
    idmedio integer NOT NULL,
    tipo_juego character varying(255),
    "compañia" character varying(255)
);
    DROP TABLE public.videojuego;
       public         heap    postgres    false            �            1259    16945    videojuego_idmedio_seq    SEQUENCE     �   CREATE SEQUENCE public.videojuego_idmedio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.videojuego_idmedio_seq;
       public          postgres    false    252                       0    0    videojuego_idmedio_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.videojuego_idmedio_seq OWNED BY public.videojuego.idmedio;
          public          postgres    false    253            �           2604    16946    aparece idmedio    DEFAULT     r   ALTER TABLE ONLY public.aparece ALTER COLUMN idmedio SET DEFAULT nextval('public.aparece_idmedio_seq'::regclass);
 >   ALTER TABLE public.aparece ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    218    217            �           2604    16947    combate idmedio    DEFAULT     r   ALTER TABLE ONLY public.combate ALTER COLUMN idmedio SET DEFAULT nextval('public.combate_idmedio_seq'::regclass);
 >   ALTER TABLE public.combate ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    221    220            �           2604    16948    criatura id_especie    DEFAULT     z   ALTER TABLE ONLY public.criatura ALTER COLUMN id_especie SET DEFAULT nextval('public.criatura_id_especie_seq'::regclass);
 B   ALTER TABLE public.criatura ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    223    222            �           2604    16949    dueño id_nave    DEFAULT     t   ALTER TABLE ONLY public."dueño" ALTER COLUMN id_nave SET DEFAULT nextval('public."dueño_id_nave_seq"'::regclass);
 ?   ALTER TABLE public."dueño" ALTER COLUMN id_nave DROP DEFAULT;
       public          postgres    false    225    224            �           2604    16950    especie id_especie    DEFAULT     x   ALTER TABLE ONLY public.especie ALTER COLUMN id_especie SET DEFAULT nextval('public.especie_id_especie_seq'::regclass);
 A   ALTER TABLE public.especie ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    227    226            �           2604    16951    humano id_especie    DEFAULT     v   ALTER TABLE ONLY public.humano ALTER COLUMN id_especie SET DEFAULT nextval('public.humano_id_especie_seq'::regclass);
 @   ALTER TABLE public.humano ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    229    228            �           2604    16952    medio id    DEFAULT     d   ALTER TABLE ONLY public.medio ALTER COLUMN id SET DEFAULT nextval('public.medio_id_seq'::regclass);
 7   ALTER TABLE public.medio ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233            �           2604    16953    nave id_nave    DEFAULT     l   ALTER TABLE ONLY public.nave ALTER COLUMN id_nave SET DEFAULT nextval('public.nave_id_nave_seq'::regclass);
 ;   ALTER TABLE public.nave ALTER COLUMN id_nave DROP DEFAULT;
       public          postgres    false    236    235            �           2604    16954    pelicula idmedio    DEFAULT     t   ALTER TABLE ONLY public.pelicula ALTER COLUMN idmedio SET DEFAULT nextval('public.pelicula_idmedio_seq'::regclass);
 ?   ALTER TABLE public.pelicula ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    239    238            �           2604    16955    personaje id_especie    DEFAULT     |   ALTER TABLE ONLY public.personaje ALTER COLUMN id_especie SET DEFAULT nextval('public.personaje_id_especie_seq'::regclass);
 C   ALTER TABLE public.personaje ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    241    240            �           2604    16956    plataformas idmedio    DEFAULT     z   ALTER TABLE ONLY public.plataformas ALTER COLUMN idmedio SET DEFAULT nextval('public.plataformas_idmedio_seq'::regclass);
 B   ALTER TABLE public.plataformas ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    244    243            �           2604    16957    robot id_especie    DEFAULT     t   ALTER TABLE ONLY public.robot ALTER COLUMN id_especie SET DEFAULT nextval('public.robot_id_especie_seq'::regclass);
 ?   ALTER TABLE public.robot ALTER COLUMN id_especie DROP DEFAULT;
       public          postgres    false    246    245            �           2604    16958    serie idmedio    DEFAULT     n   ALTER TABLE ONLY public.serie ALTER COLUMN idmedio SET DEFAULT nextval('public.serie_idmedio_seq'::regclass);
 <   ALTER TABLE public.serie ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    249    248            �           2604    16959    tripula id_nave    DEFAULT     r   ALTER TABLE ONLY public.tripula ALTER COLUMN id_nave SET DEFAULT nextval('public.tripula_id_nave_seq'::regclass);
 >   ALTER TABLE public.tripula ALTER COLUMN id_nave DROP DEFAULT;
       public          postgres    false    251    250            �           2604    16960    videojuego idmedio    DEFAULT     x   ALTER TABLE ONLY public.videojuego ALTER COLUMN idmedio SET DEFAULT nextval('public.videojuego_idmedio_seq'::regclass);
 A   ALTER TABLE public.videojuego ALTER COLUMN idmedio DROP DEFAULT;
       public          postgres    false    253    252            �          0    16812    actor 
   TABLE DATA           k   COPY public.actor (nombre_actor, apellido_actor, fecha_nacimiento, nacionalidad, genero, tipo) FROM stdin;
    public          postgres    false    214   ��       �          0    16817 
   afiliacion 
   TABLE DATA           H   COPY public.afiliacion (nombre_af, tipo_af, nombre_planeta) FROM stdin;
    public          postgres    false    215   f�       �          0    16822    afiliado 
   TABLE DATA           I   COPY public.afiliado (nombre_af, fecha_af, nombre_personaje) FROM stdin;
    public          postgres    false    216   �       �          0    16827    aparece 
   TABLE DATA           <   COPY public.aparece (nombre_personaje, idmedio) FROM stdin;
    public          postgres    false    217   ��       �          0    16831    ciudad 
   TABLE DATA           ?   COPY public.ciudad (nombre_ciudad, nombre_planeta) FROM stdin;
    public          postgres    false    219   ]�       �          0    16836    combate 
   TABLE DATA           f   COPY public.combate (participante1, participante2, idmedio, fecha_combate, lugar_combate) FROM stdin;
    public          postgres    false    220   ��       �          0    16842    criatura 
   TABLE DATA           A   COPY public.criatura (color_piel, dieta, id_especie) FROM stdin;
    public          postgres    false    222   i�       �          0    16848    dueño 
   TABLE DATA           K   COPY public."dueño" (id_nave, nombre_personaje, fecha_compra) FROM stdin;
    public          postgres    false    224   ��       �          0    16852    especie 
   TABLE DATA           5   COPY public.especie (idioma, id_especie) FROM stdin;
    public          postgres    false    226   *�       �          0    16856    humano 
   TABLE DATA           L   COPY public.humano (fecha_nacimiento, fecha_muerte, id_especie) FROM stdin;
    public          postgres    false    228   c�       �          0    16861    idiomas 
   TABLE DATA           9   COPY public.idiomas (idioma, nombre_planeta) FROM stdin;
    public          postgres    false    230   ��       �          0    16866    interpretado 
   TABLE DATA           `   COPY public.interpretado (nombre_personaje, nombre_actor, apellido_actor, id_medio) FROM stdin;
    public          postgres    false    231   �       �          0    16871    lugares_interes 
   TABLE DATA           O   COPY public.lugares_interes (lugar, nombre_ciudad, nombre_planeta) FROM stdin;
    public          postgres    false    232   ��       �          0    16876    medio 
   TABLE DATA           L   COPY public.medio (id, titulo, fecha_estreno, rating, sinopsis) FROM stdin;
    public          postgres    false    233   /�       �          0    16883    nave 
   TABLE DATA           W   COPY public.nave (id_nave, nombre_nave, fabricante, longitud, uso, modelo) FROM stdin;
    public          postgres    false    235   �       �          0    16889    origen 
   TABLE DATA           B   COPY public.origen (nombre_personaje, nombre_planeta) FROM stdin;
    public          postgres    false    237   ~�       �          0    16894    pelicula 
   TABLE DATA           �   COPY public.pelicula (idmedio, duracion, distribuidor, coste_prod, tipo_pelicula, ingreso_taquilla, ganancia, nombre_director, apellido_director) FROM stdin;
    public          postgres    false    238   ��       �          0    16901 	   personaje 
   TABLE DATA           g   COPY public.personaje (nombre_personaje, nombre_planeta, genero, altura, peso, id_especie) FROM stdin;
    public          postgres    false    240   ��       �          0    16908    planeta 
   TABLE DATA           O   COPY public.planeta (nombre_planeta, sistema_solar, sector, clima) FROM stdin;
    public          postgres    false    242   ��       �          0    16913    plataformas 
   TABLE DATA           :   COPY public.plataformas (idmedio, plataforma) FROM stdin;
    public          postgres    false    243   �       �          0    16917    robot 
   TABLE DATA           ;   COPY public.robot (creador, clase, id_especie) FROM stdin;
    public          postgres    false    245   3�       �          0    16923    sede_principal 
   TABLE DATA           C   COPY public.sede_principal (nombre_af, nombre_planeta) FROM stdin;
    public          postgres    false    247   ��                  0    16928    serie 
   TABLE DATA           m   COPY public.serie (idmedio, nombre_creador, apellido_creador, total_episodio, canal, tipo_serie) FROM stdin;
    public          postgres    false    248   ��                 0    16934    tripula 
   TABLE DATA           N   COPY public.tripula (id_nave, nombre_personaje, tipo_tripulacion) FROM stdin;
    public          postgres    false    250   ��                 0    16940 
   videojuego 
   TABLE DATA           F   COPY public.videojuego (idmedio, tipo_juego, "compañia") FROM stdin;
    public          postgres    false    252   �                  0    0    aparece_idmedio_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.aparece_idmedio_seq', 1, false);
          public          postgres    false    218                       0    0    combate_idmedio_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.combate_idmedio_seq', 1, false);
          public          postgres    false    221                       0    0    criatura_id_especie_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.criatura_id_especie_seq', 5, true);
          public          postgres    false    223                       0    0    dueño_id_nave_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."dueño_id_nave_seq"', 1, false);
          public          postgres    false    225                       0    0    especie_id_especie_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.especie_id_especie_seq', 5, true);
          public          postgres    false    227                        0    0    humano_id_especie_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.humano_id_especie_seq', 3, true);
          public          postgres    false    229            !           0    0    medio_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.medio_id_seq', 13, true);
          public          postgres    false    234            "           0    0    nave_id_nave_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.nave_id_nave_seq', 5, true);
          public          postgres    false    236            #           0    0    pelicula_idmedio_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.pelicula_idmedio_seq', 1, false);
          public          postgres    false    239            $           0    0    personaje_id_especie_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.personaje_id_especie_seq', 1, false);
          public          postgres    false    241            %           0    0    plataformas_idmedio_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.plataformas_idmedio_seq', 1, false);
          public          postgres    false    244            &           0    0    robot_id_especie_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.robot_id_especie_seq', 8, true);
          public          postgres    false    246            '           0    0    serie_idmedio_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.serie_idmedio_seq', 1, false);
          public          postgres    false    249            (           0    0    tripula_id_nave_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tripula_id_nave_seq', 1, false);
          public          postgres    false    251            )           0    0    videojuego_idmedio_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.videojuego_idmedio_seq', 1, false);
          public          postgres    false    253                       2606    16962    actor actor_pk 
   CONSTRAINT     f   ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pk PRIMARY KEY (nombre_actor, apellido_actor);
 8   ALTER TABLE ONLY public.actor DROP CONSTRAINT actor_pk;
       public            postgres    false    214    214                       2606    16964    afiliacion afiliacion_pk 
   CONSTRAINT     ]   ALTER TABLE ONLY public.afiliacion
    ADD CONSTRAINT afiliacion_pk PRIMARY KEY (nombre_af);
 B   ALTER TABLE ONLY public.afiliacion DROP CONSTRAINT afiliacion_pk;
       public            postgres    false    215                       2606    16966    afiliado afiliado_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.afiliado
    ADD CONSTRAINT afiliado_pk PRIMARY KEY (nombre_af, fecha_af, nombre_personaje);
 >   ALTER TABLE ONLY public.afiliado DROP CONSTRAINT afiliado_pk;
       public            postgres    false    216    216    216                       2606    16968    aparece aparece_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.aparece
    ADD CONSTRAINT aparece_pk PRIMARY KEY (nombre_personaje, idmedio);
 <   ALTER TABLE ONLY public.aparece DROP CONSTRAINT aparece_pk;
       public            postgres    false    217    217            	           2606    16970    ciudad ciudad_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pk PRIMARY KEY (nombre_ciudad, nombre_planeta);
 :   ALTER TABLE ONLY public.ciudad DROP CONSTRAINT ciudad_pk;
       public            postgres    false    219    219                       2606    16972    combate combate_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_pk PRIMARY KEY (participante1, participante2, idmedio, fecha_combate);
 <   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_pk;
       public            postgres    false    220    220    220    220                       2606    16974    dueño dueño_pk 
   CONSTRAINT     w   ALTER TABLE ONLY public."dueño"
    ADD CONSTRAINT "dueño_pk" PRIMARY KEY (id_nave, nombre_personaje, fecha_compra);
 >   ALTER TABLE ONLY public."dueño" DROP CONSTRAINT "dueño_pk";
       public            postgres    false    224    224    224                       2606    16976    especie especie_pk 
   CONSTRAINT     X   ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pk PRIMARY KEY (id_especie);
 <   ALTER TABLE ONLY public.especie DROP CONSTRAINT especie_pk;
       public            postgres    false    226                       2606    16978    idiomas idiomas_pk 
   CONSTRAINT     d   ALTER TABLE ONLY public.idiomas
    ADD CONSTRAINT idiomas_pk PRIMARY KEY (idioma, nombre_planeta);
 <   ALTER TABLE ONLY public.idiomas DROP CONSTRAINT idiomas_pk;
       public            postgres    false    230    230                       2606    16980    interpretado interpretado_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_pk PRIMARY KEY (id_medio, nombre_personaje, nombre_actor, apellido_actor);
 F   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_pk;
       public            postgres    false    231    231    231    231                       2606    16982     lugares_interes lugar_interes_pk 
   CONSTRAINT     �   ALTER TABLE ONLY public.lugares_interes
    ADD CONSTRAINT lugar_interes_pk PRIMARY KEY (lugar, nombre_ciudad, nombre_planeta);
 J   ALTER TABLE ONLY public.lugares_interes DROP CONSTRAINT lugar_interes_pk;
       public            postgres    false    232    232    232                       2606    16984    medio medio_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.medio
    ADD CONSTRAINT medio_pk PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.medio DROP CONSTRAINT medio_pk;
       public            postgres    false    233                       2606    16986    medio medio_uq 
   CONSTRAINT     Z   ALTER TABLE ONLY public.medio
    ADD CONSTRAINT medio_uq UNIQUE (titulo, fecha_estreno);
 8   ALTER TABLE ONLY public.medio DROP CONSTRAINT medio_uq;
       public            postgres    false    233    233                       2606    16988    nave nave_pk 
   CONSTRAINT     O   ALTER TABLE ONLY public.nave
    ADD CONSTRAINT nave_pk PRIMARY KEY (id_nave);
 6   ALTER TABLE ONLY public.nave DROP CONSTRAINT nave_pk;
       public            postgres    false    235                       2606    16990    origen origen_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.origen
    ADD CONSTRAINT origen_pk PRIMARY KEY (nombre_personaje, nombre_planeta);
 :   ALTER TABLE ONLY public.origen DROP CONSTRAINT origen_pk;
       public            postgres    false    237    237                       2606    16992    pelicula pelicula_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_pk PRIMARY KEY (idmedio);
 >   ALTER TABLE ONLY public.pelicula DROP CONSTRAINT pelicula_pk;
       public            postgres    false    238            !           2606    16994    personaje personaje_pk 
   CONSTRAINT     b   ALTER TABLE ONLY public.personaje
    ADD CONSTRAINT personaje_pk PRIMARY KEY (nombre_personaje);
 @   ALTER TABLE ONLY public.personaje DROP CONSTRAINT personaje_pk;
       public            postgres    false    240            #           2606    16996    planeta planeta_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.planeta
    ADD CONSTRAINT planeta_pk PRIMARY KEY (nombre_planeta);
 <   ALTER TABLE ONLY public.planeta DROP CONSTRAINT planeta_pk;
       public            postgres    false    242            %           2606    16998    plataformas plataformas_pk 
   CONSTRAINT     i   ALTER TABLE ONLY public.plataformas
    ADD CONSTRAINT plataformas_pk PRIMARY KEY (plataforma, idmedio);
 D   ALTER TABLE ONLY public.plataformas DROP CONSTRAINT plataformas_pk;
       public            postgres    false    243    243            '           2606    17000     sede_principal sede_principal_pk 
   CONSTRAINT     u   ALTER TABLE ONLY public.sede_principal
    ADD CONSTRAINT sede_principal_pk PRIMARY KEY (nombre_af, nombre_planeta);
 J   ALTER TABLE ONLY public.sede_principal DROP CONSTRAINT sede_principal_pk;
       public            postgres    false    247    247            )           2606    17002    serie serie_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_pk PRIMARY KEY (idmedio);
 8   ALTER TABLE ONLY public.serie DROP CONSTRAINT serie_pk;
       public            postgres    false    248            +           2606    17004    tripula tripula_pk 
   CONSTRAINT     g   ALTER TABLE ONLY public.tripula
    ADD CONSTRAINT tripula_pk PRIMARY KEY (id_nave, nombre_personaje);
 <   ALTER TABLE ONLY public.tripula DROP CONSTRAINT tripula_pk;
       public            postgres    false    250    250            -           2606    17006    videojuego videojuego_pk 
   CONSTRAINT     [   ALTER TABLE ONLY public.videojuego
    ADD CONSTRAINT videojuego_pk PRIMARY KEY (idmedio);
 B   ALTER TABLE ONLY public.videojuego DROP CONSTRAINT videojuego_pk;
       public            postgres    false    252            O           2620    17007    pelicula calculo_ganancia_tr    TRIGGER     �   CREATE TRIGGER calculo_ganancia_tr BEFORE INSERT OR UPDATE ON public.pelicula FOR EACH ROW EXECUTE FUNCTION public.calculo_ganancia();
 5   DROP TRIGGER calculo_ganancia_tr ON public.pelicula;
       public          postgres    false    238    254            N           2620    17008    nave validar_modelo_nave_tr    TRIGGER     �   CREATE TRIGGER validar_modelo_nave_tr BEFORE INSERT OR UPDATE ON public.nave FOR EACH ROW EXECUTE FUNCTION public.validar_modelo_nave();
 4   DROP TRIGGER validar_modelo_nave_tr ON public.nave;
       public          postgres    false    235    255            /           2606    17009    afiliado afiliado_afiliacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.afiliado
    ADD CONSTRAINT afiliado_afiliacion_fk FOREIGN KEY (nombre_af) REFERENCES public.afiliacion(nombre_af) ON UPDATE CASCADE ON DELETE SET NULL (nombre_af);
 I   ALTER TABLE ONLY public.afiliado DROP CONSTRAINT afiliado_afiliacion_fk;
       public          postgres    false    216    3331    215            0           2606    17014    afiliado afiliado_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.afiliado
    ADD CONSTRAINT afiliado_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL (nombre_personaje);
 H   ALTER TABLE ONLY public.afiliado DROP CONSTRAINT afiliado_personaje_fk;
       public          postgres    false    3361    240    216            1           2606    17019    aparece aparece_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.aparece
    ADD CONSTRAINT aparece_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.aparece DROP CONSTRAINT aparece_medio_fk;
       public          postgres    false    3351    233    217            2           2606    17024    aparece aparece_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.aparece
    ADD CONSTRAINT aparece_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.aparece DROP CONSTRAINT aparece_personaje_fk;
       public          postgres    false    3361    217    240            3           2606    17029    ciudad ciudad_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.ciudad DROP CONSTRAINT ciudad_planeta_fk;
       public          postgres    false    3363    219    242            4           2606    17034    combate combate_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_medio_fk;
       public          postgres    false    233    220    3351            5           2606    17039     combate combate_participante2_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_participante2_fk FOREIGN KEY (participante2) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_participante2_fk;
       public          postgres    false    220    3361    240            6           2606    17044 !   combate combate_participantes1_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.combate
    ADD CONSTRAINT combate_participantes1_fk FOREIGN KEY (participante1) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 K   ALTER TABLE ONLY public.combate DROP CONSTRAINT combate_participantes1_fk;
       public          postgres    false    220    240    3361            7           2606    17049    criatura criatura_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.criatura
    ADD CONSTRAINT criatura_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 F   ALTER TABLE ONLY public.criatura DROP CONSTRAINT criatura_especie_fk;
       public          postgres    false    222    226    3343            8           2606    17054    dueño dueño_nave_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."dueño"
    ADD CONSTRAINT "dueño_nave_fk" FOREIGN KEY (id_nave) REFERENCES public.nave(id_nave) ON UPDATE CASCADE ON DELETE SET NULL;
 C   ALTER TABLE ONLY public."dueño" DROP CONSTRAINT "dueño_nave_fk";
       public          postgres    false    235    3355    224            9           2606    17059    dueño dueño_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public."dueño"
    ADD CONSTRAINT "dueño_personaje_fk" FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 H   ALTER TABLE ONLY public."dueño" DROP CONSTRAINT "dueño_personaje_fk";
       public          postgres    false    224    3361    240            :           2606    17064    humano humano_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.humano
    ADD CONSTRAINT humano_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 B   ALTER TABLE ONLY public.humano DROP CONSTRAINT humano_especie_fk;
       public          postgres    false    226    228    3343            ;           2606    17069    idiomas idiomas_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.idiomas
    ADD CONSTRAINT idiomas_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.idiomas DROP CONSTRAINT idiomas_planeta_fk;
       public          postgres    false    242    3363    230            <           2606    17074 "   interpretado interpretado_actor_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_actor_fk FOREIGN KEY (nombre_actor, apellido_actor) REFERENCES public.actor(nombre_actor, apellido_actor) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_actor_fk;
       public          postgres    false    214    231    231    3329    214            =           2606    17079 "   interpretado interpretado_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_medio_fk FOREIGN KEY (id_medio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 L   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_medio_fk;
       public          postgres    false    233    3351    231            >           2606    17084 &   interpretado interpretado_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.interpretado
    ADD CONSTRAINT interpretado_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 P   ALTER TABLE ONLY public.interpretado DROP CONSTRAINT interpretado_personaje_fk;
       public          postgres    false    231    240    3361            ?           2606    17089 '   lugares_interes lugar_interes_ciudad_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lugares_interes
    ADD CONSTRAINT lugar_interes_ciudad_fk FOREIGN KEY (nombre_ciudad, nombre_planeta) REFERENCES public.ciudad(nombre_ciudad, nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 Q   ALTER TABLE ONLY public.lugares_interes DROP CONSTRAINT lugar_interes_ciudad_fk;
       public          postgres    false    3337    219    219    232    232            @           2606    17094 (   lugares_interes lugar_interes_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.lugares_interes
    ADD CONSTRAINT lugar_interes_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.lugares_interes DROP CONSTRAINT lugar_interes_planeta_fk;
       public          postgres    false    242    232    3363            A           2606    17099    origen origen_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.origen
    ADD CONSTRAINT origen_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.origen DROP CONSTRAINT origen_personaje_fk;
       public          postgres    false    240    237    3361            B           2606    17104    origen origen_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.origen
    ADD CONSTRAINT origen_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY public.origen DROP CONSTRAINT origen_planeta_fk;
       public          postgres    false    237    242    3363            C           2606    17109    pelicula pelicula_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.pelicula
    ADD CONSTRAINT pelicula_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY public.pelicula DROP CONSTRAINT pelicula_medio_fk;
       public          postgres    false    238    233    3351            D           2606    17114    personaje personaje_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.personaje
    ADD CONSTRAINT personaje_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 H   ALTER TABLE ONLY public.personaje DROP CONSTRAINT personaje_especie_fk;
       public          postgres    false    3343    240    226            E           2606    17119    personaje personaje_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.personaje
    ADD CONSTRAINT personaje_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL (nombre_planeta);
 H   ALTER TABLE ONLY public.personaje DROP CONSTRAINT personaje_planeta_fk;
       public          postgres    false    242    240    3363            .           2606    17124     afiliacion planeta_afiliacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.afiliacion
    ADD CONSTRAINT planeta_afiliacion_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.afiliacion DROP CONSTRAINT planeta_afiliacion_fk;
       public          postgres    false    242    215    3363            F           2606    17129 %   plataformas plataformas_videojuego_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.plataformas
    ADD CONSTRAINT plataformas_videojuego_fk FOREIGN KEY (idmedio) REFERENCES public.videojuego(idmedio) ON UPDATE CASCADE ON DELETE SET NULL;
 O   ALTER TABLE ONLY public.plataformas DROP CONSTRAINT plataformas_videojuego_fk;
       public          postgres    false    3373    252    243            G           2606    17134    robot robot_especie_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.robot
    ADD CONSTRAINT robot_especie_fk FOREIGN KEY (id_especie) REFERENCES public.especie(id_especie) ON UPDATE CASCADE ON DELETE SET NULL (id_especie);
 @   ALTER TABLE ONLY public.robot DROP CONSTRAINT robot_especie_fk;
       public          postgres    false    3343    245    226            H           2606    17139 +   sede_principal sede_principal_afiliacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sede_principal
    ADD CONSTRAINT sede_principal_afiliacion_fk FOREIGN KEY (nombre_af) REFERENCES public.afiliacion(nombre_af) ON UPDATE CASCADE ON DELETE SET NULL;
 U   ALTER TABLE ONLY public.sede_principal DROP CONSTRAINT sede_principal_afiliacion_fk;
       public          postgres    false    215    247    3331            I           2606    17144 (   sede_principal sede_principal_planeta_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.sede_principal
    ADD CONSTRAINT sede_principal_planeta_fk FOREIGN KEY (nombre_planeta) REFERENCES public.planeta(nombre_planeta) ON UPDATE CASCADE ON DELETE SET NULL;
 R   ALTER TABLE ONLY public.sede_principal DROP CONSTRAINT sede_principal_planeta_fk;
       public          postgres    false    3363    242    247            J           2606    17149    serie serie_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.serie
    ADD CONSTRAINT serie_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 >   ALTER TABLE ONLY public.serie DROP CONSTRAINT serie_medio_fk;
       public          postgres    false    233    248    3351            K           2606    17154    tripula tripula_nave_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.tripula
    ADD CONSTRAINT tripula_nave_fk FOREIGN KEY (id_nave) REFERENCES public.nave(id_nave) ON UPDATE CASCADE ON DELETE SET NULL (id_nave);
 A   ALTER TABLE ONLY public.tripula DROP CONSTRAINT tripula_nave_fk;
       public          postgres    false    235    250    3355            L           2606    17159    tripula tripula_personaje_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.tripula
    ADD CONSTRAINT tripula_personaje_fk FOREIGN KEY (nombre_personaje) REFERENCES public.personaje(nombre_personaje) ON UPDATE CASCADE ON DELETE SET NULL (nombre_personaje);
 F   ALTER TABLE ONLY public.tripula DROP CONSTRAINT tripula_personaje_fk;
       public          postgres    false    250    3361    240            M           2606    17164    videojuego videojuego_medio_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.videojuego
    ADD CONSTRAINT videojuego_medio_fk FOREIGN KEY (idmedio) REFERENCES public.medio(id) ON UPDATE CASCADE ON DELETE SET NULL;
 H   ALTER TABLE ONLY public.videojuego DROP CONSTRAINT videojuego_medio_fk;
       public          postgres    false    252    3351    233            �   �   x�}��
�0��s�{�H۹�E7�` �7/�,n��SЧwŋ�)��O:�gh�h�T�)�%��0�އ���<�����/L��a��;�=�3Zj���/ZGDP�p"���D��Q��Vn:yw��q��[9Jٞ��/�j�H*�C�zG��W
U�{��i^%���CB�'�`T�      �   �   x�E�1
�@E�S�	��F-���� ��l�ݤȵ�ls1E�4�y�w�c���v�ʄ �K����_h:�7��P$�-¿�8iʒ�8��~~�Q\�Za��v)���O&O����u�4������,b�l�Z�"�5�?�      �   �   x�mα
�0��9�y�H*��Q**Z���B=H����!J����]G���A�V+�Q��ё����Q�n��l�.��G�H��a���������_k(PB/�����e������J�R�K�V�i�D!��
 ��W@      �   �   x�e�A
�0EיS��j��X��B��fJ����ܴ����?�W��6㇬� 8Q�;�R�krX{�c,X��I�b������G� �Ǌ]�e�7�����Ì���o?�D
G�������v3	�RI-�䤤J+��?�k��%�e5Qv���#Z	      �   Z   x�=�;
�0 �99EO�%� ����%j�К@?Co��{�7JI�!P5e��[9I+��p3_��a��R�v��eyC#m	f���> ��%!'      �   �   x�]��
�0E��W�T��b��҅-
�n���CB*�D��Ͳ��ݜ�E�t���eQ;Hx�c��*�M��uV֪�� �hdJ�#K`}Lv���i0j�a�_ת�S"�hT���jٳ�Q+��S�U��N���B������{8O      �   V   x�K-JI��H-J:��,�(�Ә�7�����<N�Ģ<��{Qf1�.T�(◚�**�?�1"�XU���zxsZb:X F��� �_$f      �   K   x�3��H�S����4�47�50�52�2��I�LT�/JO�KJXC%L9���RKJ@�`aC.#����qqq ���      �   )   x�s��K,��4�r�K��,��4�r/�KO��4����� ��	      �   I   x�=���0��]���,����>����Po�n2f|�&'A���
��㲖o�D��;_T663��I�      �   O   x��(-)I-N�L,��S��r-��	�%&��s���gg��rz%fg�r��g�(8e�%Ur:��''�p��qqq �Q      �   Y   x��)�NUή,O��N-��M,���H�����4��H�S����e��q��� %|R3����9�Ar��n��@�b���� ��J      �   �   x�M�A
�@ϻ����(�4G/�f�!�������L�KSM�@�(�g:��N<���C1�xeEo�G~=S�d���zZ~[d$1�0�z�=����3�fq�u�X$/�I�*Pj����N2rl+{1jl�iQ3�EF��BkGC��M��OlGQ      �   �  x�m��r�H���)�Vؘ�9�7�]���粗�Ԇ1�2#��o�c{�m����=.�\�3�_w�+K��3��^��*��ͣJ�'Kʶ�&�aŞ�%�l:MGgi~�L�����k[r u�ZN��VM��O�+CA=��_�Y�Q5�5U�P#$2�#��Q6�t��p����k��R:�x��J�E�<��y.�T 2m� ����Tk�GAݶKV��_�,�+y�(~E8�kk�����j���+-��Ӱ7���y�b�rCP��֝%�� �[��1#�'�Gh<����|i�օauE�Y�G���$��`��lE�yM6�G�,Ͳ4ˑm�|B��B�s���I�.ȗ�Fx�5�X� ���Rs2�M��:;�Z
S�18v������F-��(�APe�� ������Ah��v��JV�jWjg�6=�@��V����ɹ�5�@��,@���/���\�{ϫ���h�^�۲�� �M� ��,��
���q��7���ؕwU ��ѴkM����U���M���aw���4r�yOU�H�p8��W�F�.D�!{'��ODs߮D��y�� �\����2�1bY�ֻ��h
�ј���e8��Ȩ.�����+��]_&�h�I�\��d���Vw�{�m(;%-�!R�ʅ�58V���^���v�7�w���a�܎����4�.w�ܙ!�y�q���@�KKKm���+t�����+4�z�nI�#Irܓz$�;�'�"�A�%�R�d�=��р^퉮�8#b��+^|��q0FXeT�r� ���q�\@�VL�N��ֲ��q��!Z��Ŷ�tbwɉ^�xw��`����97�q��jJ�j��XG���B���đװ�� a��n~�3�(��VÌ[�=�N6_?��٠˭_O5x��1F	[�Y��[�K�� ��W3�>sT
Y4@}����
�8K�p`����h�U$�֡%oc����o����p��p0�xޚ'      �   R  x�m��N�0D�����8����RTH��J\�ɒZr��q@���@EAp�cig��X�S�f\KW�g>�|�h���c��vC�aF��E���H�������:�W�5��}�e��Ϲ��>���p�r��l���N��9b������4�w;�R�pg�e�L��l%����r8w�q�Ar�J4:KG1M����5�p��D��L���$Q�W��OW�����H�j�J�^�Ê6�����!c�e��,U��n�>pױ�C+���*�j�v'd���1Z���<�2��$��vK���D��N]�4y�%���	��&c���O�d:t�a��i�H2��S��G��      �   $   x�,��u��S�����t�/*-NN�+����� �U�      �   �   x�m�AK�0�ϓ_�?���M��UQwAo{	m0�v�I��o�E�9��0��Ɂq��6�5�a���7�\������N׽�BrIE������j�CG>�QP	x�dQ�ً�S��pɣp��Ӎ���]������0`�F1���m&��+E���\ԃ����a�u$<��4�&
�d%'̜��1��sb�h��J
{ь����!��/�u���J�lq�,�u=�"��}M7�!9]B~ ��rn      �   �   x�u��N�PE��W�h��L�B� R�h+'��)O�����),��s|m��ԑ9v�7��z8�(b��B?� � �vd���d��k�Gdت�@(�G6Gqwғs��9��`?~�l��#?�!�S5ޤE���Kc[Q�i�b�@�[�f���\I��8S���d�BGt�5>Ԁ���[3v���1�3��jvb�����/* +�k�z�+b�����ϭ�h�4��,�,W�<�U)l,���44��Y)b����<���kQ      �   /  x���MN�0���)|���Z�TP@��L��x��l9
�^��\W���j$��<ｙ���AN�=g9��5��|˲E(����b�w�_#�x]7JV�,+o��Ԣ��vc,r�$p�FȎ=��x��D��B10 Y���$t�o���Ao���|6j�v+�9Uv�L������PU�T݁a�ǭ������}�C�S����I���E�kgl��&f��pC��wN?
�x�}��]@`&w��@�m�Ȱ��%
��_z��O��f�Q��5���;�S�B��y���۶�z�����7�      �      x�3�p�2�6�I�\1z\\\ 7?�      �   f   x�s�K���Sή,O��N-�t)��LIU ���������|NC.��L���<�Լ��L���⒢������2�Aʂ�t]�p�:�����I���=... չ9�      �   E   x�JMJ�II-�L,��S��
(��M-JT�/JI��tO���/�,��JM��t�/*-NN�+����� �+          �   x�eαjQ���ܧ�����D,�.
����4�u���̽�!o��р���9%S,ip���$��1�2��YLC�b��ߌu�RB,
T��LG��OxW9ӞB��i`,�3�_o�Ѯ~��>eQld���?TI���,а��Q�q��O�Y�-�X�.�m6�����.�|K?         V   x�3��)�NUή,O��N-����/��2��H�S����t�/��s�$�d(�%� ���s�p��f&*��'�%����qqq y�         0   x�3�tLN�<�9O7�,5���(��5'5��(?/3Y�����+F��� 0��     