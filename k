SELECT
  question_id, COUNT(*)
FROM
  question_followers
GROUP BY
  question_id;


SELECT
  question_id, MAX(*)
FROM
  question_followers
GROUP BY
  question_id;
