-- all the users that commented on ia single post (ex. post id 1)
SELECT users.name
FROM users
INNER JOIN comments ON users.id=comments.author_id
WHERE comments.post_id=17;

-- all the comments for post 39
SELECT * FROM comments WHERE post_id=39;

-- all the users that commented on their own post
SELECT sub.author_id, users.name
    FROM (SELECT DISTINCT
        comments.author_id FROM comments
        INNER JOIN posts ON comments.author_id=posts.author_id
    ) sub
INNER JOIN users ON users.id=sub.author_id;

-- all the posts that have more than one comment
SELECT sub.post_id, posts.*
    FROM (SELECT
        comments.post_id
        FROM comments
        GROUP BY (comments.post_id)
        HAVING COUNT(comments.post_id)>1
        ) sub
INNER JOIN posts ON posts.id=sub.post_id;


-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL
);

-- create a query to get all the likes a user has made
SELECT posts.id
FROM posts
INNER JOIN likes ON posts.id=likes.post_id
WHERE likes.user_id=1;

-- create a query to get all users that like a post
SELECT users.*
FROM users
INNER JOIN likes ON users.id=likes.user_id
WHERE likes.post_id=1;

-- create a query to get all the posts a user has liked
SELECT posts.content
FROM posts
INNER JOIN likes ON posts.id=likes.post_id
WHERE likes.user_id=1;