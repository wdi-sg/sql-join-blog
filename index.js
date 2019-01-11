
const pg = require('pg');
//this is after 'npm init' and 'npm i pg'

const configs = {
user: 'postgres',
password: 'postgres',
host: '127.0.0.1',
database: 'blog',
port: 5432,
};

// sudo -u postgres createdb blog
// psql -d blog -U postgres -f tables.sql;

const client = new pg.Client(configs);

const show = text => {
	client.query(text,(err, res) => {
		if( err ){
     	console.log( "error", err.message );
    	} else {
			// console.log("result: ", res.rows); 
			for(let i=0; i<res.rows.length; i++) {
				console.log(res.rows[i]);
			}
		};
	})
}


client.connect((err) => {

	console.log("Starting PSQL");
 
	if (process.argv[2] == "") {
		process.argv[2] = "undefined";
	}

	let command = (process.argv[2]).toUpperCase();
	let task = process.argv[3];
	let update = process.argv[4];
	let fifth = process.argv[5];
	let sixth = process.argv[6];

	let text = "";

	switch (command) {

// -- all the users that commented on ia single post (ex. post id 1)
		case 'POSTUSERS':
		    text = `
		    SELECT users.name, posts.author_id, posts.id, posts.content AS post_content, comments.content AS comment_content
		    FROM ((users
		    INNER JOIN posts 
		    ON users.id = posts.author_id)
		    INNER JOIN comments 
		    ON posts.id = comments.post_id);`;
		    console.log('All games as follows:');
		    break;

// -- all the comments for post 39
		case 'POSTCOMMENTS':
		    text = `
		    SELECT posts.id, posts.content AS post_content, comments.content AS comment_content
		    FROM posts
		    INNER JOIN comments 
		    ON posts.id = comments.post_id
		    WHERE posts.id = 39;`;
		    console.log('All comments as follows:');
		    break;

// -- all the users that commented on their own post
		case 'SELFCOMMENT':
		    text = `
		    SELECT users.name, posts.author_id, posts.id, posts.content AS post_content, comments.content AS comment_content
		    FROM ((users
		    INNER JOIN posts 
		    ON users.id = posts.author_id)
		    INNER JOIN comments 
		    ON posts.id = comments.post_id)
		    WHERE posts.author_id = comments.author_id;`;
		    console.log('All games as follows:');
		    break;

// -- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
		//see like table in tables.sql

// -- create a query to get all the likes a user has made
		case 'POSTSLIKED':
		    text = `
		    SELECT posts.id AS post_id, posts.content, users.name, users.id AS user_id
		    FROM ((users
		    INNER JOIN likes 
		    ON users.id = likes.user_id)
		    INNER JOIN posts 
		    ON likes.posts_id = posts.id)
		    WHERE users.id = 2
		    ;`;
		    console.log('All games as follows:');
		    break;

// -- create a query to get all users that like a post
		case 'USERSLIKED':
		    text = `
		    SELECT users.name, users.id AS user_id, posts.id AS post_id
		    FROM ((users
		    INNER JOIN likes 
		    ON users.id = likes.user_id)
		    INNER JOIN posts 
		    ON likes.posts_id = posts.id)
		    WHERE posts.id = 2
		    ;`;
		    console.log('All games as follows:');
		    break;

// -- create a query to get all the posts a user has liked
		case 'USERSLIKEDPOSTS':
		    text = `
		    SELECT users.name, users.id AS user_id, posts.id AS post_id, posts.content
		    FROM ((users
		    INNER JOIN likes 
		    ON users.id = likes.user_id)
		    INNER JOIN posts 
		    ON likes.posts_id = posts.id)
		    WHERE users.id = 2
		    ;`;
		    console.log('All games as follows:');
		    break;
		}
	show(text);
});

