-- all the users that commented on ia single post (ex. post id 1)
SELECT * FROM comments INNER JOIN users ON comments.author_id = users.id WHERE comments.post_id = 1;

-- all the comments for post 39
SELECT * FROM comments WHERE post_id = 39;

-- all the users that commented on their own post
SELECT * FROM users INNER JOIN posts ON users.id = posts.author_id INNER JOIN comments ON users.id = comments.author_id WHERE posts.id = comments.post_id;

-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  user_id INTEGER,
  post_id INTEGER
);

-- create a query to get all the likes a user has made
SELECT * FROM users INNER JOIN likes ON users.id = likes.user_id WHERE users.id = 1;

-- create a query to get all users that like a post
SELECT * FROM users INNER JOIN likes ON users.id = likes.user_id WHERE likes.post_id = 1;

-- create a query to get all the posts a user has liked
SELECT * FROM posts INNER JOIN likes ON posts.id = likes.post_id WHERE likes.user_id = 1;
