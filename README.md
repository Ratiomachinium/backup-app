# backup-app

backup-app is a small Ubuntu/Linux CLI utility for versioned, tar-based backups of application folders with optional exclusions.

It supports:
- Version bumping: major and minor (X.Y → X.(Y+1) or (X+1).0)
- Excluding runtime/data directories inside the target (e.g., DB files, caches)
- Listing available apps and backups
- Checking top-level folders in a directory (non-hidden only)
- A help/usage file shown on invalid input

## Naming convention

Backups are created as:


<app>-<version>_<YYYYMMDD>.tar.gz


Example:


newsletters-1.0_20260105.tar.gz


<app> is the basename of the target directory you back up.

## Default locations

- Backups:  
  /var/backups/apps

- Version state (per app):  
  /var/backups/apps/.backup-app-state/<app>.version

- Help / usage text:  
  /usr/local/share/backup-app/USAGE.txt

## Installation

### 1) Install the script
Copy your backup-app script to:


/usr/local/bin/backup-app


Then:

bash
sudo chmod +x /usr/local/bin/backup-app


### 2) Install the help file

Create:

bash
sudo mkdir -p /usr/local/share/backup-app
sudo nano /usr/local/share/backup-app/USAGE.txt


Paste your usage text into USAGE.txt.

## Usage

### Create a backup (major/minor)

**Major bump**:
bash
sudo backup-app major +/home/frad/newsletters -/home/frad/newsletters/data


**Minor bump**:
bash
sudo backup-app minor +/home/frad/newsletters -/home/frad/newsletters/data


Rules:
- +TARGET is required and must be an absolute path
- Each -EXCLUDE is optional and must be inside +TARGET (nested allowed)

### List backed-up apps

bash
backup-app list


Output (example):

Newsletters 2026-01-05
Wedding-website 2026-01-05


### List backups for one app

bash
backup-app list newsletters


Output (example):

1.0 2026-01-05
1.1 2026-01-06
2.0 2026-01-07


### Check directories (non-hidden)

List all top-level directories under a path (ignores dot-prefixed folders):

bash
backup-app check /home/frad/


Output (example):

newsletters
wedding-website


### Help

bash
backup-app help


## Restoring a backup

Inspect contents:

bash
sudo tar -tzf /var/backups/apps/newsletters-1.0_20260105.tar.gz


Restore to the original absolute paths (because the archive stores paths relative to /):

bash
sudo tar -xzf /var/backups/apps/newsletters-1.0_20260105.tar.gz -C /


Restore into a test folder:

bash
sudo mkdir -p /tmp/restore-test
sudo tar -xzf /var/backups/apps/newsletters-1.0_20260105.tar.gz -C /tmp/restore-test


## Notes / Security

- Default backups are written to /var/backups/apps, which typically requires sudo.
- If you prefer non-sudo usage, you can set a user-writable destination:

bash
BACKUP_DIR="$HOME/backups/apps" backup-app major +/home/frad/newsletters


## License

Add a license file if you plan to distribute this publicly (MIT is common for small utilities).
