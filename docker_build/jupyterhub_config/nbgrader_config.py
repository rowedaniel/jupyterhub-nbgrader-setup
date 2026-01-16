c = get_config()

# read the course name from file to keep things consistent
c.CourseDirectory.course_id = open("/srv/jupyterhub/course_name").read()

# Set the root course directory. Note that this directory is created by entrypoint.sh,
# so if you change it here it'll have to be changed there too.
c.CourseDirectory.root = f"/home/instructor/{c.CourseDirectory.course_id}"
c.Exchange.root = "/srv/nbgrader/exchange"
c.NbGrader.logfile = "/home/instructor/logfile.txt"
c.ClearSolutions.code_stub = {"python": "# Your code here\n"}
