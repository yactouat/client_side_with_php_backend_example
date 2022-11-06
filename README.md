# Simple MVC

## Description

This repository is a simple PHP MVC structure from scratch implementing a cruddable `Item` resource.

## Steps

1. Clone the repo from Github.
2. Run `composer install`.
3. Create _config/db.php_ from _config/db.docker.php_ file and add your DB parameters.

    ```php
    define('APP_DB_HOST', 'your_db_host');
    define('APP_DB_NAME', 'your_db_name');
    define('APP_DB_USER', 'your_db_user_wich_is_not_root');
    define('APP_DB_PASSWORD', 'your_db_password');
    ```

4. `docker compose up`
5. Go to `localhost` with your favorite browser.

## Example

An example (a basic list of items) is provided. The accessible URLs are :

- Home page at [localhost/](localhost/)
- Items list at [localhost/items](localhost/items)
- Item details [localhost/items/show?id=:id](localhost/item/show?id=2)
- Item edit [localhost/items/edit?id=:id](localhost/items/edit?id=2)
- Item add [localhost/items/add](localhost/items/add)
- Item deletion [localhost/items/delete?id=:id](localhost/items/delete?id=2)

You can find all these routes declared in the file `src/routes.php`. This is the very same file where you'll add your own new routes to the application.