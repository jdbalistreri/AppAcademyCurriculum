SELECT
  CAST(num_likes AS FLOAT) / CAST(num_questions AS FLOAT) karma
FROM
  (SELECT
    COUNT(question_likes.id) num_likes,
    COUNT(DISTINCT questions.id) num_questions,
    users.id user_id
  FROM
    users
  LEFT OUTER JOIN
    questions ON questions.author_id = users.id
  LEFT OUTER JOIN
    question_likes ON question_likes.question_id = questions.id
  GROUP BY
    users.id)
WHERE
  user_id = 1


  CAST(num_likes AS FLOAT) / CAST(COUNT(DISTINCT questions.id) AS FLOAT) karma

    -- SELECT
    --   CAST((SELECT
    --     COUNT(*)
    --   FROM
    --     users
    --   JOIN
    --     questions ON questions.author_id = users.id
    --   JOIN
    --     question_likes ON question_likes.question_id = questions.id
    --   WHERE
    --     users.id = 1
    --   GROUP BY
    --     users.id) AS FLOAT) /
    --   CAST((SELECT
    --     COUNT(*)
    --   FROM
    --     users
    --   JOIN
    --     questions ON questions.author_id = users.id
    --   WHERE
    --     users.id = 1
    --   GROUP BY
    --     users.id) AS FLOAT);





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
