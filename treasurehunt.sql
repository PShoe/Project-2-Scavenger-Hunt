DROP TABLE IF EXISTS players_treasures_teams;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS treasures;

CREATE TABLE teams (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  image_url VARCHAR(400)
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

CREATE TABLE treasures (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(200),
  description VARCHAR(400),
  image_url VARCHAR(400),
  site_url VARCHAR(400),
  point_value INTEGER
);

INSERT INTO teams (name, image_url)
VALUES ('UX','https://cdn-images-1.medium.com/max/184/1*4igu0GOdXEqBvJfUJhHfyw@2x.png'), ('Data Science', 'https://http2.mlstatic.com/S_291825-MCO25493110355_042017-O.jpg'), ('WDI','http://www.freeiconspng.com/uploads/responsive-icon-23.png');

INSERT INTO treasures (name, description, image_url, site_url, point_value) VALUES ('zoo','something about the zoo','http://cd.visitmelbourne.com/-/media/atdw/melbourne/things-to-do/nature-and-wildlife/wildlife-and-zoos/93b35a894f2aa23977a097f40badebee_1600x900.jpeg?ts=20170113330943&w=1200','https://www.timeout.com/melbourne/museums/melbourne-zoo', 10);

INSERT INTO treasures (name, description, image_url, site_url, point_value) VALUES ('St. Kilda','something about the St. Kilda','https://media.timeout.com/images/103025847/710/399/image.jpg','https://www.timeout.com/melbourne/museums/melbourne-zoo', 5);

INSERT INTO treasures (name, description, image_url, site_url, point_value) VALUES ('Circus Oz','See a show by Circus Oz','https://media.timeout.com/images/103380868/710/399/image.jpg', 'https://www.timeout.com/melbourne/museums/melbourne-zoo', 5);

INSERT INTO treasures (name, description, image_url,site_url,  point_value) VALUES ('zoo2','something about the zoo','http://cd.visitmelbourne.com/-/media/atdw/melbourne/things-to-do/nature-and-wildlife/wildlife-and-zoos/93b35a894f2aa23977a097f40badebee_1600x900.jpeg?ts=20170113330943&w=1200', 'https://www.timeout.com/melbourne/museums/melbourne-zoo', 10);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('St. Kilda2','something about the St. Kilda','https://media.timeout.com/images/103025847/710/399/image.jpg','https://www.timeout.com/melbourne/museums/melbourne-zoo', 5);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('Circus Oz2','See a show by Circus Oz','https://media.timeout.com/images/103380868/710/399/image.jpg','https://www.timeout.com/melbourne/museums/melbourne-zoo', 5);


CREATE TABLE players_treasures_teams (
  play_tre_tm_id SERIAL4 PRIMARY KEY,
  treasure_id INTEGER NOT NULL,
  FOREIGN KEY (treasure_id)  REFERENCES treasures (id),
  player_id INTEGER NOT NULL,
  FOREIGN KEY (player_id) REFERENCES players (id),
  team_id INTEGER NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams (id)
);

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  body VARCHAR(400) NOT NULL,
  treasure_id INTEGER NOT NULL,
  FOREIGN KEY (treasure_id)  REFERENCES treasures (id),
  player_id INTEGER NOT NULL,
  FOREIGN KEY (player_id) REFERENCES players (id),
  team_id INTEGER NOT NULL
);
