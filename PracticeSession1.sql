show databases;
use assignment2;

show tables;

CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    country VARCHAR(50)
);

INSERT INTO artists VALUES
(1, 'Arijit Singh', 'India'),
(2, 'Taylor Swift', 'USA'),
(3, 'Ed Sheeran', 'UK'),
(4, 'Shreya Ghoshal', 'India'),
(5, 'Drake', 'Canada'),
(6, 'Bad Bunny', 'Puerto Rico'),
(7, 'Atif Aslam', 'Pakistan');

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist_id INT,
    duration INT,
    FOREIGN KEY (artist_id)
        REFERENCES artists (artist_id)
);

INSERT INTO songs VALUES
(1, 'Tum Hi Ho', 1, 240),
(2, 'Love Story', 2, 230),
(3, 'Shape of You', 3, 250),
(4, 'Raabta', 1, 260),
(5, 'Blank Space', 2, 220),
(6, 'Sun Raha Hai', 4, 245),
(7, 'Gods Plan', 5, 210),
(8, 'Dakiti', 6, 200),
(9, 'Jeene Laga Hoon', 7, 255),
(10, 'Perfect', 3, 240),
(11, 'Lover', 2, 235);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO users VALUES
(1, 'Gautam', 'Mumbai'),
(2, 'Rahul', 'Delhi'),
(3, 'Sneha', 'Pune'),
(4, 'Amit', 'Bangalore'),
(5, 'Priya', 'Mumbai'),
(6, 'Karan', 'Delhi'),
(7, 'Neha', 'Hyderabad'),
(8, 'Rohit', 'Mumbai');



CREATE TABLE listens (
    listen_id INT PRIMARY KEY,
    user_id INT,
    song_id INT,
    listen_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

INSERT INTO listens VALUES(
(1, 1, 1, '2025-03-01'),
(2, 1, 2, '2025-03-02'),
(3, 2, 1, '2025-03-02'),
(4, 2, 3, '2025-03-03'),
(5, 3, 2, '2025-03-03'),
(6, 3, 4, '2025-03-04'),
(7, 4, 5, '2025-03-05'),
(8, 1, 3, '2025-03-06'),
(9, 5, 1, '2025-03-06'),
(10, 6, 7, '2025-03-07'),
(11, 7, 8, '2025-03-07'),
(12, 8, 3, '2025-03-08'),
(13, 1, 10, '2025-03-08'),
(14, 2, 11, '2025-03-09'),
(15, 5, 6, '2025-03-10'),
(16, 6, 2, '2025-03-10'),
(17, 7, 9, '2025-03-11'),
(18, 8, 4, '2025-03-12'),
(19, 3, 7, '2025-03-12'),
(20, 4, 8, '2025-03-13'));

show tables;
desc artists;

-- find most popular songs based on number of listens
select s.song_name, count(l.song_id) as counts from listens l join songs s on s.song_id=l.song_id group by s.song_name order by counts desc;

-- find most popular artist
select a.artist_name, count(*) from artists a join songs s on a.artist_id=s.artist_id join listens l on s.song_id=l.listen_id group by a.artist_name order by count(*) desc limit 1;

-- find users who listened to taylor swift songs
select u.user_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id join artists a on a.artist_id=s.artist_id where a.artist_name="Taylor Swift";

-- find users who never listened to any song
select u.user_name from users u left join listens l on u.user_id=l.user_id where l.song_id is null;

-- find pairs of users from same city
select u1.user_name, u2.user_name, u1.city from users u1 join users u2 on u1.city=u2.city and u1.user_id>u2.user_id;

-- show all songs with their artist and duration
select a.artist_name, s.song_name, s.duration name from artists a join songs s on a.artist_id=s.artist_id;

-- show which user listened to which song
select u.user_name, s.song_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id;

-- show one song per user
select u.user_name, s.song_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id group by u.user_name;

-- show all user-song listening records
select u.user_name, s.song_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id;

-- show songs listened by users from mumbai
select u.user_name, s.song_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id where u.city="Mumbai";

-- count total listens per user
select u.user_name, count(*) from users u join listens l on u.user_id=l.user_id group by u.user_name;

-- show songs with artist country
select a.artist_name, s.song_name, a.country name from artists a join songs s on a.artist_id=s.artist_id;

-- find users who listened to indian artists
select u.user_name, a.artist_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id join artists a on a.artist_id=s.artist_id where a.country="India";

-- attempt to find songs with no artist
select s.song_name from songs s join artists a on s.artist_id=a.artist_id where s.song_id is null;

-- find songs never listened
select s.song_name from songs s left join listens l on s.song_id=l.song_id where l.listen_id is null;

-- find artists with no songs
select a.artist_name from songs s right join artists a on s.artist_id=a.artist_id where s.song_id is null;

-- find users who listened to more than 2 songs
select u.user_name, count(*) from users u join listens l on u.user_id=l.user_id group by u.user_name having count(*)>2;

-- find songs listened after a specific date
select  distinct s.song_name, l.listen_date from songs s join listens l on s.song_id=l.song_id where l.listen_date > "2025-03-05";

-- find users who listened to all songs of an artist


-- find users who listened to at least 50% of an artist's songs
select u.user_name, a.artist_name from users u join listens l on u.user_id=l.user_id join songs s on s.song_id=l.song_id join artists a on a.artist_id=s.artist_id group by u.user_name, a.artist_name, a.artist_id having count(distinct s.song_id)=(select (count(*)/2) from songs s1 where s1.artist_id = a.artist_id);

-- Second most popular song overall
select s.song_name, count(l.song_id) as counts from listens l join songs s on s.song_id=l.song_id group by s.song_name order by counts desc limit 1 offset 1;

SELECT *
FROM (
    SELECT s.song_name,
           COUNT(l.song_id) AS counts,
           DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking
    FROM listens l
    JOIN songs s ON s.song_id = l.song_id
    GROUP BY s.song_name
) t
WHERE ranking = 1;

-- Stored Procedures

DELIMITER //

create procedure get_all_songs()
begin
select * from songs;
end//

DELIMITER ;
call get_all_songs();

DELIMITER //

CREATE PROCEDURE get_songs_by_artist(IN aid INT)
BEGIN
    SELECT s.song_name
    FROM songs s
    WHERE s.artist_id = aid;
END //

DELIMITER ;
CALL get_songs_by_artist(1);

DELIMITER //

CREATE PROCEDURE get_songs_by_artist_duration(IN aid INT, IN min_duration INT)
BEGIN
    SELECT s.song_name, s.duration
    FROM songs s
    WHERE s.artist_id = aid
	AND s.duration > min_duration;
END //

DELIMITER ;
call get_songs_by_artist_duration(1,250);

DELIMITER //

CREATE PROCEDURE get_listen_counting(IN sid INT, OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM listens
    WHERE song_id = sid;
END //

DELIMITER ;
CALL get_listen_count(1, @result);
SELECT @result;

DELIMITER //

CREATE PROCEDURE check_popularity(IN sid INT)
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt
    FROM listens
    WHERE song_id = sid;

    IF cnt > 3 THEN
        SELECT 'Popular Song' AS status;
    ELSE
        SELECT 'Not Popular' AS status;
    END IF;

END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE check_popularity(IN sid INT)
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM listens WHERE song_id = sid;
    IF cnt > 3 THEN 
    SELECT 'Popular Song' AS status;
    ELSEs
	SELECT 'Not Popular' AS status;
    END IF;

END //

DELIMITER ;

CALL check_popularity(1);

DELIMITER //

create procedure print_number(in i int)
begin
declare i int default 1;
while i<=5 do 
select i; 
set i=i+1;
end while;
end //

DELIMITER //

call print_number();

-- find top songs using stored procedures

DELIMITER //

create procedure top_song()
begin
select s.song_name, count(l.song_id) from songs s join listens l on s.song_id=l.song_id group by l.song_id;
end //

DELIMITER ;
call top_song();

-- Create a procedure to return all users from a given city.
DELIMITER //

create procedure userss(in city_name varchar(50))
begin
select user_name, city from users where city=city_name;
end //

DELIMITER ;

call userss("Mumbai");

-- Return total listens for a given user_id.
DELIMITER //

create procedure total_listens(in user_idd int)
begin 
select u.user_id,u.user_name,count(l.song_id) from users u join listens l on u.user_id=l.user_id group by u.user_id having u.user_id=user_idd;
end //

DELIMITER ;
call total_listens(1);

-- Return users who listened to every song of that artist.
DELIMITER //

CREATE PROCEDURE users_listened_all_songs(IN aid INT)
BEGIN
    SELECT u.user_name
    FROM users u
    JOIN listens l ON u.user_id = l.user_id
    JOIN songs s ON s.song_id = l.song_id
    WHERE s.artist_id = aid
    GROUP BY u.user_id
    HAVING COUNT(DISTINCT s.song_id) = (
        SELECT COUNT(*)
        FROM songs
        WHERE artist_id = aid
    );
END //

DELIMITER ;

CALL users_listened_all_songs(4);

DELIMITER //

CREATE PROCEDURE top_n_songs_per_artist(IN n INT)
BEGIN
    SELECT *
    FROM (
        SELECT a.artist_name,
               s.song_name,
               COUNT(*) AS total_listens,
               DENSE_RANK() OVER (
                   PARTITION BY a.artist_id
                   ORDER BY COUNT(*) DESC
               ) AS rnk
        FROM artists a
        JOIN songs s ON a.artist_id = s.artist_id
        JOIN listens l ON s.song_id = l.song_id
        GROUP BY a.artist_id, s.song_id
    ) t
    WHERE rnk <= n;
END //

DELIMITER ;

CALL top_n_songs_per_artist(4);

DELIMITER //

CREATE FUNCTION get_listen_count(sid INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt
    FROM listens
    WHERE song_id = sid;

    RETURN cnt;
END //

DELIMITER ;
select get_listen_count(1);

DELIMITER //
create function get_eerything(artist int)
returns varchar(50)
deterministic
begin
declare name varchar(50);
select artist_name into name from artists where artist_id=artist;
return name;
end //
DELIMITER ;
select get_eerything(2);

-- Return number of songs of an artist
DELIMITER //
create function total_songs(aid int)
returns int
deterministic
begin
declare count int;
select count(*) into count from songs where artist_id=aid;
return count;
end//
DELIMITER ;

select total_songs(1);

-- Return 'Active' if user has >2 listens else 'Inactive'
DELIMITER //
create function active_user(uid int)
returns varchar(10)
deterministic
begin
declare count int;
select count(*) into count from listens where user_id=uid;
if count>2 then return 'Active';
 else return 'Inactive';
 end if;
 end//
 DELIMITER ;
 select active_user(4);
 
-- Return highest listen count among all songs
DELIMITER //

CREATE FUNCTION max_song_listens()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE max_cnt INT;
    SELECT MAX(cnt) INTO max_cnt
    FROM (
        SELECT COUNT(*) AS cnt
        FROM listens
        GROUP BY song_id
    ) t;
    RETURN max_cnt;
END //

DELIMITER ;
select max_song_listens();

CREATE TABLE listen_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    song_id INT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

desc listen_log;
DELIMITER //

CREATE TRIGGER after_listen_insert
AFTER INSERT ON listens
FOR EACH ROW
BEGIN
    INSERT INTO listen_log(song_id)
    VALUES (NEW.song_id);
END //

DELIMITER ;
INSERT INTO listens VALUES (21, 1, 1, '2025-03-15');

DELIMITER //

CREATE TRIGGER check_duration
BEFORE INSERT ON songs
FOR EACH ROW
BEGIN
    IF NEW.duration <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid duration';
    END IF;
END //

DELIMITER ;

DELIMITER //

create trigger prevent_delete
before delete on songs
for each row
begin
if exists (select 1 from listens where song_id=old.song_id)
then signal sqlstate '45'
set message_text="Cannot diljeet songs with listens";
end if;
end //

DELIMITER ;
/*
start transaction
update lstens set user_id=2 where i_d=1;
select row_count() into @rows;
if @rows=0 then rollback;
else commit;
end if;
*/

WITH song_counts AS (
    SELECT song_id, COUNT(*) AS cnt
    FROM listens
    GROUP BY song_id
),
top_songs AS (
    SELECT *
    FROM song_counts
    WHERE cnt > 2
)
SELECT *
FROM top_songs;
