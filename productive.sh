if grep -q "^#127\.0\.0\.1 www\.youtube\.com" /etc/hosts; then
    current_mode="Educative"
else
    current_mode="Productive"
fi

echo "Select a mode:"
if [ "$current_mode" = "Productive" ]; then
    echo "1. Productive (Current)"
    echo "2. Educative"
else 
    echo "1. Productive"
    echo "2. Educative  (Current)"
fi

read -p "Enter your choice (1 or 2): " choice

if [ "$choice" = "1" ]; then
    if [ "$current_mode" = "Productive" ]; then
        echo "Already in Productive mode."
    else
        echo "Switching to Productive mode..."
        sudo sed -i '' '/www\.youtube\.com/s/^#//' /etc/hosts
    fi
elif [ "$choice" = "2" ]; then
    if [ "$current_mode" = "Educative" ]; then
        echo "Already in Educative mode."
    else
        echo "Switching to Educative mode..."
        sudo sed -i '' '/www\.youtube\.com/s/^/#/' /etc/hosts
    fi
else
    echo "Invalid choice. Please enter 1 or 2."
fi

