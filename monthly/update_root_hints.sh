#!/bin/sh

cd /tmp

wget -O root.hints.new https://www.internic.net/domain/named.root

md5Old=$(md5sum /var/lib/unbound/root.hints | cut -d ' ' -f 1)
md5New=$(md5sum root.hints.new | cut -d ' ' -f 1)

echo Existing root.hints: $md5Old
echo New root.hints: $md5New

if [ "$md5New" != "$md5Old" ]
then

        echo Files are different
        mv root.hints.new /var/lib/unbound/root.hints
        systemctl restart unbound
else
echo Files are the same - Exiting
fi
