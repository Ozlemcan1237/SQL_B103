create table customer
(
id integer NOT NULL,
	name text COLLATE pg_catalog."default" NOT NULL,
	age integer NOT NULL,
	salary real not null
);

create table "orders"
(
order_id integer NOT NULL,
	date date NOT NULL,
	cust_id integer NOT NULL,
	amount real NOT NULL,
	CONSTRAINT "order_pkey" PRIMARY KEY("order_id")
);