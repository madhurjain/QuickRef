Important Linux Commands
------------------------

## Shell

##### Find / Find and Delete Files

```sh
find . -name "*.php"

find . -type f -name "*.php" -exec rm -f {} \;

# Delete all except file.txt
find ! -name 'file.txt' -type f -exec rm -f {} +
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


##### Linux performance analysis in 60,000 Milliseconds

[Netflix Blog](https://media.netflix.com/en/tech-blog/linux-performance-analysis-in-60-000-milliseconds)

`uptime` - A way to view the load averages.
`dmesg | tail` - Views the last 10 system messages, if any.
`vmstat 1` - Prints a summary of key server statistics on each line.
`mpstat -P ALL 1` - Prints CPU time breakdowns per CPU, which can be used to check for an imbalance.
`pidstat 1` - Prints a rolling summary instead of clearing the screen.
`iostat -xz 1` - A tool for understanding block devices (disks).
`free -m` - Columns that show buffers and cache.
`sar -n DEV 1` - A tool to check the network interface.
`sar -n TCP,ETCP 1` - Shows key TCP metrics.
`top` Run to see if anything looks different from other commands.

Some of the commands require the sysstat package to be installed


#### Archival + Compression

##### TAR + GZip Compress
```sh
tar -czf ~/backup-archive.tar.gz ~/backup/
```

##### Uncompress
```sh
tar -xzvf ~/backup-archive.tar.gz
```

##### View Contents of Archive
```sh
tar -tf ~/backup-archive.tar
```
```sh
zip -sf ~/compressed.zip
```