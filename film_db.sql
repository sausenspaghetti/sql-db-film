DROP TABLE IF EXISTS Film CASCADE;
DROP TABLE IF EXISTS TopCast CASCADE;
DROP TABLE IF EXISTS FilmCrew CASCADE;
DROP TABLE IF EXISTS Dubbing CASCADE;
DROP TABLE IF EXISTS FilmGenre CASCADE;
DROP TABLE IF EXISTS Person CASCADE;
DROP TABLE IF EXISTS Viewer CASCADE;
DROP TABLE IF EXISTS Country CASCADE;
DROP TABLE IF EXISTS Genre CASCADE;


CREATE TABLE Person (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	surname TEXT,
	birthdate DATE,
	carier TEXT
);

CREATE TABLE Country (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE
);

CREATE TABLE Viewer (
	film_id INT, -- FK
	country_id INT REFERENCES Country(id),
	amount INT,
	
	CHECK(amount >= 0),
	UNIQUE(film_id, country_id)
);

CREATE TABLE Genre (
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE
);

-- Фильмы по жанрам
CREATE TABLE FilmGenre (
	film_id INT, -- FK
	genre_id INT REFERENCES Genre(id),
	UNIQUE(film_id, genre_id)
);

-- Актеры в главных ролях
CREATE TABLE TopCast (
	film_id INT, -- FK
	actor_id INT REFERENCES Person(id),
	UNIQUE(film_id, actor_id)
);

-- роли дублировали
CREATE TABLE Dubbing (
	film_id INT, -- FK
	dubber_id INT REFERENCES Person(id),
	UNIQUE(film_id, dubber_id)
);

-- Съемочная группа
CREATE TABLE FilmCrew (
	film_id INT 		PRIMARY KEY, -- FK
	director_id INT	 	REFERENCES Person(id),
	producer_id INT 	REFERENCES Person(id),
	screenwriter_id INT REFERENCES Person(id),
	operator_id INT	 	REFERENCES Person(id),
	composer_id INT 	REFERENCES Person(id),
	editor_id INT 		REFERENCES Person(id),
	painter_id INT 		REFERENCES Person(id)
);


CREATE TABLE Film (
	-- general info
	id SERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	tagline TEXT, -- слоган
	description TEXT,
	
	-- productions and release
	country_prod_id INT REFERENCES Country(id), 
	prod_year INT,
	budget INT,
	marketing INT,
	
	fees INT,
	fees_world INT,
	
	premiere DATE,
	premiere_world DATE,
	release_dvd DATE,
	release_bluray DATE,
	release_digit DATE, -- цифровой релиз

	duration INT,
	age INT,
	rating INT,

	-- constraints
	CHECK(budget >= 0
		  AND marketing >= 0
		  AND duration > 0
		  AND prod_year > 0 
		 ) 
);





ALTER TABLE Viewer
	ADD CONSTRAINT film_id_link FOREIGN KEY(film_id) REFERENCES Film(id);
ALTER TABLE FilmGenre
	ADD CONSTRAINT film_id_link FOREIGN KEY(film_id) REFERENCES Film(id);
ALTER TABLE TopCast
	ADD CONSTRAINT film_id_link FOREIGN KEY(film_id) REFERENCES Film(id);
ALTER TABLE Dubbing
	ADD CONSTRAINT film_id_link FOREIGN KEY(film_id) REFERENCES Film(id);
ALTER TABLE FilmCrew
	ADD CONSTRAINT film_id_link FOREIGN KEY(film_id) REFERENCES Film(id);