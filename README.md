# Git Summary Memo
gitの集計をした時のメモ書き
(gistに書いておくような内容だけど。。。)

## 集計

### git blame の結果をAuthor事にサマル

#### git blameの情報を取得する

```
git checkout master
git pull
find ./ -type f | xargs -n1 git blame --date short > $(git rev-parse --short HEAD)_blame.txt
# specだけを対象にする場合の例
# find ./spec -type f | xargs -n1 git blame --date short > $(git rev-parse --short HEAD)_spec_blame.txt

# 特定の日付以降だけを対象にする場合(特定日以前のものは、先頭に^がつくので、除外している)
# find ./spec -type f | xargs -n1 git blame --date short --since '2018-03-01 00:00:00' | grep -v ^\^ > $(git rev-parse --short HEAD)_spec_blame_since_20180301.txt
```

#### analyze_blame_file.rbを実行する

```
ruby analyze_blame_file.rb tmp/xxxxxxxx_blame.txt
```

### git log --numstatの結果を集計する

```
git checkout master
git pull
git log --since "2018-03-01 00:00:00" --no-merges --numstat --date=short --decorate=short --pretty=format:'commit-----"%h"-----"%cd"------"%cn"-----"%d"-----"%s"' > $(git rev-parse --short HEAD)_numstat_log.txt

# specだけを対象にする場合の例
# git log --since "2018-03-01 00:00:00" --no-merges --numstat --date=short --decorate=short --pretty=format:'commit-----"%h"-----"%cd"------"%cn"-----"%d"-----"%s"' -- spec/ > $(git rev-parse --short HEAD)_numstat_log_since_20180301.txt
```

```
ruby analyze_numstat_log_file.rb tmp/xxxxxx_numstat_log_since_20180301.txt
```
