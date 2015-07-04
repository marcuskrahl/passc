#!/bin/sh

# SET THIS TO THE PASSWORD STORE
PASSWORD_STORE="~/.password-store/"

eval "cd $PASSWORD_STORE"

copy_password() {
    pass -c "$1" 
}

result=$(find . -iname "*$1*.gpg")
cleaned_result=$(echo "$result" | sed 's&^./&&' | sed 's&.gpg$&&') 

if [ $(echo "$cleaned_result" | wc -l ) -gt 1 ]; then
    echo "$cleaned_result" | nl -n 'ln'
    read -r answer
    selected_line=$(echo "$cleaned_result" | sed -n -e $answer"p")
    copy_password "$selected_line"
else
    copy_password "$cleaned_result"
fi


