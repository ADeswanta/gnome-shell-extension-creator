#!/bin/bash

echo GNOME Shell Extension Creator
echo by: ADeswanta
echo
echo Type your extension name:
read ext_name
echo

ext_name_uuid=${ext_name// /_}
ext_name_uuid=${ext_name_uuid,,}

function name_notfound {
  echo it\'s blank, try again
  read -p "" ext_name
  echo
  if [ -z $ext_name ]; then
    name_notfound
  else
    continue
  fi
}

if [ -z $ext_name ]
then
  name_notfound
fi

echo Type your extension description:
read ext_desc
echo
echo Type your extension UUID:
read -p "$ext_name_uuid@" ext_uuid
echo

function uuid_notfound {
  echo it\'s blank, try again
  read -p "$ext_name@" ext_uuid
  echo
  if [ -z $ext_uuid ]; then
    uuid_notfound
  else
    continue
  fi
}
if [ -z $ext_uuid ]
then
  uuid_notfound
fi

echo Type your extension version \(must be integer not double\):
read ext_ver
echo

function have_double {
  echo must be integer not double, try again
  read ext_ver
  echo
  CHAR_STOP='.'
  if [[ $ext_ver == *$CHAR_STOP* ]]; then
    have_double
  else
    continue
    if [ -z $ext_ver ]; then
      ver_notfound
    fi
  fi
}

function ver_notfound {
  echo it\'s blank, try again
  read ext_ver
  echo
  if [ -z $ext_ver ]; then
    ver_notfound
  else
    continue
    CHAR_STOP='.'
    if [[ $ext_ver == *$CHAR_STOP* ]]; then
      have_double
    fi
  fi
}

if [ -z $ext_ver ]; then
  ver_notfound
fi
CHAR_STOP='.'
if [[ $ext_ver == *$CHAR_STOP* ]]; then
  have_double
fi

ext_uuid=$ext_name@$ext_uuid

echo Collecting information...
echo
echo ============================================================
echo Extension information
echo ============================================================
echo Name : $ext_name
echo Description : $ext_desc
echo UUID : $ext_uuid
echo Version : $ext_ver
echo ============================================================
echo

function create_dir {
  mkdir $HOME/.local/share/gnome-shell/extensions/$ext_uuid
}

function create_metadata {
  if [ -z $ext_desc ]; then
    ext_desc="The $ext_name Extension"
  fi
  ext_DIR_meta=$HOME/.local/share/gnome-shell/extensions/$ext_uuid/metadata.json
  VER=$(gnome-shell --version | cut -d" " -f3-)
  echo "{" > $ext_DIR_meta
  echo "  \"_generated\": \"Generated by GNOME Shell Extension Creator by ADeswanta\"," >> $ext_DIR_meta
  echo "  \"name\": \"$ext_name\"," >> $ext_DIR_meta
  echo "  \"description\": \"$ext_desc\"," >> $ext_DIR_meta
  echo "  \"uuid\": \"$ext_uuid\"," >> $ext_DIR_meta
  echo "  \"shell-version\": [" >> $ext_DIR_meta
  echo "    \"$VER\"" >> $ext_DIR_meta
  echo "  ]," >> $ext_DIR_meta
  echo "  \"version\": $ext_ver" >> $ext_DIR_meta
  echo "}" >> $ext_DIR_meta
}

function create_extension {
  ext_DIR_extension=$HOME/.local/share/gnome-shell/extensions/$ext_uuid/extension.js
  echo "// Generated by GNOME Shell Extension Creator by ADeswanta" > $ext_DIR_extension
  echo "" >> $ext_DIR_extension
  echo "function init() {" >> $ext_DIR_extension
  echo "  " >> $ext_DIR_extension
  echo "}" >> $ext_DIR_extension
  echo "" >> $ext_DIR_extension
  echo "function enable() {" >> $ext_DIR_extension
  echo "  " >> $ext_DIR_extension
  echo "}" >> $ext_DIR_extension
  echo "" >> $ext_DIR_extension
  echo "function disable() {" >> $ext_DIR_extension
  echo "  " >> $ext_DIR_extension
  echo "}" >> $ext_DIR_extension
}

function create_stylesheet {
  ext_DIR_style=$HOME/.local/share/gnome-shell/extensions/$ext_uuid/stylesheet.css
  echo "/* Generated by GNOME Shell Extension Creator by ADeswanta */" > $ext_DIR_style
  echo "" >> $ext_DIR_style
}

echo Creating directory...
create_dir
echo
echo Creating metadata.json...
create_metadata
echo
echo Creating extension.js...
create_extension
echo
echo Creating stylesheet.css...
create_stylesheet
echo
echo Installing...
echo
echo Your extension is created!
echo
askopen=yes
while true; do
  read -p "Do you want to open your extension file(y/n)?" yn
  case $yn in
    [Yy]* ) nautilus $HOME/.local/share/gnome-shell/extensions/$ext_uuid; askopen=no; break;;
    [Nn]* ) continue; askopen=no ; break;;
    * ) echo "Wrong prompt. ignoring..."; askopen=no; break;;
  esac
done
echo
echo Restart GNOME Shell to apply changes.
echo Have fun!
echo
