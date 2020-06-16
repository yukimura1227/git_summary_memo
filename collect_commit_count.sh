#/bin/bash

# authors=(tatsuya.shimizu yukimura1227 puriso shoichinishiguchi Yoshioka kiri1120 yukaito kimpara sakipon Shuto takahashihideaki Akira sanae)
projects=(authenticate_client authenticate paiza botchi_engine paiza_scoring cgc_engine infra paiza_e2e_test design_system)
SINCE_DATE=2020-03-01
IFS=$'\n'
for project in ${projects[@]}
do
  echo "**********${project}**********"
  cd ~/projects/${project}
  git checkout master
  git pull > /dev/null
  for author in `git log --since=${SINCE_DATE} --pretty=format:"%an" | sort | uniq`
  do
    echo "${author}\t$(git log --since=${SINCE_DATE} --author=${author} --oneline --no-merges | wc -l)"
  done
  echo
  echo
done

