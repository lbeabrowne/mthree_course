CREATE database MovieCatalogue;

USE MovieCatalogue;

DROP TABLE IF EXISTS genre;

CREATE TABLE genre (
genre_ID char(20) NOT NULL PRIMARY KEY,
genre_name varchar(30) NOT NULL
);

DROP TABLE IF EXISTS director;

CREATE TABLE director (
director_ID char(20) NOT NULL PRIMARY KEY,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
birth_date date default NULL
);

DROP TABLE IF EXISTS rating;

CREATE TABLE rating (
rating_ID char(20) NOT NULL PRIMARY KEY,
rating_name varchar(5) NOT NULL
);

DROP TABLE IF EXISTS movie;

CREATE TABLE movie (
movie_ID char(20) NOT NULL PRIMARY KEY,
genre_ID char(20) NOT NULL,
director_ID char(20) default NULL,
rating_ID char(20) default NULL,
title varchar(128) NOT NULL,
release_date date default NULL,
FOREIGN KEY fk_movie_genre (genre_ID)
	REFERENCES genre(genre_ID),
FOREIGN KEY fk_movie_director (director_ID)
	REFERENCES director(director_ID),
FOREIGN KEY fk_movie_rating (rating_ID)
	REFERENCES rating(rating_ID)
);

DROP TABLE IF EXISTS actor;

CREATE TABLE actor (
actor_ID char(20) NOT NULL PRIMARY KEY,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
birth_date date default NULL
);

DROP TABLE IF EXISTS cast_members;

CREATE TABLE cast_members (
cast_members_ID char(20) NOT NULL PRIMARY KEY,
actor_ID varchar(30) NOT NULL,
movie_ID varchar(30) NOT NULL,
member_role varchar(50) NOT NULL,
FOREIGN KEY fk_cast_members_actor (actor_ID)
	REFERENCES actor(actor_ID),
FOREIGN KEY fk_cast_members_movie (movie_ID)
	REFERENCES movie(movie_ID)
);
