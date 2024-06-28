CREATE DATABASE IF NOT EXISTS crocosoft_social;

USE crocosoft_social;


CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(250),
    birthdate DATE,
    password VARCHAR(250),
    PRIMARY KEY (id)
);

CREATE TABLE posts (
    id INT NOT NULL AUTO_INCREMENT,
    author_id INT NOT NULL,
    content VARCHAR(5000),
    PRIMARY KEY (id),
    CONSTRAINT fk_post_author_id FOREIGN KEY (author_id)
        REFERENCES users(id)
);

CREATE TABLE comments (
    id INT NOT NULL AUTO_INCREMENT,
    author_id INT NOT NULL,
    post_id INT NOT NULL,
    content VARCHAR(5000),
    PRIMARY KEY (id),
    CONSTRAINT fk_comment_author_id FOREIGN KEY (author_id)
        REFERENCES users(id),
    CONSTRAINT fk_commented_post_id FOREIGN KEY (post_id)
        REFERENCES posts(id)
);

CREATE TABLE likes (
    reactor_id INT NOT NULL,
    post_id INT NOT NULL,
    CONSTRAINT fk_reactor_id FOREIGN KEY (reactor_id)
        REFERENCES users(id),
    CONSTRAINT fk_liked_post_id FOREIGN KEY (post_id)
        REFERENCES posts(id)
);

CREATE TABLE shares (
    sharer_id INT NOT NULL,
    post_id INT NOT NULL,
    CONSTRAINT fk_sharer_id FOREIGN KEY (sharer_id)
        REFERENCES users(id),
    CONSTRAINT fk_shared_post_id FOREIGN KEY (post_id)
        REFERENCES posts(id)
);

CREATE TABLE friendships (
    person_1 INT NOT NULL,
    person_2 INT NOT NULL,
    CONSTRAINT fk_person_1_id FOREIGN KEY (person_1)
        REFERENCES users(id),
    CONSTRAINT fk_person_2_id FOREIGN KEY (person_2)
        REFERENCES users(id)
);
