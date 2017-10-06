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
VALUES ('UX','http://www.88graphics.com/img/graphic-design-icon.png'), ('Data Science', 'https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Analytics-512.png'), ('WDI','http://www.freeiconspng.com/uploads/responsive-icon-23.png');

INSERT INTO treasures (name, description, image_url, site_url, point_value) VALUES ('Wind your way through the Nicholas Building','This Art Deco icon is a creative hive that was built in the ’20s. Exploring its ten storeys is an unparalleled shopping adventure: you’ll find boutique retailers, jewellers, art studios and bespoke tailors.','https://media.timeout.com/images/103026198/710/399/image.jpg','https://www.timeout.com/melbourne/museums/the-nicholas-building', 6);

INSERT INTO treasures (name, description, image_url, site_url, point_value) VALUES ('Pay how you feel at Lentil as Anything','Once known as the Convent of the Good Shepherd, the Convent provided refuge for vulnerable women, children and orphans. Nowadays, the convent building and formal gardens play host to events and festivals, workshops and classes, music and theatre performances, and in summer, outdoor cinema.','https://media.timeout.com/images/103026087/710/399/image.jpg','https://www.timeout.com/melbourne/museums/the-abbotsford-convent', 6);

INSERT INTO treasures (name, description, image_url, site_url, point_value) VALUES ('Explore the Melbourne Zoo','Watch the world flutter by at the butterfly room, visit the colourful residents of the aviary and trek through the Trail of the Elephants to visit the close-knit family of big-eared beauties. ','https://media.timeout.com/images/103564292/710/399/image.jpg', 'https://www.timeout.com/melbourne/museums/melbourne-zoo', 5);

INSERT INTO treasures (name, description, image_url,site_url,  point_value) VALUES ('Play pool at Red Triangle while drinking a milkshake','The trek up the many rickety, wooden flights of stairs is entirely worth it for the time capsule pool hall at the top. Book one of the full-sized snooker or pool tables for a piddling eight bucks during the day or $16 at night and while away a few hours with your mates.','https://media.timeout.com/images/103026835/710/399/image.jpg', 'https://www.timeout.com/melbourne/bars/red-triangle-snooker-room', 10);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('Wile away an entire day at the Australian Centre for the Moving Image (ACMI)','ACMI is many things: a cinema, an exhibition space, a boutique shop and a museum. You can literally spend all day here – especially when theres a blockbuster exhibition on (the most recent was Scorsese).','https://media.timeout.com/images/103623549/710/399/image.jpg','https://www.timeout.com/melbourne/museums/acmi-australian-centre-for-the-moving-image', 5);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('Take a dip in the Yarra at Pound Bend','At the bottom of a suburban street in leafy Warrandyte, you’ll find one of the most pristine swimming spots in Melbourne. Here, the Yarra yawns out to a wide, calm pool, flanked by untamed bush and riverbanks large enough to set up camp for the day.','http://1.bp.blogspot.com/-9tCr97vxD-o/WdE47-WCcpI/AAAAAAAActE/dPsKDjZ-j1IeiGJ_jzQv5ddLz7lepRibACK4BGAYYCw/s928/Pelican%2BLake%2BSep%2B25%2B2017%2B004.JPG', 'https://www.timeout.com/melbourne/things-to-do/pound-bend-warrandyte-national-park', 15);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('Explore the hidden rooms of the State Library of Victoria','The State Library of Victoria is full of little surprises. Settle in with a good book in the many cosy nooks, or work on your chess technique at the Chess Reading Room','https://media.timeout.com/images/103025752/710/399/image.jpg','https://www.timeout.com/melbourne/museums/state-library-of-victoria', 15);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('Go for a soak at the Japanese bath house','Theres nothing quite like a bath for a spot of relaxation – except for a giant one. Owned by Jerome Borazios sister (he of St Jeromes Laneway Festival, 1000 Pound Bend and umpteen dozen other awesome ventures around town) – this is a haven in the very heart of the city: a quiet place to relax, unwind and soak away cares and rough elbows.’ classic 1980 movie.','https://media.timeout.com/images/103029086/750/422/image.jpg','https://www.timeout.com/melbourne/health-and-beauty/onsen-ma-japanese-bathhouse', 15);

INSERT INTO treasures (name, description, image_url,site_url, point_value) VALUES ('
Buy local produce from Michael Caiafa at the Queen Victoria Market','Next time you’re stocking up on your groceries at the Queen Vic Market (which opened in 1878), make sure you visit Michael Caiafa. His is the corner stall in the deli section packed with freshly baked bread from artisanal bakeries, chocolate you’d be hard-pressed to find in a supermarket, and of course, his famous house-made peanut butter.','https://media.timeout.com/images/103035401/750/422/image.jpg','https://www.timeout.com/melbourne/shopping/queen-victoria-market', 15);

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
