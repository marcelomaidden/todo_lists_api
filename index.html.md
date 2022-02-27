---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

includes:
  - errors

search: true
---

# Introduction

Welcome to the Todos List API documentation. This is a step by step guide which shows how to use the API using the command line.

# Authentication

> In order to obtain the access token

```shell
curl http://localhost:3000/api/v1/login \
  -X POST \
  -H 'Content-Type: application/json' \
  -d '{
    "user": {  
      "email": "marcelomaidden@gmail.com",
      "password": "123456"
    }
  }'
```

> The return value if the credentials are valid is:

```json
{
  "token": "ACCESS_TOKEN"
}
```

Use this token as `Authorization: Bearer ACCESS_TOKEN` to authenticate all the api requests

### HTTP Request

`POST http://localhost:3000/api/v1/login`

### Query Parameters

Parameter | Type | Required | Description
--------- | ----- |  ------- | -----------
user[email] | string | Required | User e-mail.
user[password] | string | Required | User password.

<aside class="notice">
 Remeber to change <code>ACCESS_TOKEN</code> for the access token returned on the login endpoint.
</aside>

# Users

## Create

```shell
curl "http://localhost:3000/api/v1/users" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN" \
  -d '{
    "user": {  
      "email": "marcelomaidden@gmail.com",
      "password": "123456"
    }
  }'
```

> Endpoint return:

```json
{
  "token": "ACCESS_TOKEN"
}
```

This endpoint creates a user.

### HTTP Request

`POST http://localhost:3000/api/v1/users`

# Tasks

## Create

```shell
curl "http://localhost:3000/api/v1/tasks" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN" \
  -d '{
    "task": {
      "title": "Task title",
      "status": "completed"
    }
  }'
```

> Endpoint return:

```json
{
  "task": {
    "id": 23,
    "title": "First task title",
    "status": "completed"
  },
}
```

This endpoint creates a task for the authenticated user.

### HTTP Request

`POST http://localhost:3000/api/v1/tasks`

## Update

```shell
curl "http://localhost:3000/api/v1/tasks/23" \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN" \
  -d '{
    "task": {
      "title": "Task title",
      "status": "completed"
    }
  }'
```

> Endpoint return:

```json
{
  "task": {
    "id": 23,
    "title": "Changes task title",
    "status": "completed"
  },
}
```

This endpoint updates a task for the authenticated user.

### HTTP Request

`PUT http://localhost:3000/api/v1/tasks/23`

## Delete

```shell
curl "http://localhost:3000/api/v1/tasks/23" \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "message": "Task deleted"
}
```

This endpoint deletes a task from the authenticated user.

### HTTP Request

`DELETE http://localhost:3000/api/v1/tasks/23`

## List

```shell
curl "http://localhost:3000/api/v1/tasks"
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "tasks": [
    {
      "id": 23,
      "title": "First task title",
      "status": "completed"
    },
    {
      "id": 24,
      "title": "Second task title",
      "status": "uncompleted"
    },
  ],
}
```

This endpoint returns all tasks for the authenticated user.

### HTTP Request

`GET http://localhost:3000/api/v1/tasks`

## Completed tasks

```shell
curl "http://localhost:3000/api/v1/tasks/completed"
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "tasks": [
    {
      "id": 23,
      "title": "First task title",
      "status": "completed"
    },
    {
      "id": 25,
      "title": "Second task title",
      "status": "completed"
    },
  ],
}
```

This endpoint returns all completed tasks from the authenticated user.

### HTTP Request

`GET http://localhost:3000/api/v1/tasks/completed`

## Not completed tasks

```shell
curl "http://localhost:3000/api/v1/tasks/uncompleted"
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "tasks": [
    {
      "id": 26,
      "title": "First task title",
      "status": "uncompleted"
    },
    {
      "id": 28,
      "title": "Second task title",
      "status": "uncompleted"
    },
  ],
}
```

This endpoint returns all not completed tasks from the authenticated user.

### HTTP Request

`GET http://localhost:3000/api/v1/tasks/completed`

## Show

```shell
curl "http://localhost:3000/api/v1/tasks/23"
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "task": {
    "id": 23,
    "title": "First task title",
    "status": "completed"
  },
}
```

This endpoint details a task.

### HTTP Request

`GET http://localhost:3000/api/v1/tasks/23`


# Task notes

## Create

```shell
curl "http://localhost:3000/api/v1/tasks/23/notes" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN" \
  -d '{
    "note": {
      "description": "Note description"
    }
  }'
```

> Endpoint return:

```json
{
  "note": {
    "id": 1,
    "title": "Note description"
  },
}
```

This endpoint creates a task note for the authenticated user.

### HTTP Request

`POST http://localhost:3000/api/v1/tasks/23/notes`

## Update

```shell
curl "http://localhost:3000/api/v1/notes/1" \
  -X PUT \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN" \
  -d '{
    "note": {
      "description": "Note description"
    }
  }'
```

> Endpoint return:

```json
{
  "task": {
    "id": 1,
    "title": "Changes note description"
  },
}
```

This endpoint updates a task note for the authenticated user.

### HTTP Request

`PUT http://localhost:3000/api/v1/notes/1`

## List

```shell
curl "http://localhost:3000/api/v1/tasks/23/notes"
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "notes": [
      {
        "id": 1,
        "description": "changes the description"
      },
      {
        "id": 2,
        "description": "second note"
      },
    ]
}
```

This endpoint returns all task notes from the current task.

### HTTP Request

`GET http://localhost:3000/api/v1/tasks/23/notes`

## Show

```shell
curl "http://localhost:3000/api/v1/notes/1"
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ACCESS_TOKEN"
```

> Endpoint return:

```json
{
  "note": {
    "id": 1,
    "description": "note description"
  },
}
```

This endpoint details a note.

### HTTP Request

`GET http://localhost:3000/api/v1/notes/1`
