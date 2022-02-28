<h3 align="center">Todo lists API</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)](https://github.com/marcelomaidden/todo_lists_api)
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/marcelomaidden/todo_lists_api/issues)
[![GitHub2 Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/marcelomaidden/todo_lists_api/pulls)

</div>
<p>
  Todo lists API is a backend project build with Ruby on Rails that allows users to create users, login using JWT token, creating tasks and add notes to the tasks.</p>
<p>
  After authenticating the user with e-mail and password, a JWT token is generated and this is used to authenticate the requests to all endpoints in the application.
</p>
<p>
  Users are only allowed to see their own tasks and notes, and their own profile information.
</p>

## Built With

- Ruby
- Ruby on Rails
- Json Web Token
- Rack CORS
- RSpec
- FactoryBot

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

- Text Editor (VSCode is suggested.)


### Setup

- Install [git](https://git-scm.com/downloads)
- Open Terminal
- Change directory to folder to download repository
- Use `cd <file-path>`
- Run `git clone https://github.com/marcelomaidden/todo_lists_api`
- Enter the project's folder `cd todo_lists_api`
- Run `rvm use 2.4.1` to change the ruby version
- Run `bundle install`

To make any change,

- Open related file by using text editor.

## Usage
  - Run `rails s` on your terminal to start your server

## CORS
  - This project allows by default the requests coming from the localhost
  - If you need to allow another origins, please change the file `config/initializers/cors` adding the origin in this line `origins 'localhost'`

## API Documentation

  - Api documentation available [here](index.html.md)
## Test
  - Run `rspec --format doc` to perform unit tests;

## Author

👤  **Marcelo Fernandes**

- GitHub: [@marcelomaidden](https://github.com/marcelomaidden)
- Twitter: [@marcelomaidden](https://twitter.com/marcelomaidden)
- LinkedIn: [Marcelo Fernandes](https://linkedin.com/in/marcelofernandesdearaujo)
## 🤝 Contributing

Contributions, issues and feature requests are welcome! Start by:

- Forking the project
- Cloning the project to your local machine
- `cd` into the project directory
- Run `git checkout -b your-branch-name`
- Make your contributions
- Push your branch up to your forked repository
- Open a Pull Request with a detailed description to the development branch of the original project for a review


## Show your support

Give a ⭐️ if you like this project!
