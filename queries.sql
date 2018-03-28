-- all the users that commented on ia single post (ex. post id 1)
SELECT name, posts.id
FROM ((users
INNER JOIN posts ON users.id = posts.author_id)
WHERE posts.id = 1;

-- all the comments for post 39
SELECt comments.content,post_id
FROM comments
INNER JOIN posts ON comments.post_id = posts.id
WHERE posts.id = 39;

                        content                        | post_id 
-------------------------------------------------------+---------
 Random comments of blog post go on is great.          |      39
 Random comments of blog post and on and on goes boom. |      39
(2 rows)

-- all the users that commented on their own post
SELECT name
FROM users
INNER JOIN comments ON users.id = comments.author_id
WHERE comments.post_id = comments.author_id;

 name 
------
 Dana
(1 row)

-- all the posts that have more than one comment
SELECT posts.content, posts.id
FROM posts 
INNER JOIN comments ON posts.id = comments.post_id
GROUP BY posts.id
HAVING count(comments.post_id) > 1
ORDER BY count(comments.post_id) DESC;

-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
CREATE TABLE IF NOT EXISTS likes (
	author_id INTEGER PRIMARY KEY,
	posts_id INTEGER
)

-- create a query to get all the likes a user has made
SELECT likes.author_id, posts.title
FROM likes
INNER JOIN posts ON posts.id = likes.posts_id
WHERE likes.author_id = "1";

-- create a query to get all users that like a post
SELECT users.name
FROM users
INNER JOIN likes ON likes.author_id = users.id
WHERE likes.posts_id = "1";

-- create a query to get all the posts a user has liked
SELECT post.title
FROM ((likes
INNER JOIN user ON user.id = likes.author_id)
INNER JOIN posts ON posts.id = likes.post_id)
WHERE user.name = "Alex";
