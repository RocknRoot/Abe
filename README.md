# Abe

Charge Abe, discharge your brain, go party.

* Public install : http://abe.rocknroot.org
* Homepage : http://rocknroot.org/content/abe
* Version : alpha - 0.2-Connelly

Abe (Amazing Brain Expansion) is kind of a personnal encyclopedia where you can throw notes and
definitions and maybe organize them later.

You can also share some with friends, make them public and other social stuff.

Code is free, so if you're paranoid, you can install it at home or in that little private internet
of yours. Or just participate to the development. Fork us !

## Requirements

Tested with Ruby :

* 1.9.2
* 1.9.3

## Installation

We asume that you already have a web server capable of running Ruby on Rails applications (keywords
: Apache, nginx, mod_passenger, ...).

    $ git clone git://github.com/Nekith/Abe.git abe
    $ cd abe
    - edit config/database.yml with coherent data
    # bundle install (execute this with root privileges)
    $ bundle exec rake db:create RAILS_ENV=production
    $ bundle exec rake db:migrate RAILS_ENV=production
    $ bundle exec rake assets:precompile RAILS_ENV=production
    - restart web server (apachectl restart, ...)

### Troubleshooting

If you have a problem during mysql2 gem installation (On Debian/Ubuntu) :

    sudo apt-get install libmysqlclient-dev

## Need help ?

Add an issue on github ! ;)

## Versions

* 0.3-Reilly : under-development

    Available on master branch. Generally, it's the public install version.

* 0.2-Connelly : alpha

    Search box, Google Prettifier, public mode, user profile view, comments.

* 0.1-Wilde : deprecated

    Abe functional base, users, categories, notepad-terms, tags assignment, tinyMCE.

## Licence

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
       Version 2, December 2004

Copyright (C) 2012 Valerian Cubero <nekith@rocknroot.org>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO.
