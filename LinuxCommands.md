Important Linux Commands
------------------------

## Shell

##### Find / Find and Delete Files

```sh
find . -name "*.php"

find . -type f -name "*.php" -exec rm -f {} \;
```

##### Find files newer than 2014/Jan/01, in /var/www

```sh
touch --date "2014-01-01" /tmp/foo
find /var/www -newer /tmp/foo
```
 
##### Search for text inside files

```sh
grep -irn "func main" .
```

## Git

git config --global user.name "name"
git config --global user.email "name@gmail.com"

```sh
git init .

git add .
git add -A

git commit -m "commit message"

git commit --amend
git commit --amend -m "revise message"

git branch feature132
git checkout feature132

# Create branch and checkout
git checkout -b feature132
```

##### Disable IPTables

```sh
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
```

##### Find suspicious process

```sh
lsof -i | less
# note the PID
lsof | grep pid
```