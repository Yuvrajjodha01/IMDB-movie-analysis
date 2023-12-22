use new_schema;
-- 1.Find the movies with the highest profit?
select * from excelfile;
SELECT
    movie_title,director_name,gross,budget,
    gross - budget AS profit
FROM
    excelfile
WHERE
    budget > 0
ORDER BY
    profit DESC
LIMIT 10;

-- 2.Find IMDB Top 250 and Top Non English Movies

SELECT
    row_number() OVER (order by imdb_score DESC) AS rank_no,
    movie_title,
    imdb_score,
    language
FROM
    excelfile
LIMIT 250;    
SELECT
    row_number() OVER (order by imdb_score DESC) AS rank_no,
    movie_title,
    imdb_score,
    language
FROM
    excelfile
WHERE    
    language NOT IN ('English')
LIMIT 250;

-- 3.Find the best directors.

SELECT
	director_name,
    round(AVG(imdb_score),2) AS avg_imdb_score
FROM
   excelfile
GROUP BY
   director_name
ORDER BY
   avg_imdb_score DESC
LIMIT 10;

-- 4.Find the best actor

SELECT actor_1_name,round(avg(num_critic_for_reviews),2) as critic_fav,
round(avg(num_user_for_reviews),2) as Audience_fav from excelfile where
actor_1_name in ('Meryl streep','Leonardo Dicaprio','Brad Pitt') group by actor_1_name;

SELECT
    actor_1_name,
    actor_2_name,
    actor_3_name,
    (AVG(num_critic_for_reviews) + AVG(num_user_for_reviews)) / 2 AS mean_reviews
FROM
   excelfile
GROUP BY
   actor_1_name,
   actor_2_name,
   actor_3_name
ORDER BY
   mean_reviews DESC
LIMIT 10;   

-- 5.Find the number of user votes per decade.
-- For example, if a movie has title_year 1995, then FLOOR(1995 / 10) = FLOOR(199.5) = 199. The expression FLOOR(title_year)
-- then multiplies this rresult by 10 to get the starting year of the decade. In this case, 199 * 10 = 1990.

SELECT
concat(CONVERT( FLOOR(title_year / 10) * 10 , CHAR),'s') AS decade,
sum(num_voted_users) AS total_votes
FROM
excelfile
GROUP BY
decade
ORDER BY
decade
 