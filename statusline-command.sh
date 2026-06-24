#!/bin/bash
input=$(cat)

extract() {
  echo "$input" | grep -o "\"$1\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" | head -1 | sed 's/.*:[[:space:]]*"\(.*\)"/\1/'
}

extract_num() {
  echo "$input" | grep -o "\"$1\"[[:space:]]*:[[:space:]]*[0-9.]*" | head -1 | sed 's/.*:[[:space:]]*//'
}

branch=$(extract "git_worktree")
cwd=$(extract "current_dir")
cwd=$(basename "$cwd" 2>/dev/null)
model=$(extract "display_name")
context=$(extract_num "used_percentage")
session_cost=$(extract_num "total_cost_usd")
five_hour_usage=$(echo "$input" | grep -o '"five_hour"[[:space:]]*:[[:space:]]*{[^}]*}' | grep -o '"used_percentage"[[:space:]]*:[[:space:]]*[0-9.]*' | head -1 | sed 's/.*:[[:space:]]*//')
five_hour_resets=$(echo "$input" | grep -o '"five_hour"[[:space:]]*:[[:space:]]*{[^}]*}' | grep -o '"resets_at"[[:space:]]*:[[:space:]]*[0-9.]*' | head -1 | sed 's/.*:[[:space:]]*//')
if [ -n "$five_hour_resets" ]; then
  now=$(date +%s)
  remaining=$(( five_hour_resets - now ))
  if [ "$remaining" -gt 0 ]; then
    hours=$(( remaining / 3600 ))
    mins=$(( (remaining % 3600) / 60 ))
    five_hour_reset_str=$(printf '%dh%02dm' "$hours" "$mins")
  else
    five_hour_reset_str="now"
  fi
fi
weekly_usage=$(echo "$input" | grep -o '"seven_day"[[:space:]]*:[[:space:]]*{[^}]*}' | grep -o '"used_percentage"[[:space:]]*:[[:space:]]*[0-9.]*' | head -1 | sed 's/.*:[[:space:]]*//')

green="\033[32m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
yellow="\033[33m"
red="\033[31m"
dim="\033[90m"
reset="\033[0m"

sep="${dim} | ${reset}"

parts=()

[ -n "$branch" ] && parts+=("${green}${branch}${reset}")
[ -n "$cwd" ] && parts+=("${blue}${cwd}${reset}")
[ -n "$model" ] && parts+=("${magenta}${model}${reset}")
[ -n "$context" ] && parts+=("${cyan}$(printf 'ctx: %.0f%%' "$context")${reset}")
[ -n "$session_cost" ] && parts+=("${yellow}$(printf '$%.2f' "$session_cost")${reset}")
if [ -n "$five_hour_usage" ]; then
  five_hour_label=$(printf '5h: %.0f%%' "$five_hour_usage")
  [ -n "$five_hour_reset_str" ] && five_hour_label+=" (${five_hour_reset_str})"
  parts+=("${red}${five_hour_label}${reset}")
fi
[ -n "$weekly_usage" ] && parts+=("\033[38;5;208m$(printf 'week: %.0f%%' "$weekly_usage")${reset}")

output=""
for i in "${!parts[@]}"; do
  [ "$i" -gt 0 ] && output+="$sep"
  output+="${parts[$i]}"
done

echo -e "$output"
