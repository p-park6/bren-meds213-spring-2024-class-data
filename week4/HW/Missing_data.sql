-- get the code column from the site table
SELECT Code FROM Site 
-- look at the Code column and look for rows that are now in Bird_eggs table
    WHERE Code NOT IN (SELECT DISTINCT Site FROM Bird_eggs)
    -- order by site (alphabetical)
    ORDER BY Site;

