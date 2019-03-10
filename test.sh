set -e

rm -rf /usr/local/.devpkg

echo "Testing setup devpkg -S";
./devpkg -S

echo "Testing a regular tar.gz";
./devpkg -I http://mirror.its.uidaho.edu/pub/apache//apr/apr-1.4.5.tar.gz

echo "Testing a regular tar.bz2"
./devpkg -I http://mongrel2.org/static/downloads/mongrel2-1.7.5.tar.bz2

echo "Testing a regular .git"
./devpkg -I https://github.com/zedshaw/srpmin.git

echo "Test manually fetch/build if already installed"
./devpkg -F https://github.com/zedshaw/srpmin.git

./devpkg -B https://github.com/zedshaw/srpmin.git

echo "Test manually fetch/build it not installed"
./devpkg -F http://mirror.its.uidaho.edu/pub/apache//apr/apr-util-1.3.12.tar.gz

./devpkg -B http://mirror.its.uidaho.edu/pub/apache//apr/apr-util-1.3.12.tar.gz -c "--with-apr=/usr/local/apr"

echo "Test idempotent build test"
./devpkg -I http://mirror.its.uidaho.edu/pub/apache//apr/apr-util-1.3.12.tar.gz -c "--with-apr=/usr/local/apr"


echo "Test run the depends, nothing should build"
./devpkg -I ./DEPENDS

echo "list out what's installed"
./devpkg -L

