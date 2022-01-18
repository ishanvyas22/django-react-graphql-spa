# Tells Docker to use the official python 3 image from dockerhub as a base image
FROM python:3.9

# Set env variables
# ensures output from python is sent straight to the terminal without buffering it first
ENV PYTHONUNBUFFERED 1
ENV USER_NAME "bheem"
ENV NODE_VERSION 16.13.2
ENV NVM_DIR "/home/${USER_NAME}/.nvm"

# change default shell for subsequent RUN to bash
SHELL ["/bin/bash", "-c"]

# Mounts the application code to the image
COPY . app
WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    # build-essential, libssl-dev are needed for nvm (see: https://github.com/nvm-sh/nvm#important-notes)
    build-essential \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user named "bheem"
RUN groupadd --gid 5000 bheem \
    && useradd --home-dir /home/bheem --create-home --uid 5000 \
    --gid 5000 --shell /bin/sh --skel /dev/null bheem

RUN chown -R bheem /app

# Change user to newly created user
USER ${USER_NAME}

ENV PATH="/home/${USER_NAME}/.local/bin:${PATH}"

# create python virtual environment name django-spa-demo-venv
RUN cd ~/
RUN mkdir venv
RUN python -m venv ~/venv/django-spa-demo-venv
# activate it
RUN source ~/venv/django-spa-demo-venv/bin/activate

# Allows docker to cache installed dependencies between builds
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install node - required for front-end react app
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm use node

EXPOSE 8080

ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8080"]
