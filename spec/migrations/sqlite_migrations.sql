BEGIN;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS users_different_defaults;
DROP TABLE IF EXISTS users_large_defaults;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS addresses;

CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(255) NOT NULL,
  things integer,
  stuff integer,
  nope float,
  yep bool,
  pageviews bigint,
  some_date DATETIME,
  created_at DATETIME,  
  updated_at DATETIME
);

CREATE UNIQUE INDEX users_4ijlkjdf ON users (id);

CREATE TABLE users_different_defaults(
  user_id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(255) NOT NULL,
  xyz DATETIME
);

CREATE UNIQUE INDEX users_different_defaults_kljl3kj on users_different_defaults (user_id);

CREATE TABLE users_large_defaults(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name varchar(255) NOT NULL
);

CREATE UNIQUE INDEX users_4asdf ON users_large_defaults (id);

CREATE TABLE posts(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER references users(id),
  created_at DATETIME,
  updated_at DATETIME
);

CREATE UNIQUE INDEX posts_df8sdd ON posts (id);

CREATE TABLE addresses(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER references users(id),
  created_at DATETIME,
  updated_at DATETIME
);

CREATE UNIQUE INDEX addresses_dfd7fs7ss ON addresses (id);

COMMIT;
