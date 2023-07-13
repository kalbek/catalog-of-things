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
