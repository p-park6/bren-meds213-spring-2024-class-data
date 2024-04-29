SELECT * FROM Species;
.maxrows 8
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific name', NULL);
SELECT * FROM Species;
-- You can explicitly label the columns
INSERT INTO Species (Common_name, Scientific_name, Code, Relevance)
    Values('thing 2', 'another scientific name', 'efgh', NULL);
-- take advantage of default values
INSERT INTO Species (Common_name, Code) VALUES ('thing 3', 'ijkl');
.nullvalue -NULL-

-- Update and delete
UPDATE Species SET Relevance = 'not sure yet' WHERE Relevance IS NULL;
SELECT * FROM Species;
DELETE ROM Species WHERE Relevance = 'not sure yet';
SELECT * FROM Species;

-- safe delete practice #1
SELECT * FROM Species WHERE Relevance == 'Study species';
-- after confirming, then edit the statement
DELETE * FROM Species WHERE Relevance == 'Study species';
-- incomplete statement
FROM Species WHERE ....
-- check
SELCT * FROM Species WHERE Relevance IS NULL;

-- write a table as a csv file
COPY Species to 'species_fixed.csv' (HEADER, DELIMITER ',');

-- create new table
CREATE TABLE Snow_cover_2 (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1950 AND 2015),
    Date DATE NOT NULL,
    Plot VARCHAR, -- some Null in the data :/
    Location VARCHAR NOT NULL,
    Snow_cover INTEGER CHECK (Snow_cover > -1 AND Snow_cover < 101),
    Observer VARCHAR
);

-- IMPORT data from csv
COPY 'snow_cover2' FROM ''

-- write a table as a csv file
COPY snow_cover2 to 'snow_cover_fixedman_JB.csv' (HEADER TRUE);

CREATE TRIGGER Update_species
AFTER INSERT ON Species
FOR EACH ROW
BEGIN
    UPDATE Species
    SET Scientific_name = NULL
    WHERE Code = new.Code AND Scientific_name = '';
END;

.import --csv --skip 1 species.csv Species