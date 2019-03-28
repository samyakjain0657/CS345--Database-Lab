


a)SELECT  student_name FROM student,course,CourseStudent WHERE student.roll_no = CourseStudent.roll_no AND CourseStudent.course_id = course.course_id AND course.course_name="CS 101";
b)SELECT student_name from student,CourseStudent, lecturer,CourseLecturer WHERE lecturer.lect_id=CourseLecturer.lect_id AND CourseLecturer.course_id =CourseStudent.course_id AND CourseStudent.roll_no = student.roll_no AND lect_name="Diganta Goswami";
c)SELECT  course_name from student,CourseStudent,course WHERE student.dept_id!=course.dept_id  AND CourseStudent.roll_no = student.roll_no AND course.course_id = CourseStudent.course_id AND student.student_name="Samyak Jain";

e) DELETE FROM course WHERE course_name="CS 101";


f)SELECT  course_name FROM student,course,CourseStudent WHERE student.roll_no = CourseStudent.roll_no AND CourseStudent.course_id = course.course_id AND student.roll_no = "160101059";
g) SELECT student_name,course_name FROM student,course,CourseStudent WHERE CourseStudent.roll_no = "160101059" AND CourseStudent.course_id = course.course_id;
h)SELECT course_name FROM department,course,student,CourseStudent WHERE department.name="CSE" AND department.dept_id!=student.dept_id AND department.dept_id = course.dept_id AND course.course_id = CourseStudent.course_id AND CourseStudent.roll_no = student.roll_no;
i) SELECT student_name FROM student,CourseStudent,course WHERE student.roll_no = CourseStudent.roll_no AND CourseStudent.marks>40 AND CourseStudent.marks<90 AND CourseStudent.course_id=course.course_id AND course_name="CS 101";
j)INSERT INTO CourseLecturer VALUES (5,2,1);
