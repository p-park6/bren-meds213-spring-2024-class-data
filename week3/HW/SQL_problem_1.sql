-- Part 1
-- create temp table
CREATE TEMP TABLE table1 (
    Count REAL NULL
);

-- insert counts into column
INSERT INTO table1 (Count)
    VALUES (5), (10), (15), (20), (25), (NULL);

SELECT AVG(Count)
    FROM table1;

-- Part 2
SELECT SUM(Count)/COUNT(*) FROM table1;
SELECT SUM(Count)/COUNT(Count) FROM table1;

DROP TABLE mytable;