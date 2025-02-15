#!/bin/bash

# Function to clear the screen but keep the banner
clear_screen() {
    clear
    cat << "EOF"
[1;32m
.S_sSSs     .S       S.   sdSS_SSSSSSbs   .S    S.   
.SS~YS%%b   .SS       SS.  YSSS~S%SSSSSP  .SS    SS.  
S%S   `S%b  S%S       S%S       S%S       S%S    S%S  
S%S    S%S  S%S       S%S       S%S       S%S    S%S  
S%S    d*S  S&S       S&S       S&S       S%S SSSS%S  
S&S   .S*S  S&S       S&S       S&S       S&S  SSS&S  
S&S_sdSSS   S&S       S&S       S&S       S&S    S&S  
S&S~YSY%b   S&S       S&S       S&S       S&S    S&S  
S*S   `S%b  S*b       d*S       S*S       S*S    S*S  
S*S    S%S  S*S.     .S*S       S*S       S*S    S*S  
S*S    S&S   SSSbs_sdSSS        S*S       S*S    S*S  
S*S    SSS    YSSP~YSSY         S*S       SSS    S*S  
SP                              SP               SP   
Y                               Y                Y    
[0m
EOF
}

# Function to decode Base64 string
oBcW0X() {
    echo "$1" | base64 --decode
}

# Function to execute the decoded payload
b1x9A2vA() {
    oBcW0X "$1" | bash
}

# Function to handle the user's choice for Android or Windows
choose_platform() {
    clear_screen
    echo -e "\e[1;36mPlease choose the platform:\e[0m"
    echo -e "\e[1;32m1.\e[0m \e[1;33mAndroid\e[0m"
    echo -e "\e[1;32m2.\e[0m \e[1;33mWindows\e[0m"
    echo -e "\e[1;32m3.\e[0m \e[1;33mExit\e[0m"
    read -p "Enter your choice (1, 2, 3): " platform_choice

    case $platform_choice in
        1)
            echo -e "\e[1;36mRunning Android payload...\e[0m"
            # Add Android payload execution code here
            ;;
        2)
            echo -e "\e[1;36mRunning Windows payload...\e[0m"
            # Add Windows payload execution code here
            ;;
        3)
            echo -e "\e[1;31mExiting...\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid option! Please choose again.\e[0m"
            choose_platform
            ;;
    esac
}

# Function to clear the screen and show options in the main menu
main_menu() {
    clear_screen
    echo -e "\e[1;36mWelcome to the Tool! Choose an option below:\e[0m"
    echo -e "\e[1;32m1.\e[0m \e[1;33mChoose Platform (Android/Windows)\e[0m"
    echo -e "\e[1;32m2.\e[0m \e[1;33mExit\e[0m"
    read -p "Enter your choice (1, 2): " choice

    case $choice in
        1)
            choose_platform
            ;;
        2)
            echo -e "\e[1;31mExiting...\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid option! Please choose again.\e[0m"
            main_menu
            ;;
    esac
}

# Main entry point of the script
main_menu
