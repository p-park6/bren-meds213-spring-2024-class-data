--Part 1
SELECT Site_name, MAX(Area) FROM Site;
-- fixed sql code
SELECT Site_name, MAX(Area) FROM Site
    GROUP BY Site_name;

-- Part 2
SELECT Site_name, MAX(Area) FROM Site
    GROUP BY Site_name
    ORDER BY MAX(Area) DESC
    LIMIT 1;

--Part 3
SELECT Site_name, MAX(Area) FROM Site
WHERE Area = (SELECT MAX(Area) FROM Site)
    GROUP BY Site_name;
