-- Create books table
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  publisher TEXT,
  cover_state TEXT,
  publish_date DATE,
  label_id INT,
  archived BOOLEAN
);

-- Create the labels table
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  title TEXT,
  color TEXT
);

ALTER TABLE books
ADD CONSTRAINT fk_label
FOREIGN KEY (label_id)
REFERENCES labels(id);
 
CREATE TABLE musicalbum (
  id INT GENERATED ALWAYS AS IDENTITY,
  publish_date DATE,
  archived BOOLEAN,
  on_spotify BOOLEAN,
  genre_id INT,
  PRIMARY KEY(id)
);

CREATE TABLE genre (
  id INT GENERATED ALWAYS AS IDENTITY,
  name TEXT,
  publish_date DATE,
  PRIMARY KEY(id)
);
 
 -- Schema for games table
CREATE TABLE games (
  id INT PRIMARY KEY,
  multiplayer BOOLEAN,
  last_played_at DATE,
  publish_date DATE,
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- Schema for authors table
CREATE TABLE authors (
  id INT PRIMARY KEY,
  firstname VARCHAR(255),
  lastname VARCHAR(255)
);
