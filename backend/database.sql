CREATE TABLE user (
  id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  hashedPassword VARCHAR(255) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO
user (firstname, lastname, email,
hashedPassword)
VALUES
('Arthur',
'Dent',
'arthur@gmail.com',
'$argon2d$v=19$m=12,t=3,p=1$ejBtbmxxZmkxbWswMDAwMA$sBTSUhRTTx8WKm3ZNbHsXA'),
('Jim',
'Hopper',
'jim@gmail.com',
'$argon2d$v=19$m=12,t=3,p=1$ejBtbmxxZmkxbWswMDAwMA$sBTSUhRTTx8WKm3ZNbHsXA'),
('Sheldon',
'Cooper',
'sheldon@gmail.com',
'$argon2d$v=19$m=12,t=3,p=1$ejBtbmxxZmkxbWswMDAwMA$sBTSUhRTTx8WKm3ZNbHsXA');

CREATE TABLE types (
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  tag VARCHAR(50)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO 
types (tag)
VALUES ('Autres'),('Epinglées');



CREATE TABLE categories (
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  list VARCHAR(50) NOT NULL,
  user_id INT,
  CONSTRAINT fk_categories_user
  FOREIGN KEY (user_id)
  REFERENCES user(id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO
categories (list)
VALUES 
('Organisation'), ('Personnel');

CREATE TABLE color (
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  color VARCHAR(20)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO
color (color)
VALUES ('#EEEAEA'), ('#B171A3'), ('#EF8CC8'), ('#FOB7E4');

CREATE TABLE note (
  id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  user_id INT,
  CONSTRAINT fk_note_user
  FOREIGN KEY (user_id)
  REFERENCES user(id),
  color_id INT,
  CONSTRAINT fk_note_color
  FOREIGN KEY (color_id)
  REFERENCES color(id),
  types_id INT,
  CONSTRAINT fk_note_types
  FOREIGN KEY (types_id)
  REFERENCES types(id),
  categories_id INT,
  CONSTRAINT fk_note_categories
  FOREIGN KEY (categories_id)
  REFERENCES categories(id)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO
note (title, content, user_id, color_id, types_id, categories_id)
VALUES
('Tiramisu au speculoos', 'Ingrédients : 250g de mascarpone, 100g de sucre, 2 oeufs, 1 paquet de speculoos, café. Mélanger le mascarpone avec les jaunes et le sucre, monter les blancs en neige et les incorporer délicatement au mélange mascarpone, sucre, jaune. Tremper les speculoos dans le café et disposer la moitié sur une première couche dans un plat, puis répéter les étapes une seconde fois. Saupoudrez de chocolat Van Houten et réserver au réfrigérateur pendant 3h minimum.', '1', '2', '1', '2');

