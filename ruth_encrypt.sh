#!/bin/bash
TEMP_FILE="/tmp/decrypted_payload"
cleanup() {
    [[ -f "$TEMP_FILE" ]] && rm -f "$TEMP_FILE"
}
trap cleanup EXIT
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
encrypt_payload() {
    if [[ ! -f "$1" ]]; then
        echo -e "\e[1;31mFile not found: $1\e[0m"
        return 1
    fi
    encoded=$(base64 "$1")
    if [[ $? -ne 0 ]]; then
        echo -e "\e[1;31mError encoding file.\e[0m"
        return 1
    fi
    echo "$encoded"
}
d3cRyP73() {
    local encoded_payload="$1"
    echo "$encoded_payload" | base64 --decode > "$TEMP_FILE"
    if [[ $? -ne 0 ]]; then
        echo -e "\e[1;31mError decoding payload.\e[0m"
        return 1
    fi
    chmod +x "$TEMP_FILE"
    echo -e "\e[1;33mPayload decoded and saved to $TEMP_FILE.\e[0m"
    read -p $'\e[1;33mAre you sure you want to execute the payload? (y/N): \e[0m' confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "\e[1;33mExecuting decoded payload...\e[0m"
        "$TEMP_FILE"
    else
        echo -e "\e[1;31mExecution canceled by user.\e[0m"
    fi
}
get_payload() {
    local payload_path=""
    while [[ ! -f "$payload_path" ]]; do
        echo -e "\e[1;34mEnter the path to your payload (APK or EXE):\e[0m"
        read -r payload_path
        if [[ ! -f "$payload_path" ]]; then
            echo -e "\e[1;31mFile not found! Try again.\e[0m"
        fi
    done
    encrypt_payload "$payload_path"
}
dyn4M1C_ex3c() {
    echo -e "\e[1;34mEnter the command to execute dynamically:\e[0m"
    read -r usrCmd
    if [[ -n "$usrCmd" ]]; then
        echo -e "\e[1;33mYou entered: $usrCmd\e[0m"
        read -p $'\e[1;33mAre you sure you want to execute this command? (y/N): \e[0m' cmd_confirm
        if [[ "$cmd_confirm" =~ ^[Yy]$ ]]; then
            echo -e "\e[1;33mExecuting: $usrCmd\e[0m"
            eval "$usrCmd"
        else
            echo -e "\e[1;31mCommand execution canceled.\e[0m"
        fi
    else
        echo -e "\e[1;31mNo command entered!\e[0m"
    fi
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
            payload=$(get_payload)
            if [[ -n "$payload" ]]; then
                d3cRyP73 "$payload"
            else
                echo -e "\e[1;31mFailed to encode payload.\e[0m"
            fi
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
    echo -e "\e[1;32m1.\e[0m \e[1;33mChoose Platform (Android/Windows payload processing)\e[0m"
    echo -e "\e[1;32m2.\e[0m \e[1;33mDynamic Command Execution\e[0m"
    echo -e "\e[1;32m3.\e[0m \e[1;33mExit\e[0m"
    read -p "Choice: " main_choice
    case $main_choice in
        1)
            choose_platform
            ;;
        2)
            dyn4M1C_ex3c
            ;;
        3)
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
