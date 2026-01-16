FROM quay.io/jupyterhub/jupyterhub:5.4.3

RUN pip install jupyter jupyter-server nbgrader nbconvert
RUN pip install numpy sympy scipy scikit-learn meclib pint pandas matplotlib plotly

# Copy global jupyterhub configs to working directory (/srv/jupyterhub)
COPY jupyterhub_config/jupyterhub_config.py .
COPY jupyterhub_config/course_name .
COPY jupyterhub_config/nbgrader_config.py /etc/jupyter/nbgrader_config.py

# set up nbgrader
RUN mkdir -p /srv/nbgrader/exchange
RUN chmod 777 /srv/nbgrader
RUN chmod 777 /srv/nbgrader/exchange

# Configure users
COPY users users
COPY create_users.sh .
RUN chmod +x create_users.sh
RUN ./create_users.sh
RUN rm -rf users

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
