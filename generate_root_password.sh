#!/bin/bash

# Generate new password
NEW_PASSWORD=$(openssl rand -base64 24)

# Update the .env file
sed -i "s/^MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=$NEW_PASSWORD/" .env

# Display results
echo "Password updated successfully!"
echo "New password: $NEW_PASSWORD"

# Optional: press enter to continue
read -p "Press Enter to continue..."