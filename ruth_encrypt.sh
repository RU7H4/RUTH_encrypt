#!/bin/bash

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

encode_payload() {
    local payload_file="$1"
    echo -e "\e[1;33mEncoding the payload in Base64...\e[0m"
    base64 "$payload_file" | tr -d '\n' > /tmp/encoded_payload.txt
    echo -e "\e[1;32mPayload encoded!\e[0m"
}

obfuscate_payload() {
    local payload="$1"
    echo -e "\e[1;33mObfuscating payload...\e[0m"
    local obfuscated_payload=$(echo "$payload" | sed 's/S/s/g' | sed 's/a/b/g' | sed 's/e/f/g')
    echo -e "\e[1;32mPayload obfuscated!\e[0m"
    echo "$obfuscated_payload"
}

encrypt_payload() {
    local payload="$1"
    echo -e "\e[1;33mEncrypting payload...\e[0m"
    echo "$payload" | openssl enc -aes-256-cbc -salt -pbkdf2 -out "/tmp/encrypted_payload.enc"
    echo -e "\e[1;32mPayload encrypted!\e[0m"
}

get_payload() {
    local payload_path=""
    while [[ ! -f "$payload_path" ]]; do
        echo -e "\e[1;34mEnter the full path to your payload (APK or EXE):\e[0m"
        read payload_path
        if [[ ! -f "$payload_path" ]]; then
            echo -e "\e[1;31mFile not found! Try again.\e[0m"
        fi
    done
    encode_payload "$payload_path"
    payload=$(cat /tmp/encoded_payload.txt)
    obfuscated_payload=$(obfuscate_payload "$payload")
    encrypt_payload "$obfuscated_payload"
}

output_payload() {
    local input_file="$1"
    script_dir=$(dirname "$0")
    output_file="$script_dir/processed_payload"

    echo -e "\e[1;33mOutputting processed payload...\e[0m"
    cp "$input_file" "$output_file"
    echo -e "\e[1;32mPayload processed! Output saved to $output_file\e[0m"
}

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
            output_payload "$input_file"
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

main_menu
