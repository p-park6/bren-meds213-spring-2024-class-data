-- create temp table that gets calculates the volume of the egg and then averages it
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14/6)*(Width)^2*Length) AS Avg_volume
        FROM Bird_eggs
        GROUP BY Nest_ID;

-- create temp table to get Species column
CREATE TEMP TABLE Egg_Averages AS
    SELECT Species, Nest_ID, Avg_volume
        FROM Bird_nests JOIN Averages USING (Nest_ID);
        GROUP BY Species, Nest_ID, Avg_volume;

-- join with bird_nest table to get the Scientific name
SELECT Scientific_name, MAX(Avg_volume), 
    FROM Species JOIN Egg_Averages ON Code = Species
    GROUP BY Scientific_name
    ORDER BY MAX(Avg_volume) DESC;

-- delete table syntax
DROP TABLE;