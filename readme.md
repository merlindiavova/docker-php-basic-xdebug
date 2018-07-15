# PHP Basic (with Xdebug)

A basic PHP cli image (currently `php:7.2-cli-stretch`) with git composer, zip and Xdebug.

This image is best used as your base PHP installation. Perfect if you do not want to install PHP and other dependencies on your system.

## Usage
---
To run commands against this image, you can do the following:

```bash
cd ~/path/to/code
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    {command here}
```

_Feel free to replace `$(pwd)` with an absolute file path, if it does not expand to the correct working directory._

Run a [Composer](https://getcomposer.org/) command
```bash
cd ~/path/to/code
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    -v ~/.composer:/.composer \
    merlindiavova/docker-php-basic-xdebug:latest \
    composer --ansi require phpunit/phpunit ^7
```

Run a phpunit ([PHPUnit](https://github.com/sebastianbergmann/phpunit)) command
```bash
cd ~/path/to/code/myapp
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    phpunit --filter SomeClassNameOrFilter
```

Run a phpcs ([PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)) command
```bash
cd ~/path/to/code/myapp
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    phpcs --report=summary
```

Run the covers validator ([covers validator](https://github.com/oradwell/covers-validator)) command
```bash
cd ~/path/to/code/myapp
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    covers
```

Run a phpstan ([PHP Static Analysis Tool](https://github.com/phpstan/phpstan)) command
```bash
cd ~/path/to/code/myapp
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    phpstan
```

## Making it all easier
---
I recommend creating aliases for PHP and Composer.

```bash
# Please note the single quotes (' '). 
# If you use double quotes (" ") $(pwd) will not expand.

alias php='docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    php'
```

Now you can run PHP commands by typing ```php {command}```

```bash
# Please note the single quotes (' '). 
# If you use double quotes (" ") $(pwd) will not expand.

alias composer='docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    -v ~/.composer:/.composer \
    merlindiavova/docker-php-basic-xdebug:latest \
    composer --ansi'
```

Now you can run composer commands by typing ```composer {command}```

### Helper aliases
---
| Command (alias) | Expands to
| ------------- | -------------
| covers | `./vendor/bin/covers-validator`
| phpcs | `./vendor/bin/phpcs -p -s` _(assumes you have a phpcs.xml config file)_
| phpstan | `./vendor/bin/phpstan`
| phpunit | `./vendor/bin/phpunit`
| stan | `./vendor/bin/phpstan analyse --level=1 --no-progress src/ tests/`
| cs | `phpcs && stan`
| tests | `covers && phpunit`
| ci | `tests && cs`

To use any of the helpers aliases above, you can run the following:
```bash
cd ~/path/to/code/myapp
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    --user $(id -u):$(id -g) \
    merlindiavova/docker-php-basic-xdebug:latest \
    {alias here}
```