CREATE DATABASE IF NOT EXISTS crocosoft_social;

-- Create a user with necessary permissions
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON crocosoft_social.* TO '${MYSQL_USER}'@'%';

USE crocosoft_social;


CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(250),
    birthdate DATE,
    password VARCHAR(250),
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE posts (
    id INT NOT NULL AUTO_INCREMENT,
    author_id INT NOT NULL,
    content VARCHAR(5000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_post_author_id FOREIGN KEY (author_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE comments (
    id INT NOT NULL AUTO_INCREMENT,
    author_id INT NOT NULL,
    post_id INT NOT NULL,
    content VARCHAR(5000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_comment_author_id FOREIGN KEY (author_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_commented_post_id FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
);

CREATE TABLE likes (
    reactor_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_reactor_id FOREIGN KEY (reactor_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_liked_post_id FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
);

CREATE TABLE shares (
    sharer_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sharer_id FOREIGN KEY (sharer_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_shared_post_id FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
);

CREATE TABLE friendships (
    person_1 INT NOT NULL,
    person_2 INT NOT NULL,
    CONSTRAINT fk_person_1_id FOREIGN KEY (person_1)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_person_2_id FOREIGN KEY (person_2)
        REFERENCES users(id)
        ON DELETE CASCADE
);


-- Data seeding
INSERT INTO users (first_name, last_name, email, birthdate, password)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1990-05-15', 'password123'),
    ('Jane', 'Smith', 'jane.smith@example.com', '1992-08-20', 'securepwd'),
    ('Michael', 'Johnson', 'michael.johnson@example.com', '1985-12-10', 'strongpass'),
    ('Emily', 'Brown', 'emily.brown@example.com', '1994-03-25', 'pass123word'),
    ('David', 'Williams', 'david.williams@example.com', '1988-06-08', 'safePassword');

INSERT INTO posts (author_id, content)
VALUES
    (1, 'This is the first post by John Doe.'),
    (2, 'Jane Smith shares her thoughts.'),
    (3, 'Michael Johnson updates on his project.'),
    (4, 'Emily Brown posts a photo.'),
    (5, 'David Williams shares an article.');

INSERT INTO comments (author_id, post_id, content)
VALUES
    (2, 1, 'Interesting!'),
    (3, 1, 'Great post.'),
    (4, 3, 'Looking forward to it.'),
    (5, 2, 'Nice thoughts.'),
    (1, 4, 'Beautiful photo!');

INSERT INTO likes (reactor_id, post_id)
VALUES
    (3, 1),
    (5, 1),
    (2, 3),
    (4, 2),
    (1, 5);

INSERT INTO shares (sharer_id, post_id)
VALUES
    (4, 1),
    (1, 2),
    (5, 3),
    (2, 4),
    (3, 5);

INSERT INTO friendships (person_1, person_2)
VALUES
    (1, 2),
    (3, 4),
    (5, 1),
    (2, 3),
    (4, 5);
