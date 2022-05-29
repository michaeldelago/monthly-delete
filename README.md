# monthly-delete.hy

quick script to delete files to 2 rules.

- older than one month
- not taken on the 14th or the 28th


## Prereqs

You need hy to use this script.  You can install it with 

```bash
$ pip3 install --user hy==1.0a4
```

## Usage

usage: monthly-delete.hy [-h] [-d] directory

positional arguments:
  directory

options:
  -h, --help    show this help message and exit
  -d, --delete  Confirm deletion of files

## Notes

This was originally written to prune sqldump files