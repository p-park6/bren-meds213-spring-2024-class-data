-- create a temp table
CREATE TEMP TABLE obs_persons AS
-- create two 'identical tables' and then join them together
SELECT B.Site, A.Observer, B.Observer FROM Camp_assignment AS A JOIN Camp_assignment AS B
-- join by site and date
    ON A.Site = B.Site AND (A.Start <= B.End)  AND  (A.End >= B.Start)
    -- make sure observations are unique columns
    WHERE A.Site = 'lkri' AND A.Observer < B.Observer;

-- rename both tables to appropriate column names
ALTER TABLE obs_persons RENAME COLUMN Observer_1 TO Observer_2;
ALTER TABLE obs_persons RENAME COLUMN Observer TO Observer_1; 