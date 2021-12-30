# Django + React + GraphQL demo application

A demo application to play with Django as a back-end, React as front-end communicating through a GraphQL API.

## Requirements

- Python >= 3.9
- pip >= 21.3
- Docker along with docker-compose

## Development

#### Build docker container

```sh
docker build -t django-react-graphql-spa .
```

#### Run docker container

```sh
docker run -it -p 8080:8080 django-react-graphql-spa
```
