-- create table
CREATE TABLE survey (
    answer_id SERIAL PRIMARY KEY,
	question_1 INT,
    question_2 INT,
	question_3 INT, 
	question_4 INT, 
	question_5 INT, 
	question_6 INT, 
	question_7 INT, 
	question_8 INT
);

-- change  question_3 to varchar
ALTER TABLE survey
ALTER COLUMN question_3 TYPE varchar(1);

-- 
SELECT * FROM survey
WHERE question_1 = ' ';

SELECT * FROM survey
GROUP BY answer_id
ORDER BY answer_id ASC;

-- Insert value to answer_id
INSERT INTO survey (answer_id)
SELECT generate_series(1, 300);

-- Assign random 3,4,5 to question 1
UPDATE survey
SET question_1 = CASE 
    WHEN RANDOM() < 0.3333 THEN 3
    WHEN RANDOM() < 0.6666 THEN 4
    ELSE 5
END;

-- Assign random 2 or 3 to question 2
UPDATE survey
SET question_2 = CASE 
    WHEN RANDOM() < 0.5 THEN 2
    WHEN RANDOM() < 0.5 THEN 3
END;

-- Assign 'Y' for YES to question 3
UPDATE survey
SET question_3 = 'Y';

-- Assign random 4 or 5 to question 4
UPDATE survey
SET question_4 = CASE 
    WHEN RANDOM() < 0.5 THEN 4
    WHEN RANDOM() < 0.5 THEN 5
END;

-- Assign random 4 or 5 to question 5
UPDATE survey
SET question_5 = CASE 
    WHEN RANDOM() < 0.5 THEN 4
    WHEN RANDOM() < 0.5 THEN 5
END;

-- Assign random 2,3 or 4 to question 6
UPDATE survey
SET question_6 = CASE 
    WHEN RANDOM() < 0.3333 THEN 2
    WHEN RANDOM() < 0.6666 THEN 3
    ELSE 4
END;

-- Assign random 3,4,or 5 to question 7
UPDATE survey
SET question_7 = CASE 
    WHEN RANDOM() < 0.3333 THEN 3
    WHEN RANDOM() < 0.6666 THEN 4
    ELSE 5
END;

-- Assign random 1,2,3 to question 8
UPDATE survey
SET question_8 = CASE 
    WHEN RANDOM() < 0.3333 THEN 1
    WHEN RANDOM() < 0.6666 THEN 2
    ELSE 3
END;


-- ### Survey Analysis
-- Count result question_1
SELECT
  question_1,
  COUNT(*) AS count_question_1
FROM survey
GROUP BY question_1;

-- Count result question_2
SELECT
  question_2,
  COUNT(*) AS count_question_2
FROM survey
GROUP BY question_2;

---- Count result question_3
SELECT
  question_3,
  COUNT(*) AS count_question_3
FROM survey
GROUP BY question_3;

-- Count result question_4
SELECT
  question_4,
  COUNT(*) AS count_question_4
FROM survey
GROUP BY question_4;

-- Count result question_5
SELECT
  question_5,
  COUNT(*) AS count_question_5
FROM survey
GROUP BY question_5;

-- Count result question_6
SELECT
  question_6,
  COUNT(*) AS count_question_6
FROM survey
GROUP BY question_6;

-- Count result question_7
SELECT
  question_7,
  COUNT(*) AS count_question_7
FROM survey
GROUP BY question_7;

-- Count result question_8
SELECT
  question_8,
  COUNT(*) AS count_question_8
FROM survey
GROUP BY question_8;

--
SELECT
  COUNT(CASE WHEN question_1 = '3' THEN 1 END) AS count_question_1_3,
  COUNT(CASE WHEN question_1 = '4' THEN 1 END) AS count_question_1_4,
  COUNT(CASE WHEN question_1 = '5' THEN 1 END) AS count_question_1_5,
  COUNT(CASE WHEN question_2 = '3' THEN 1 END) AS count_question_2_3,
  COUNT(CASE WHEN question_2 = '2' THEN 1 END) AS count_question_2_2,
  COUNT(CASE WHEN question_3 = 'Y' THEN 1 END) AS count_question_3_Y,
  COUNT(CASE WHEN question_4 = '5' THEN 1 END) AS count_question_4_5,
  COUNT(CASE WHEN question_4 = '4' THEN 1 END) AS count_question_4_4,
  COUNT(CASE WHEN question_5 = '4' THEN 1 END) AS count_question_5_4,
  COUNT(CASE WHEN question_5 = '5' THEN 1 END) AS count_question_5_5,
  COUNT(CASE WHEN question_6 = '2' THEN 1 END) AS count_question_6_2,
  COUNT(CASE WHEN question_6 = '3' THEN 1 END) AS count_question_6_3,
  COUNT(CASE WHEN question_6 = '4' THEN 1 END) AS count_question_6_4,
  COUNT(CASE WHEN question_7 = '3' THEN 1 END) AS count_question_7_3,
  COUNT(CASE WHEN question_7 = '5' THEN 1 END) AS count_question_7_5,
  COUNT(CASE WHEN question_7 = '4' THEN 1 END) AS count_question_7_4,
  COUNT(CASE WHEN question_8 = '1' THEN 1 END) AS count_question_8_1,
  COUNT(CASE WHEN question_8 = '2' THEN 1 END) AS count_question_8_2,
  COUNT(CASE WHEN question_8 = '3' THEN 1 END) AS count_question_8_3
FROM
  survey;
  

