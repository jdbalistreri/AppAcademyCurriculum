
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);


CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL
);

CREATE TABLE question_followers(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL
);

CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Joe', 'Balistreri'),
  ('Jun', 'Chen'),
  ('Jon', 'Tamboer'),
  ('Andrew', 'Gremmo'),
  ('Karthik', 'Var'),
  ('Constance', 'Jiang');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('Intro', 'Where is App Academy located?', 1),
  ('Day1', 'Where can we find day 1 exercises?', 2),
  ('Jobs', 'Will we really get jobs?', 4);

INSERT INTO
  question_followers(question_id, follower_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (1, 4),
  (2, 1),
  (2, 3),
  (2, 6),
  (3, 5);

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (1, NULL, 1, 'NYC'),
  (1, 1, 2, '598 Broadway'),
  (2, NULL, 2, 'on the website...'),
  (2, 3, 2, 'appacademy.io'),
  (3, NULL, 4, 'Maybe'),
  (3, NULL, 4, 'YEP');

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (2, 3),
  (1, 2),
  (6, 2),
  (5, 3),
  (4, 1),
  (3, 1),
  (2, 2);
