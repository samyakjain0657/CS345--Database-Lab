

1.)    SELECT student_name from student WHERE roll_no in
        (SELECT roll_no from CourseStudent WHERE course_id!=
            ALL (SELECT course_id from CourseStudent WHERE roll_no="160101059"));

2.) SELECT student_name FROM student AS s
        WHERE NOT EXISTS (
            (SELECT c.course_id FROM CourseStudent as c WHERE c.roll_no = 160101076
                AND c.course_id NOT IN 
                    (SELECT p.course_id FROM CourseStudent as p WHERE p.roll_no = s.roll_no)) );


3.) SELECT student_name FROM student WHERE roll_no in
        (SELECT roll_no FROM CourseStudent WHERE course_id in
            (SELECT course_id FROM CourseLecturer WHERE lect_id=3 OR lect_id=2));

4.)  SELECT student_name FROM student WHERE (roll_no in
        (SELECT roll_no FROM CourseStudent JOIN CourseLecturer USING (course_id) WHERE lect_id=5 )
        AND roll_no NOT IN
        (SELECT roll_no FROM CourseStudent JOIN CourseLecturer USING (course_id) WHERE lect_id=1 ))
        OR 
        (roll_no in
        (SELECT roll_no FROM CourseStudent JOIN CourseLecturer USING (course_id) WHERE lect_id=1 )
        AND roll_no NOT IN
        (SELECT roll_no FROM CourseStudent JOIN CourseLecturer USING (course_id) WHERE lect_id=5 ));

5.) SELECT student_name FROM student 
        WHERE roll_no in
            (SELECT c.roll_no from CourseStudent as c 
                WHERE c.course_id = 1
                AND c.marks > 
                    (SELECT AVG(s.marks) FROM CourseStudent as s WHERE s.course_id=3));

6.) SELECT name,COUNT(dept_id) as count FROM lecturer JOIN department USING (dept_id)     
        GROUP BY dept_id;         

7.) SELECT roll_no FROM student WHERE roll_no NOT IN
        (SELECT roll_no from CourseStudent JOIN CourseLecturer USING (course_id) WHERE lect_id=1);         

8.) SELECT course_name,AVG(marks),dept_id FROM CourseStudent JOIN course USING (course_id) JOIN department USING (dept_id)
        GROUP BY course_id,dept_id;       

9.) SELECT x1.dept_id,x1.course_name FROM (SELECT MAX(avg) as marks,dept_id FROM (
        SELECT dept_id,AVG(marks) as avg,course_name FROM CourseStudent JOIN course USING (course_id) GROUP BY course_id ) as c
            GROUP BY dept_id ) as x
        JOIN ( SELECT dept_id,AVG(marks) as marks,course_name  FROM CourseStudent JOIN course USING (course_id) GROUP BY course_id ) as x1 
        ON x1.dept_id = x.dept_id AND x.marks = x1.marks;         

10.) SELECT "F" AS grade , count(marks) FROM CourseStudent WHERE course_id = 1 and marks <40
     UNION     
     SELECT "B" AS grade , count(marks) FROM CourseStudent WHERE course_id = 1 and marks >=40 and marks <70
     UNION
     SELECT "A" AS grade , count(marks) FROM CourseStudent WHERE course_id = 1 and marks >=70;