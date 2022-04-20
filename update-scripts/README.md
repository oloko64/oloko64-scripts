# Update Scripts

These are scripts that do some updating on your system.

### [update-all-repositories.sh](update-all-repositories.sh)

> This script will enter each folder and run the `git pull` command. If no path to the folder is given it will run on the current working directory.

To run this script enter the `update-scripts` folder and run:

```bash
./update-all-repositories.sh
```

or with the path to the folder containing all the repositories:

```bash
./update-all-repositories.sh <path/to/folder>
```
