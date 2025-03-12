# Docker Compose Setup for WordPress and MySQL

![Wordpress-docker-container](https://github.com/user-attachments/assets/65134df8-3150-4ed3-b47b-a2348bb1b21c)

This repository contains a Docker Compose setup for running a WordPress site along with a MySQL database and phpMyAdmin for database management.

## Table of Content

- [Docker Compose Setup for WordPress and MySQL](#docker-compose-setup-for-wordpress-and-mysql)
  - [Table of Content](#table-of-content)
  - [Setup](#setup)
  - [Stopping the Services](#stopping-the-services)
  - [Move the Project from Dev to Production](#move-the-project-from-dev-to-production)
    - [Steps to Perform:](#steps-to-perform)
      - [On the WordPress Development Site:](#on-the-wordpress-development-site)
      - [On the WordPress Production Site:](#on-the-wordpress-production-site)
  - [Password Management Scripts](#password-management-scripts)
    - [Windows Users (.bat files)](#windows-users-bat-files)
    - [Linux/Mac Users (.sh files)](#linuxmac-users-sh-files)

## Setup

1. **Clone the Repository** :rocket:

2. **Set Up the Environment File**:
   You need to create a `.env` file from the example provided. To do this, rename the `.env.EXAMPLE` file to `.env`:
   ```bash
   mv .env.EXAMPLE .env
   ```

3. **Configure the .env File**:
   Open the `.env` file and update the following variables with your own values:
   - `MYSQL_DB_NAME`: Your desired database name.
   - `MYSQL_USER`: Your MySQL username.
   - `MYSQL_ROOT_PASSWORD`: Your MySQL root password.
   - `MYSQL_PASSWORD`: Your MySQL user password.
   - `PORT_WORDPRESS`: The port for accessing WordPress.
   - `PORT_MYSQL`: The port for accessing MySQL.
   - `PORT_PHPMYADMIN`: The port for accessing phpMyAdmin.
   - `NAME_WORDPRESS`: The name for your WordPress container.
   - `NAME_DB`: The name for your MySQL container.
   - `NAME_PHPMYADMIN`: The name for your phpMyAdmin container.

4. **Create the Docker Network** (if it doesn't already exist):
   It is recommended to create a Docker network for your services. You can create the network using the following command:
   ```bash
   docker network create your-network-name --subnet 10.0.1.0/24
   ```

   After creating the network, you need to specify it in your `docker-compose.yml` file to ensure that all services can communicate with each other. Add the following at the end of your `docker-compose.yml` file:
   ```yaml
   networks:
     default:
       name: your-network-name
       external: true
       driver: bridge
   ```
   This configuration tells Docker Compose to use the existing network you created, allowing your WordPress, MySQL, and phpMyAdmin services to interact seamlessly.

5. **Run the Docker Compose**:
   After configuring the `.env` file and creating the network, you can start the services using Docker Compose:
   ```bash
   docker-compose up -d
   ```

6. **Access the Services**:
   - WordPress: [http://localhost:8080](http://localhost:8080)
   - phpMyAdmin: [http://localhost:8082](http://localhost:8082)

## Stopping the Services

To stop the services, run:
```bash
docker-compose down
```

## Move the Project from Dev to Production

**WARNING** :warning:

Ensure that you have already run WordPress on the production server and completed the installation.

To migrate your WordPress site from development to production, we will use the UpdraftPlus: WP Backup & Migration Plugin. This plugin needs to be installed on both the Development and Production WordPress instances.

### Steps to Perform:

#### On the WordPress Development Site:

1. **Create Full Backups**: Use UpdraftPlus to back up all components:
   - Database
   - Plugins
   - Themes
   - Uploads
   - Other files

2. **Download Backup Files**: After the backup is complete, download all backup files to your local machine.

3. **Transfer Backup Files**: Copy the downloaded backup files to your Production Server using a secure method (e.g., SCP, FTP).

#### On the WordPress Production Site:

4. **Access UpdraftPlus Settings**: Log in to your Production WordPress site and navigate to the UpdraftPlus settings area.

5. **Upload Backup Files**: Use the upload feature to import the backup files you transferred.

6. **Restore the Site**: Follow the prompts to restore your site using the uploaded backup files.

After the restoration process is complete, log in using the credentials from your Development WordPress site.

## Password Management Scripts

The project includes several utility scripts for managing MySQL passwords securely:

### Windows Users (.bat files)

- `generate_root_password.bat`: Generates a new random root password and updates it in the `.env` file
- `generate_user_password.bat`: Generates a new random user password and updates it in the `.env` file

To use:
1. Double-click the desired .bat file
2. The script will automatically:
   - Generate a secure random password using OpenSSL
   - Update the corresponding entry in your `.env` file
   - Display the new password in the console
3. Press any key to close the window

### Linux/Mac Users (.sh files)

- `generate_root_password.sh`: Generates a new random root password and updates it in the `.env` file

To use:
1. Make the script executable (first time only):
   ```bash
   chmod +x generate_root_password.sh
   ```
2. Run the script:
   ```bash
   ./generate_root_password.sh
   ```
3. The script will:
   - Generate a secure random password using OpenSSL
   - Update the corresponding entry in your `.env` file
   - Display the new password in the console
4. Press Enter to close

> **Note**: These scripts require OpenSSL to be installed on your system. The scripts will modify your `.env` file directly, so make sure to backup any sensitive data before running them.

This README provides a basic overview of how to set up and run the Docker Compose file for WordPress and MySQL.
