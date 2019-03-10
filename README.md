#Devpkg

This is a project from the book [Learn C The Hard Way](http://c.learncodethehardway.org)

The overall goal is to build a package manager with the following commands

`devpkg -S ` Sets up a new installation on a computer.
`devpkg -I [url | DEPENDS]` Installs a piece of software from a URL.
`devpkg -L ` Lists all of the software that's been installed.
`devpkg -F [url | DEPENDS]` Fetches some source code for manual building.
`devpkg -B ` Builds the source code and installs it, event if it's already installed.

## Recommended Usage
#### Use inside a docker container to test if devpkg works. 
It's not recomend to have multiple package managers managing installs for the whole machine. Things will break.


## Design (from the book)

+ __Use external commands__: most of the work will be done through external commands like curl, git and tar.
+ __Simple file database__: keep track of what is installed with a simple file database located at /usr/local/.devpack/db
+ __/usr/local__: Always as the target directory
+ __configure, make, make install__ assume that most software can be installed with these three commands.
+ __The user can be root__ It's assumed that the user can become root using sudo, but doesn't want to become root until the end.

## Spec

1. It relies entirely on the proliferation of standardized build systems
   like autotools, make, gems, and eggs.
2. It relies on the proliferation of easy public hosting of source code
   repositories and .tar.gz or .tar.bz2 files.  Basically you point it
   at a git repo or source tar and it'll figure it out.
3. There is no central repository of packages outside the author's control.
   Everything about how to build the packge resides in the project official
   repository.
4. Dependencies are tracked by URLs so no chance of name collisions and
   weird naming schemes.
5. There is no facility to add "off grid" patches to work around build
   or portability issues, instead, fork the author's repo and give them
   the patch.  If they don't accept it, then have people install the
   fork.


