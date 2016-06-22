DROP TABLE sales;
DROP TABLE pets;
DROP TABLE pet_shops;
DROP TABLE customers;

CREATE TABLE pet_shops (
id serial4 primary key,
name VARCHAR(255) not null,
type VARCHAR(255) not null,
address VARCHAR(255) not null
);

CREATE TABLE pets (
  id SERIAL4 primary key,
  name VARCHAR(255) not null,
  type VARCHAR(255) not null,
  species VARCHAR(255) not null,
  price INT4 not null,
  sold BOOLEAN not null,
  pet_shop_id SERIAL4 references pet_shops(id) not null
);

CREATE TABLE customers (
  id SERIAL4 primary key,
  name VARCHAR(255) not null,
  address VARCHAR(255) not null,
  tel INT8 not null
);

CREATE TABLE sales (
  id SERIAL4 primary key,
  customer_id INT4 references customers(id) not null,
  pet_id INT4 references pets(id) not null
);

