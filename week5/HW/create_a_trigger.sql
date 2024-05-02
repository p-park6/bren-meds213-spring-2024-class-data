-- Part 1
-- insert a new observations into the Bird_eggs table
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.6', 2014, 'eaba', '14eabaage01', 12.34, 56.78);

-- view the observations in the nest id we are interested in
SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01';

-- Create a trigger to fill in a value for egg_num column
CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE Bird_eggs
        SET Egg_num = (SELECT COUNT(*) FROM Bird_eggs WHERE Nest_ID = new.Nest_ID)
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
    END;

-- recheck those observations to see if egg_num has been updated correctly
SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01';


-- reset trigger
DROP TRIGGER egg_filler


-- Part 2
-- update table for other columns for Book_page, Year, and Site
CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
    -- update egg_num
        UPDATE Bird_eggs
        SET Egg_num = (SELECT COUNT(*) FROM Bird_eggs WHERE Nest_ID = new.Nest_ID)
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
    -- update book_page
        UPDATE Bird_eggs
        SET Book_page = (SELECT Book_page FROM Bird_eggs WHERE Length = new.Length)
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
    -- update Year
        UPDATE Bird_eggs
        SET Year = (SELECT Year FROM Bird_eggs WHERE Width = new.Width)
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
    -- update site
        UPDATE Bird_eggs
        SET Site = (SELECT Site FROM Bird_eggs WHERE Nest_ID = new.Nest_ID)
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
    END;


-- to see column names
pragma table_info(Bird_eggs)