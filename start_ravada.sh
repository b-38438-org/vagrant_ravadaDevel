#!/bin/bash
#script to initialize ravada server

display_usage()
{
    echo "./start_ravada 1 (messages not prompting to terminal)"
    echo "./start_ravada 0 (prompts enables to this terminal)"
}

if [ $# -eq 0 ]
then
    display_usage
    exit 1
else
    cd src/ravada
    SHOW_MESSAGES=$1
    if [ $SHOW_MESSAGES -eq 1 ]
    then
        morbo ./rvd_front.pl > /dev/null 2>&1 &
        sudo ./bin/rvd_back.pl > /dev/null 2>&1 &
    else
        morbo ./rvd_front.pl &
        sudo ./bin/rvd_back.pl &
    fi
    echo "Server initialized succesfully."
fi
