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
 