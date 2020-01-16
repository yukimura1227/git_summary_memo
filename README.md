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

#### blame_file_analyze.rbを実行する

```
ruby blame_file_analyze.rb tmp/xxxxxxxx_blame.txt
```

### git log --numstatの結果を集計する

collect_numstat.shを参考にしてください

### コミットユーザごとのコミット回数を数える。
authors=(hoge fuga)
SINCE_DATE=2019-09-01
for project in ${porjects[@]}
do
  echo "${project}"
  cd ~/projects/${project}
  git checkout master
  git pull
  for author in ${authors[@]}
  do
    echo "${author} $(git log --since=${SINCE_DATE} --author=${author} --oneline --no-merges | wc -l)"
  done
done
