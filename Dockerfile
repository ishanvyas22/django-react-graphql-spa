# Tells Docker to use the official python 3 image from dockerhub as a base image
FROM python:3.9

# Sets an environmental variable that ensures output from python is sent straight to the terminal without buffering it first
ENV PYTHONUNBUFFERED 1

# change default shell for subsequent RUN to bash
SHELL ["/bin/bash", "-c"]

# Mounts the application code to the image
COPY . app
WORKDIR /app

# Create a non-root user named "bheem"
RUN groupadd --gid 5000 bheem \
    && useradd --home-dir /home/bheem --create-home --uid 5000 \
    --gid 5000 --shell /bin/sh --skel /dev/null bheem

RUN chown -R bheem /app

# Change user to newly created user
USER bheem

ENV PATH="/home/bheem/.local/bin:${PATH}"

# create python virtual environment name django-spa-demo-venv
RUN cd ~/
RUN mkdir venv
RUN python -m venv ~/venv/django-spa-demo-venv
# activate it
RUN source ~/venv/django-spa-demo-venv/bin/activate

# Allows docker to cache installed dependencies between builds
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8080"]
