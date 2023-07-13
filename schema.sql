-- Create the musicalbum table
CREATE TABLE musicalbum (
  id INT GENERATED ALWAYS AS IDENTITY,
  publish_date DATE,
  archived BOOLEAN,
  on_spotify BOOLEAN,
  genre_id INT,
  PRIMARY KEY(id)
);

-- Create the labels table
CREATE TABLE genre (
  id INT GENERATED ALWAYS AS IDENTITY,
  name TEXT,
  publish_date DATE,
  PRIMARY KEY(id)
);

ALTER TABLE books
ADD CONSTRAINT fk_
FOREIGN KEY (genre_id)
REFERENCES genre(id);
