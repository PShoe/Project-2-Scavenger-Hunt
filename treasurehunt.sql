DROP TABLE IF EXISTS players_treasures_teams;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS treasures;

CREATE TABLE teams (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  total_points INTEGER
);

CREATE TABLE players (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(200),
  email VARCHAR(400),
  points INTEGER,
  password_digest VARCHAR(400),
  team_id INTEGER NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams (id)
);

INSERT INTO teams (name, total_points)
VALUES ('Red', 0), ('Blue', 0), ('Green', 0);

CREATE TABLE treasures (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(200),
  description VARCHAR(400),
  image_url VARCHAR(400),
  point_value INTEGER,
  found BOOLEAN
);

INSERT INTO treasures (name, description, image_url, point_value, found) VALUES ('zoo','something about the zoo','http://cd.visitmelbourne.com/-/media/atdw/melbourne/things-to-do/nature-and-wildlife/wildlife-and-zoos/93b35a894f2aa23977a097f40badebee_1600x900.jpeg?ts=20170113330943&w=1200', 10, false);

INSERT INTO treasures (name, description, image_url, point_value, found) VALUES ('St. Kilda','something about the St. Kilda','https://media.timeout.com/images/103025847/710/399/image.jpg', 5, false);

CREATE TABLE players_treasures_teams (
  play_tre_tm_id SERIAL4 PRIMARY KEY,
  treasure_id INTEGER NOT NULL,
  FOREIGN KEY (treasure_id)  REFERENCES treasures (id),
  player_id INTEGER NOT NULL,
  FOREIGN KEY (player_id) REFERENCES players (id),
  team_id INTEGER NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams (id)
);
