#! /bin/bash

for schema in $(gsettings list-schemas | sort)
do
    for key in $(gsettings list-keys $schema | sort)
    do
        value="$(gsettings range $schema $key | tr "\n" " ")"
        echo "$schema :: $key :: $value"
    done
done
