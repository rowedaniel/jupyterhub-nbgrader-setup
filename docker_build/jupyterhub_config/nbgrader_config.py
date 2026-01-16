c = get_config()
c.CourseDirectory.course_id = "course"
c.CourseDirectory.root = f"/home/instructor/{c.CourseDirectory.course_id}"
c.Exchange.root = "/srv/nbgrader/exchange"
c.NbGrader.logfile = "/home/instructor/logfile.txt"
c.ClearSolutions.code_stub = {"python": "# Your code here\n"}
