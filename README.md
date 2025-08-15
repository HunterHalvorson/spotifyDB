# Advanced SQL Project: Spotify Data Analysis

## Project Overview
This project demonstrates the use of **SQL** for exploratory data analysis (EDA) and advanced data analysis on a simulated Spotify dataset. The dataset includes information about tracks, albums, artists, and their associated metrics, such as views, likes, comments, and audio features.  

The goal of this project is to showcase SQL skills in:  
- Data cleaning and preparation  
- Aggregation and filtering  
- Use of window functions  
- Advanced analysis using Common Table Expressions (CTEs)  

---

## Dataset
The dataset (`spotify`) contains the following columns:  

| Column | Description |
|--------|-------------|
| artist | Name of the artist |
| track | Name of the track |
| album | Name of the album |
| album_type | Type of album (`single`, `album`, etc.) |
| danceability | Audio feature (float) |
| energy | Audio feature (float) |
| loudness | Audio feature (float) |
| speechiness | Audio feature (float) |
| acousticness | Audio feature (float) |
| instrumentalness | Audio feature (float) |
| liveness | Audio feature (float) |
| valence | Audio feature (float) |
| tempo | Audio feature (float) |
| duration_min | Track duration in minutes |
| title | Track title |
| channel | Channel name |
| views | Number of views (float) |
| likes | Number of likes (bigint) |
| comments | Number of comments (bigint) |
| licensed | Boolean flag for licensed tracks |
| official_video | Boolean flag for official videos |
| stream | Total streams (bigint) |
| energy_liveness | Combined metric of energy and liveness |
| most_played_on | Platform where the track is most played (`Spotify` or `Youtube`) |

---

## Project Structure

### 1. Data Preparation / EDA
- Count total records and unique artists/albums  
- Identify distinct album types  
- Check for invalid durations and remove rows with `duration_min = 0`  

### 2. Easy Data Analysis
- Retrieve tracks with over 1 billion streams  
- List all albums and their respective artists  
- Calculate total comments for licensed tracks  
- Find tracks that are singles  
- Count total tracks by each artist  

### 3. Medium Data Analysis
- Calculate average danceability of tracks per album  
- Find top 5 tracks with the highest energy  
- Aggregate likes and views for tracks with official videos  
- Calculate total views per album  
- Identify tracks streamed more on Spotify than Youtube  
- Use **window functions** to find top 3 most-viewed tracks for each artist  
- Filter tracks with liveness above the average  
- Use a **CTE** to calculate the energy difference (max - min) for each album  

---

## SQL Techniques Used
- **Aggregation Functions**: `SUM()`, `AVG()`, `MAX()`, `MIN()`, `COUNT()`  
- **Filtering**: `WHERE`, `CASE` statements  
- **Grouping**: `GROUP BY` for aggregation per artist, album, or track  
- **Window Functions**: `DENSE_RANK()` for ranking tracks per artist  
- **CTEs (WITH Clause)**: For intermediate calculations like ranking or energy difference  
- **Ordering**: `ORDER BY` to sort results  

---

## How to Run
1. Install PostgreSQL or any SQL environment.  
2. Create the `spotify` table using the provided schema.  
3. Load your dataset into the `spotify` table.  
4. Run the queries in the order provided to perform EDA and analysis.  

---

## Future Work
- Include additional audio features like `key` and `mode`.  
- Explore correlations between metrics like `danceability`, `energy`, and `streams`.  
- Visualize results using Python or Tableau for better insights.  
- Incorporate more advanced window functions, like `ROW_NUMBER()` or `RANK()` with ties.  
