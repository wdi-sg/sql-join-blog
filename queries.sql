-- all the users that commented on a single post (ex. post id 1)
SELECT 
FROM comments C
JOIN users U ON C.author_id = U.id
GROUP BY 1 
HAVING COUNT(C.id) = 1
ORDER BY 1;

-- all the comments for post 39
SELECT *
FROM comments
WHERE post_id = 39;

-- all the users that commented on their own post
SELECT DISTINCT U.name || ' (' || U.id || ')' AS "user"
FROM comments C
JOIN posts P ON C.post_id = P.id
            AND C.author_id = P.author_id
JOIN users U ON C.author_id = U.id
ORDER BY 1;

-- all the posts that have more than one comment
SELECT P.title || ' (' || P.id || ')' AS "post"
FROM comments C
JOIN posts P ON C.post_id = P.id
GROUP BY 1
HAVING COUNT(C.id) > 1
ORDER BY 1;
-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )

CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT NOT NULL
);
INSERT INTO likes(post_id, user_id) VALUES (3, 13);

-- create a query to get all the likes a user has made
SELECT
    U.name || ' (' || U.id || ')' AS "user",
    P.title || ' (' || P.id || ')' AS "post"
FROM likes L
JOIN users U ON L.user_id = U.id
JOIN posts P ON L.post_id = P.id
ORDER BY 2;

-- create a query to get all users that like a post
SELECT DISTINCT
    U.name || ' (' || U.id || ')' AS "user"
FROM likes L
JOIN users U ON L.user_id = U.id
ORDER BY 1;

-- create a query to get all the posts a user has liked
SELECT DISTINCT
    P.title || ' (' || P.id || ')' AS "post"
FROM likes L
JOIN posts P ON L.post_id = P.id
ORDER BY 1;
