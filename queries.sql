-- all the users that commented on ia single post (ex. post id 1)

SELECT users.name, COUNT(*) FROM comments
INNER JOIN users ON comments.author_id = users.id GROUP BY users.name
HAVING COUNT(*) = 1;

-- all the comments for post 39

SELECT * FROM comments WHERE post_id = 39;

-- all the users that commented on their own post

SELECT users.name FROM posts
INNER JOIN comments ON posts.id = comments.post_id AND posts.author_id = comments.author_id
INNER JOIN users ON comments.author_id = users.id;

-- all the posts that have more than one comment

SELECT posts.title, COUNT(*) FROM comments
INNER JOIN posts ON posts.id = comments.post_id GROUP BY posts.title HAVING COUNT(*) > 1;

-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )

CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  post_id INTEGER,
  user_id INTEGER
);

-- create a query to get all the likes a user has made

SELECT * FROM likes WHERE user_id = ?;

-- create a query to get all users that like a post

SELECT DISTINCT name from users
INNER JOIN likes WHERE users.id = likes.user_id;

-- create a query to get all the posts a user has liked

SELECT posts.id, title, content, created_at, author_id, category_id FROM posts
INNER JOIN likes ON posts.id = likes.post_id;
