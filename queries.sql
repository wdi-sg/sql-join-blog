-- all the users that commented on ia single post (ex. post id 1)
SELECT comments.author_id, users.name AS author_name
FROM users
INNER JOIN comments
ON (comments.author_id = users.id)
WHERE comments.post_id = 17;

-- all the comments for post 39
SELECT content FROM comments WHERE post_id = 39;

-- all the users that commented on their own post
SELECT comments.post_id, users.name, comments.author_id AS comments_author_id, posts.author_id AS posts_author_id
FROM posts
INNER JOIN comments
ON (comments.post_id = posts.id)
INNER JOIN users
ON (comments.author_id = users.id)
WHERE comments.author_id = posts.author_id

-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  author_id INTEGER,
  posts_id integer
);

-- create a query to get all the likes a user has made
SELECT count(*) FROM likes WHERE author_id = 1;

-- create a query to get all users that like a post
SELECT author_id FROM likes WHERE posts_id = 1;

-- create a query to get all the posts a user has liked
SELECT posts_id FROM likes WHERE author_id = 1;
