-- all the users that commented on ia single post (ex. post id 1)
Select name from users inner join comments on author_id = users.id  where posts.id = '1' group by users.id;

-- all the comments for post 39
select comments.content as comment from comments inner join posts on posts.id = post_id where post_id = '39';

-- all the users that commented on their own post
select name from comments inner join posts on posts.id = post_id inner join users on posts.author_id = users.id where posts.author_id = comments.author_id group by users.id;

-- all the posts that have more than one comment
select title from posts inner join comments on posts.id = post_id where count(comments.id) > 1 group by posts.id;

-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL,
  created_at DATE DEFAULT current_timestamp
 );

-- create a query to get all the likes a user has made
select posts.title from posts inner join likes on posts.id = post_id inner join users on user_id = users.id where users.id = 'user_id';

-- create a query to get all users that like a post
select users.name from posts inner join likes on posts.id = post_id inner join users on user_id = users.id where post.id = 'post_id';

-- create a query to get all the posts a user has liked
select posts.title from posts inner join likes on posts.id = post_id inner join users on user_id = users.id where users.id = 'user_id';
