duckdb
.open database.db


.maxrow 6
SELECT Location FROM Site;
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM Site WHERE Area < 200 AND Location LIKE '%USA';
-- expressions
SELECT Site_name, Area FROM Site;
SELECT Site_name, Area * 2.47 FROM Site;
SELECT Site_name, Area * 2.47 AS Area_acres FROM Site;
SELECT Site_name || 'foo' FROM Site;
--aggregation functions
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) AS num_rows FROM Site;
.help mode
.mode box
SELECT Site_name, Area * 2.47 AS Area_acres FROM Site;
.mode duckbox
SELECT COUNT(Scientific_name) FROM SPECIES;
SELECT DISTINCT Relevance FROM SPECIES;
SELECT COUNT(DISTINCT Relevance) FROM Species;
-- MIN, MAX, AVE
SELECT AVG(Area) FROM Site;
-- Grouping
SELECT * FROM Site;
SELECT Location, MAX(Area)
  FROM Site
  GROUP BY Location;
SELECT * FROM Species;
SELECT Relevance, COUNT(*)
  FROM Species
  GROUP BY Relevance;
-- adding WHERE clause
SELECT Location, MAX(Area)
  FROM Site
  GROUP BY Location;
SELECT Location, MAX(Area)
  FROM Site
  WHERE Location LIKE '%Canada'
  GROUP BY Location;
SELECT Location, MAX(Area) AS Max_area
  FROM Site
  WHERE Location LIKE '%Canada'
  HAVING Max_area > 200;
-- relational algebra peeks through!
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Site);
SELECT * FROM Bird_nests LIMIT 3;
SELECT COUNT(*) FROM Species
SELECT * FROM Species
  WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests);
-- saving queries
CREATE TEMP TABLE y AS
  SELECT * FROM Species
    WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests);
SELECT * FROM t ;
SELECT * FROM t_perm;
DROP TABLE t_perm;
-- NULL Processing
SELECT COUNT(*) FROM Bird_nests
  WHERE floatAge > 5;
SELECT COUNT(*) FROM Bird_nests
  WHERE floatAge <= 5;
SELECT COUNT(*) FROM Bird_nests
SELECT COUNT(*) FROM Bird_nests WHERE floatAge = NULL;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NULL;
-- joins
SELECT * FROM Camp_assignment;
SELECT * FROM Personnel;
SELECT * FROM Camp_assignment JOIN Personnel
  ON Observer = Abberviation;
.mode csv
.mode duckbox
SELECT * From Camp_assignement JOIN Personnel
  ON Observer = Abbreviation
  LIMIT 3;
SELECT * FROM Camp_assignment JOIN Personnel
  ON Camp_assignment.Observer = Personnel.Abbreviation;
-- Multiway join
SELECT * FROM Camp_assignment ca JOIN Personnel p
  ON ca.Observer = p.Abbreviation
  JOIN Site s
  ON ca.Site = s.Code
  WHERE ca. Observer = 'lmckinnon'
  LIMIT 3;
  -- order by: at end
  SELECT * FROM Camp_assignment ca JOIN Personnel p
    ON ca.Observer = p.Abbreviation
    JOIN Site s
    ON ca.Site = s.Code
    WHERE ca. Observer = 'lmckinnon'
    LIMIT 3;
-- more on grouping
SELECT Nest_ID, COUNT(*) FROM Bird_eggs GROUP BY Nest_ID;




  
  
  