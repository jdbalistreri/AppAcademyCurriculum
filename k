SELECT
  users.*
FROM
  question_likes
JOIN
  users ON question_likes.liker_id = users.id
WHERE
  question_likes.question_id = 2









-- SELECT
--   questions.title, questions.body, questions.author_id
-- FROM
--   question_followers
-- JOIN
--   questions ON question_followers.question_id = questions.id
-- GROUP BY
--   question_id
-- ORDER BY
--   COUNT(*) DESC
-- LIMIT
--   2

-- HAVING
--   COUNT(*) = (
--     SELECT
--       MAX(follower_count) max
--     FROM
--       (SELECT
--         COUNT(*) follower_count
--       FROM
--         question_followers
--       GROUP BY
--         question_id))
