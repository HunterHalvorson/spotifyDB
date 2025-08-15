-- Advanced SQL Project
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA
SELECT COUNT(*) FROM spotify

SELECT count(DISTINCT artist) FROM spotify;

SELECT count(DISTINCT album) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min), MIN(duration_min) FROM spotify

SELECT * FROM spotify WHERE duration_min = 0

DELETE FROM spotify WHERE duration_min = 0


-- ----------------------------
-- Data Analysis -Easy Category
-- ----------------------------
--  1. Retreive the names of all tracks that have more than 1 billion streams
SELECT * FROM spotify WHERE stream > 1000000000
--  2. List all albums along with their respective artists
SELECT DISTINCT album, artist FROM spotify ORDER BY 1
--  3. Get total comments where liscenced = TRUE
SELECT SUM(comments) FROM spotify WHERE licensed = TRUE
--  4. Find all tracks that belong to the album type single
SELECT track FROM spotify WHERE album_type = 'single'
--  5. Count the total number of tracks by each artist
SELECT artist, COUNT(track) FROM spotify GROUP BY artist ORDER BY 2 DESC


-- ----------------------------
-- Data Analysis -Medium Category
-- ----------------------------
--  1. Calculate the average danceability of tracks in each album
SELECT
  album,
  avg(danceability) AS average_danceability
FROM
  spotify
GROUP BY 1
ORDER BY 2 DESC
--  2. Find the top 5 tracks with the highest energy values
SELECT
  track,
  energy
FROM
  spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--  3. List all tracks along with their likes and views where there is a video
SELECT
  track, SUM(likes), SUM(views)
FROM spotify 
WHERE official_video = TRUE
GROUP BY 1
ORDER BY 2 DESC, 3 DESC
--  4. For each album calculate the total views of all associated tracks
SELECT
  album,
  SUM(views)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
--  5. Retreive the track names that have been streamed on spotify more than youtube
SELECT * 
FROM (SELECT
        track,
        SUM(CASE WHEN most_played_on = 'Youtube' THEN stream ELSE 0 END) AS streamed_on_youtube,
        SUM(CASE WHEN most_played_on = 'Spotify' THEN stream ELSE 0 END) AS streamed_on_spotify
      FROM spotify
      GROUP BY track) as t1
WHERE streamed_on_spotify > streamed_on_youtube AND streamed_on_youtube <> 0


-- ----------------------------
-- Data Analysis -Medium Category
-- ----------------------------
--  1. Find the top 3 most-viewed tracks for each artist using window functions.

-- each artist and total views for each track
-- track with highest view for each artist
-- dense rank
-- cte and filter rank <= 3
WITH ranking_artist AS (
  SELECT
    artist,
    track,
    SUM(views) as total_views,
    -- DENSE_RANK(): This is a window function that assigns a rank to each row in a result set.
    DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) as rank
  FROM
    spotify
  GROUP BY 1, 2 
  ORDER BY 1, 3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <= 3

--  2. Write a query to find tracks where the liveness score is above the average.

SELECT track, artist, liveness FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)

--  3. Use a WITH clause to calculate the difference between  the highest and lowest energy values for tracks in each album.
WITH hi_lo AS(
  SELECT album, MAX(energy) as hi_en, MIN(energy) as low_en
  FROM spotify
  GROUP BY 1
)

SELECT album, hi_en - low_en as energy_diff
FROM hi_lo


