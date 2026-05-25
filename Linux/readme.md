# Bash Automation Documentation

## Execution Notes

- Run scripts from the terminal using:

```bash
./script_name.sh
````

* Scripts that modify system configurations, manage services, or update packages require `sudo` privileges.

---

# 1. File Management (MANAGEMENT FILE)

## 1.1 File Search by Extension

### Purpose

Searches a specified directory for files matching a specific extension.

### Usage

```bash
./1.bash <directory_path> <extension_without_dot>
```

### Example

```bash
./1.bash /var/log txt
```

---

## 1.2 File Backup and Compression

### Purpose

Archives and compresses a target directory into `.tar.gz` format.

### Usage

```bash
./2.bash <source_directory> <destination_directory>
```

---

## 1.3 Calculate File Statistics

### Purpose

Counts lines, words, and characters for all text files in a directory and formats the output as a table.

### Usage

```bash
./3.bash <directory_path>
```

---

## 1.4 Directory Backup and Log Rotation

### Purpose

Backs up a directory and automatically deletes backup files older than 7 days to conserve disk space.

### Usage

```bash
./4.bash <source_directory> <destination_directory>
```

---

# 2. Basic System Management (BASIC SYSTEM)

## 2.1 System Update Automation

### Purpose

Automatically updates system packages using `apt` or `yum` and logs the output.

### Usage

```bash
sudo ./5.bash
```

### Log Location

```bash
/var/log/system_update.log
```

---

# 3. SSH Configuration and Security (SSH)

## 3.1 Generate SSH Keys

### Purpose

Generates a secure `ed25519` SSH key pair in a specified directory.

### Usage

```bash
./6.bash <storage_directory>
```

---

## 3.2 Copy Public Key to Remote Server

### Purpose

Automates `ssh-copy-id` to enable passwordless logins.

### Usage

```bash
./7.bash <public_key_file> <username> <ip_address>
```

---

## 3.3 Check SSH Connection

### Purpose

Tests SSH connectivity to a remote server non-interactively.

### Usage

```bash
./8.bash <username> <ip_address>
```

---

## 3.4 Manage authorized_keys

### Add Key

Appends a public key to `~/.ssh/authorized_keys`.

#### Usage

```bash
./9.bash <public_key_file> <username>
```

### Remove Key

Removes matching lines from the `authorized_keys` file.

#### Usage

```bash
./10.bash <unique_string> <username>
```

---

# 4. Service and Transfer Management

## 4.1 Service Management (SERVICE)

### Purpose

Wrapper for `systemctl` to start, stop, or check the status of a service.

### Usage

```bash
sudo ./11.bash <start|stop|status> <service_name>
```

---

## 4.2 Remote Copy (SCP & RSYNC)

### Purpose

Copies a local directory to a remote server's home directory.

### Usage (SCP)

```bash
./12_scp.bash <source_dir> <username> <ip_address>
```

### Usage (RSYNC)

```bash
./12_rsync.bash <source_dir> <username> <ip_address>
```

---

## 4.3 Create Systemd Unit File

### Purpose

Creates a dummy Python script and registers it as a systemd background service.

### Usage

```bash
sudo ./13.bash
```

---

# 5. System Monitoring (MONITORING)

## 5.1 CPU Monitoring

### Purpose

Checks CPU usage and logs an alert if average utilization exceeds 75%.

### Usage

```bash
./14.bash
```

### Notes

Ideal for cronjobs.

---

## 5.2 Disk Usage Monitoring

### Purpose

Checks root partition usage. If usage exceeds 80%, triggers a webhook and terminal broadcast.

### Usage

```bash
./15.bash
```

---

## 5.3 Display System Info

### Purpose

Prints the hostname, current time, and number of logged-in users.

### Usage

```bash
./16.bash
```

---

# 6. Network Configuration (NETWORK)

## 6.1 Firewall Configuration (iptables)

### Purpose

Flushes old rules, drops all incoming traffic, and allows:

* SSH (22)
* HTTP (80)
* HTTPS (443)

### Usage

```bash
sudo ./17.bash
```

---

## 6.2 Static IP Configuration (netplan)

### Purpose

Generates a YAML configuration for netplan to set a static IP (`192.168.1.100`).

### Usage

```bash
sudo ./18.bash
```

---
