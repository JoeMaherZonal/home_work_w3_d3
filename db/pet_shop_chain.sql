DROP TABLE pets;
DROP TABLE pet_shops;

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
  pet_shop_id SERIAL4 references pet_shops(id) not null
);
