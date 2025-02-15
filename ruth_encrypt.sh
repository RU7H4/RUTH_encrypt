#!/bin/bash

# Clear screen and show banner in pink
clear_screen() {
    clear
    cat << "EOF"
[1;38;5;13m
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

# Function to encode the payload in Base64
encode_payload() {
    local payload_path="$1"
    echo -e "\e[1;38;5;13mEncoding the payload in Base64...\e[0m"
    base64 "$payload_path" > /home/encoded_payload.txt
    echo -e "\e[1;32mPayload encoded!\e[0m"
}

# Function to encrypt the payload with AES-256-CBC
encrypt_payload() {
    local input_file="$1"
    echo -e "\e[1;38;5;13mEncrypting payload...\e[0m"
    echo -n "Enter AES-256-CBC encryption password: "
    read -s password
    echo
    echo -n "Verify password: "
    read -s verify_password
    echo

    if [ "$password" != "$verify_password" ]; then
        echo -e "\e[1;31mPasswords do not match! Try again.\e[0m"
        return 1
    fi

    # Encrypt using OpenSSL with AES-256-CBC
    openssl enc -aes-256-cbc -salt -in "$input_file" -out //encrypted_payload.enc -pass pass:"$password"
    echo -e "\e[1;32mPayload encrypted successfully!\e[0m"
}

# Function to get the payload file and process it
get_payload() {
    local payload_path=""
    while [[ ! -f "$payload_path" ]]; do
        echo -e "\e[1;34mEnter the full path to your payload (APK or EXE):\e[0m"
        read payload_path
        if [[ ! -f "$payload_path" ]]; then
            echo -e "\e[1;31mFile not found! Try again.\e[0m"
        fi
    done

    # Encode the payload
    encode_payload "$payload_path"

    # Encrypt the payload
    encrypt_payload /home/encoded_payload.txt
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32mEncrypted payload saved to /home/encrypted_payload.enc\e[0m"
    fi
}

# Choose platform and handle the payload processing
choose_platform() {
    clear_screen
    echo -e "\e[1;36mChoose your platform:\e[0m"
    echo -e "\e[1;32m1.\e[0m \e[1;33mAndroid\e[0m"
    echo -e "\e[1;32m2.\e[0m \e[1;33mWindows\e[0m"
    echo -e "\e[1;32m3.\e[0m \e[1;33mBack to Main Menu\e[0m"
    echo -e "\e[1;32m4.\e[0m \e[1;33mExit\e[0m"
    read -p "Choice: " choice

    case $choice in
        1|2)
            echo -e "\e[1;36mProcessing payload...\e[0m"
            get_payload
            ;;
        3)
            main_menu
            ;;
        4)
            echo -e "\e[1;31mExiting...\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid choice!\e[0m"
            choose_platform
            ;;
    esac
}

# Main menu function
main_menu() {
    clear_screen
    echo -e "\e[1;36mWelcome! Choose an option:\e[0m"
    echo -e "\e[1;32m1.\e[0m \e[1;33mChoose Platform (Android/Windows)\e[0m"
    echo -e "\e[1;32m2.\e[0m \e[1;33mExit\e[0m"
    read -p "Choice: " main_choice

    case $main_choice in
        1)
            choose_platform
            ;;
        2)
            echo -e "\e[1;31mExiting...\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31mInvalid choice!\e[0m"
            main_menu
            ;;
    esac
}

# Start the main menu
main_menu
