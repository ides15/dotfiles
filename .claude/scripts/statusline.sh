#!/bin/bash
input=$(cat)

cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
green="\033[38;2;118;197;120m"
reset="\033[0m"

printf "${green}\$$(printf '%.2f' "$cost")${reset}"
