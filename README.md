# Usage

1. Specify users

Edit `docker_build/users/users` to list all username/passwords you want on the system.
Should look like:
```
instructor thwizard
testuser1 testpass
testuser2 testpass
testuser3 testpass
testuser4 testpass
```

2. Build the docker image (You'll need to re-do this every time you add/remove a user)
```sh
docker-compose build
```

3. Deploy the container
```sh
docker-compose up -d
```
The `-d` detaches the container output logs from your terminal, and continuously runs the container as a daemon in the background.

## Course configuration
Most course configuration should go in `docker_build/jupyterhub_config/nbgrader_config.py`.
Might look something like this:
```
c = get_config()
c.CourseDirectory.course_id = "course"
c.CourseDirectory.root = f"/home/instructor/{c.CourseDirectory.course_id}"
c.Exchange.root = "/srv/nbgrader/exchange"
c.NbGrader.logfile = "/home/instructor/logfile.txt"
c.ClearSolutions.code_stub = {"python": "# Your code here\n"}
```

## Bringing down the container
When you want to *stop* the container, it can be done with
```
docker-compose down
```
It's probably best practice to do this before backing things up, lest they get modified
mid-backup.

# Managing once built
Most things will be easier to do within the container.
The configuration states that everything under `/home/` in the container
should be shared with the host (as `data/home`).

Hence, the only things that should need be backed up is the `data` directory
and the `docker_build/users/users` file on the host.


## Details about build time vs deploy time
### Build time
At build time:
- users are created
- file permissions are set
- config files are copied into `/srv/jupyterhub`

### Deploy time
At deploy time:
- configs are copied from `/srv/jupyterhub` to instructor home directory (`/home/instructor/.jupyterhub`), clobbering anything that might have been there.
- whatever was in the VM's `/home/` directory is clobbered by the host's
  `data/home`.
- user home directories are made if they don't already exist
- students are added to the nbgrader db if they don't already exist
