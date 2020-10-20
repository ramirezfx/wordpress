CREATE DATABASE wpdb;

CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppwd';
GRANT ALL ON wpdb.* TO 'wpuser'@'localhost' IDENTIFIED BY 'wppwd' WITH GRANT OPTION;
FLUSH PRIVILEGES;
