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
docker run -it -p 8080:8080 -v ~/Sites/ishanvyas22/djngo-react-graphql-spa:/app django-react-graphql-spa
```

**Login into docker container:**

```sh
docker exec -it <container_ID_or_name> /bin/bash
```

#### Open GraphiQL (Interactive GraphQL Playground):

Go to http://0.0.0.0:8080/graphql

## Reference

- https://dzone.com/articles/django-graphql-react-integration-tutorial-part-1
- https://dzone.com/articles/django-react-integration-with-graphql-part-2
