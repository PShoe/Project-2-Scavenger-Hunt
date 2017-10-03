CREATE DATABASE treasurehunt


CREATE TABLE players (
  ID SERIAL4 PRIMARY KEY,
  NAME varchar(200),
  EMAIL varchar(400),
  POINTS integer,
  password_digest VARCHAR(400)
);

CREATE TABLE teams (
  ID SERIAL4 PRIMARY KEY,
  NAME varchar(255),
  TOTAL_POINTS integer,
  player_id INTEGER NOT NULL,
  FOREIGN KEY (player_id) REFERENCES players (id),
);

CREATE TABLE treasures (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(200),
  description varchar(400),
  image_url VARCHAR(400),
  location varchar(400),
  point_value integer,
  found boolean
);

CREATE TABLE player_treasures_teams (
  play_tre_tm_id SERIAL4 PRIMARY KEY,
  treasure_id INTEGER NOT NULL,
  FOREIGN KEY (treasure_id)  REFERENCES treasures (id),
  player_id INTEGER NOT NULL,
  FOREIGN KEY (player_id) REFERENCES players (id),
  team_id INTEGER NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams (id)
);
