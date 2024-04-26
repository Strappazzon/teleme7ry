# GitHub Pages

The **docs** folder contains an HTML version of [README.md](https://github.com/Strappazzon/teleme7ry#readme).

If you are looking for *Teleme7ry* source code, please see the ["src" folder](https://github.com/Strappazzon/teleme7ry/tree/master/src).

## Getting Started

### Dependencies

The Teleme7ry website is built with [Jekyll](https://jekyllrb.com/) so you will need [Ruby](https://www.ruby-lang.org) installed.  
I recommend you install it using [rbenv](https://github.com/rbenv/rbenv), [asdf](https://github.com/asdf-vm/asdf), [frum](https://github.com/TaKO8Ki/frum)
or other packaging system, before attempting to install the dependencies.

Clone the repo and run `bundle install` to install the required dependencies.

```sh
git clone https://github.com/Strappazzon/teleme7ry.git teleme7ry
cd docs/
bundle install
```

### Local Previews

To view your changes locally use the following command:

```sh
bundle exec jekyll serve --force_polling --livereload
```

Then navigate to <http://localhost:4000/teleme7ry/> in your web browser.

Press <kbd>CTRL</kbd>+<kbd>C</kbd> to stop the web server.

## Credits & Licensing

The website code is open source under the terms of the [MIT License](https://github.com/Strappazzon/teleme7ry/blob/-/LICENSE.txt).

[Bootstrap Grid](https://getbootstrap.com/docs/5.3/layout/grid/) by The Bootstrap Authors ([MIT License](https://github.com/twbs/bootstrap/blob/main/LICENSE)).

[Gardevoir](https://github.com/xkrishguptaa/reseter.css) CSS Reset by Krish Gupta ([MIT License](https://github.com/xkrishguptaa/reseter.css/blob/main/LICENSE)).

Logo from [Icons8](https://icons8.com/).
