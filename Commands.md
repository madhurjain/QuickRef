Important Commands
------------------

## Shell

##### Find / Find and Delete Files

```sh
find . -name "*.php"

find . -type f -name "*.php" -exec rm -f {} \;
```

##### Search for text inside files

```sh
grep -irn "func main" .
```

## Git

```sh
git init .

git add .
git add -A

git commit -m "commit message"

git commit --amend
git commit --amend -m "revise message"
```

