#!/usr/bin/env bash

# Source: https://gist.github.com/planbnet/1422472

dir=$(dirname $0)
gconfdir=/apps/gnome-terminal/profiles

echo # This makes the prompts easier to follow (as do other random echos below)

########################
### Select a profile ###
########################

declare -a profiles
declare -a visnames
profiles=($(gconftool-2 -R $gconfdir | grep $gconfdir | cut -d/ -f5 |  cut -d: -f1))

#get visible names
for index in  ${!profiles[@]}; 
do    
    visnames[$index]=$(gconftool-2 -g $gconfdir/${profiles[$index]}/visible_name);
done
echo "Please select a Gnome Terminal profile:"
IFS=','
names="${visnames[*]}"
select profile_name in $names; 
do 
  if [[ -z $profile_name ]]; then
    echo -e "ERROR: Invalid selection -- ABORTING!\n"
    exit 1
  fi
  break; 
done
profile_key=$(expr ${REPLY} - 1)
unset IFS

#########################################################
### Show the choices made and prompt for confirmation ###
#########################################################

echo    "You have selected:"
echo -e "  Profile: $profile_name (gconf key: ${profiles[$profile_key]})\n"

#typeset -u confirmation
echo -n "Is this correct? (YES to continue) "
read confirmation
confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation != YES ]]; then
  echo -e "ERROR: Confirmation failed -- ABORTING!\n"
  exit 3
fi

########################
### Finally... do it ###
########################

echo -e "Confirmation received -- applying settings\n"

profile_path=$gconfdir/${profiles[$profile_key]}
# set palette
gconftool-2 -s -t string $profile_path/palette "#3F3F3F3F3F3F:#CCCC93939393:#7F7F9F9F7F7F:#E3E3CECEABAB:#DFDFAFAF8F8F:#CCCC93939393:#8C8CD0D0D3D3:#DCDCDCDCCCCC:#3F3F3F3F3F3F:#CCCC93939393:#7F7F9F9F7F7F:#E3E3CECEABAB:#DFDFAFAF8F8F:#CCCC93939393:#8C8CD0D0D3D3:#DCDCDCDCCCCC"

# set highlighted color to be different from foreground-color
gconftool-2 -s -t bool $profile_path/bold_color_same_as_fg false

# set foreground, background and highlight color
gconftool-2 -s -t string $profile_path/background_color "#3F3F3F3F3F3F"
gconftool-2 -s -t string $profile_path/foreground_color "#DCDCDCDCCCCC"
gconftool-2 -s -t string $profile_path/bold_color       "#E3E3CECEABAB"

# make sure the profile is set to not use theme colors
gconftool-2 -s -t bool $profile_path/use_theme_colors false
