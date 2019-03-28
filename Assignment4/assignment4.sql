

1.) EXPLAIN SELECT student_name FROM student 
            WHERE roll_no in
                (SELECT c.roll_no from CourseStudent as c 
                    WHERE c.course_id = 1
                    AND c.marks > 
                        (SELECT AVG(s.marks) FROM CourseStudent as s WHERE s.course_id=3));

    CREATE INDEX index1 ON CourseStudent(marks);

    EXPLAIN SELECT student_name FROM student 
            WHERE roll_no in
                (SELECT c.roll_no from CourseStudent as c 
                    WHERE c.course_id = 1
                    AND c.marks > 
                        (SELECT AVG(s.marks) FROM CourseStudent as s WHERE s.course_id=3));

    DROP INDEX index1 ON CourseStudent;
    CREATE INDEX index2 ON CourseStudent(course_id);
    DROP INDEX index2 ON CourseStudent;

2.) CREATE VIEW v AS SELECT course_name,roll_no FROM course JOIN CourseStudent USING (course_id) ;
    SELECT course_name FROM v WHERE roll_no=160101059;

3.) DELIMITER //
    CREATE TRIGGER insert_marks BEFORE INSERT ON CourseStudent FOR EACH ROW
    BEGIN 
    IF NEW.marks < 0 THEN SET NEW.marks=0;
    END IF;
    IF NEW.marks > 100 THEN SET NEW.marks = 100;
    END IF;
    END //

4.) ALTER TABLE CourseStudent ADD COLUMN attendance INT ;
    UPDATE CourseStudent SET attendance = 10 WHERE course_id = 1 AND roll_no = 160101059;

5.)     SELECT student_name FROM student AS s
        WHERE NOT EXISTS (
            (SELECT c.course_id FROM CourseStudent as c WHERE c.roll_no = 160101059
                AND c.course_id NOT IN 
                    (SELECT p.course_id FROM CourseStudent as p WHERE p.roll_no = s.roll_no)) );
        
        CREATE INDEX index_roll_no ON student(roll_no);
        CREATE INDEX index_course ON CourseStudent(course_id);

6.) UPDATE student as s SET fname = SUBSTRING(student_name,1,5);
    CREATE INDEX index_fname ON student(fname);

    SELECT * FROM (
        SELECT student_name,fname FROM student AS s
        WHERE NOT EXISTS (
            (SELECT c.course_id FROM CourseStudent as c WHERE c.roll_no = 160101059
                AND c.course_id NOT IN 
                    (SELECT p.course_id FROM CourseStudent as p WHERE p.roll_no = s.roll_no)))) as g
    WHERE  g.fname = (SELECT f.fname from student as f where f.roll_no=160101059)      ;         

7.) CREATE VIEW v2 as
    SELECT * FROM (
        SELECT "F" AS grade , course_id,roll_no FROM CourseStudent WHERE marks <40
     UNION     
     SELECT "B" AS grade , course_id,roll_no FROM CourseStudent WHERE marks >=40 and marks <70
     UNION
     SELECT "A" AS grade , course_id,roll_no FROM CourseStudent WHERE marks >=70
    )    as g;

    SELECT * FROM v2 WHERE roll_no =160101059;

8.) CREATE VIEW v2 as SELECT roll_no,grade from CourseStudent;


9.) 
     DELIMITER //
    CREATE TRIGGER grade_trigger BEFORE INSERT ON CourseStudent FOR EACH ROW
    BEGIN 
    IF NEW.marks < 40 THEN SET NEW.grade = "F";
    ELSEIF NEW.marks >=40 and NEW.marks <70 THEN SET NEW.grade = "B";
    ELSE SET NEW.grade = "A";
    END IF;
    END //
    DELIMITER ;