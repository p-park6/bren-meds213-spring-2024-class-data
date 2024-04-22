.tables
SELECT Nest_ID, COUNT(*) FROM Bird_nests
    GROUP BY Nest_ID;

.maxrow 8 
SELECT Species FROM Bird_nests WHERE Site = 'nome';
SELECT Species, COUNT(*) AS Nest_count -- we are selecting species and counting up how many nest count there are
    FROM Bird_nests -- we are selecting from Bird_nests table
    WHERE Site = 'nome' -- we are saying that the site much have this in it
    GROUP BY Species -- grouping by species
    LIMIT 2; -- only getting two results

-- can nest species
SELECT Scientific_name, Nest_count FROM -- we are selecting species and counting up how many nest count there are
    (SELECT Species, COUNT(*) AS Nest_count
    FROM Bird_nests -- we are selecting from Bird_nests table
    WHERE Site = 'nome' -- we are saying that the site much have this in it
    GROUP BY Species -- grouping by species
    ORDER BY Species
    LIMIT 2) JOIN Species ON Species = Code; -- saying that species column should equal to code column because those are the keys for the tables (primary and foreign keys)

-- outer joins
CREATE TEMP TABLE a (cola INTEGER, common INTEGER);
INSERT INTO a VALUES (1,1), (2,2), (3,3);
SELECT * FROM a;
CREATE TEMP TABLE b (common INTEGER, colb INTEGER);
INSERT INTO b VALUES (2,2), (3,3), (4,4), (5,5);

-- Inner join
SELECT * FROM a JOIN b USING (common);
SELECT * FROM a INNER JOIN b USING (common);

-- left or right outer join
SELECT * FROM a LEFT JOIN b USING (common);
.nullvalue -NULL-
.nullvalue ''
SELECT * FROM a RIGHT JOIN b USING (common)

--What species do *not* have nest data?
SELECT * FROM species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

-- Let's do the same using an outer join
SELECT Code
    FROM Species LEFT JOIN Bird_nests ON Code = Species;
nullvalue -NULL-

SELECT COUNT(*) FROM Bird_nests WHERE Species = 'ruff';
SELECT Code, Scientific_name, Nest_ID, Species, Year
    FROM Species LEFT JOIN Bird_nests ON Code = Species
    WHERE Nest_ID IS NULL;

-- a gotcha when doing grouping
SELECT * FROM Bird_eggs LIMIT 3;
SELECT * FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01';

SELECT Nest_ID, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;

-- What about this?
-- gives an error, doesn't make sense
SELECT Nest_ID, COUNT(*), Length
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;

-- what about this now?
SELECT Nest_ID, Species, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;

-- workaround #1
SELECT Nest_ID, Species, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID, Species;
-- workaround #2
SELECT Nest_ID, ANY_VALUE(Species), COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    WHERE Nest_ID = '14eabaage01'
    GROUP BY Nest_ID;

-- views
SELECT * FROM Camp_assignement;
SELECT Year, Site, Name, Start, "End"
    FROM Camp_assignment JOIN Personnel
    On Observer = Abbreviation;

CREATE VIEW v AS
    SELECT Year, Site, Name, Start, "End"
    FROM Camp_assignment JOIN Personnel
    On Observer = Abbreviation;

-- a view looks just like a table, but it's not real
SELECT * FROM v;
CREATE VIEW v2 AS SELECT COUNT(*) FROM Species;
SELECT * FROM v2;

--set operations: UNION, INTERSECT, EXCEPT
-- iffy example
SELECT Book_page, Nest_ID, Egg_num, Length, Width FROM Bird_eggs;
SELECT Book_page, Nest_ID, Egg_num, Length*25.4, Width*25.4 FROM Bird_eggs
    WHERE Book_page = 'b14.6'
    UNION
SELECT Book_page, Nest_ID, Egg_num, Length, Width, FROM Bird_eggs
    WHERE Book_page != 'b14.6'; --will not show results where book page is equal to null

-- UNION vs UNION ALL
-- just mashes tables together; not intelligent
-- Third way to answer: Which species have no nest data?
SELECT Code FROM Species
    Except SELECT DISTINCT Species FROM Bird_nests;
DROP VIEW v;