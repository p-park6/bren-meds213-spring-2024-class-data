SELECT Observer, COUNT(ageMethod) AS Num_floated_nests FROM Bird_nests
    WHERE Site =='nome' AND ageMethod == 'float'
    AND Year BETWEEN 1998 AND 2008
    GROUP BY Observer
    ORDER BY COUNT(ageMethod) DESC
    LIMIT 1;
