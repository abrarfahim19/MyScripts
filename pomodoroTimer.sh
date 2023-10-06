# Check if an argument is provided for work duration
if [ $# -eq 0 ]; then
    echo "Usage: $0 <work_duration_in_minutes>"
    exit 1
fi

# Extract the work duration from the first argument
work_duration_in_minutes="$1"

work_duration=$((work_duration_in_minutes * 60))

# Run the timer
sleep "$work_duration"

# Notify with a custom message using terminal-notifier
terminal-notifier -title "Who has your soul?" -message "Drink Water and Take a break" -sound "Glass"