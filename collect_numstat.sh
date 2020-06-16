#/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)

projects=(authenticate_client authenticate paiza botchi_engine paiza_scoring cgc_engine infra paiza_e2e_test design_system)
SINCE_DATE=2019-09-01
for project in ${projects[@]}
do
  echo "----------${project}----------"
  cd ~/projects/${project}
  git checkout master > /dev/null
  git pull > /dev/null
  log_file_path=/tmp/$(basename `pwd`)_$(git rev-parse --short HEAD)_numstat_log_since_${SINCE_DATE//-/}.txt
  git log --since "${SINCE_DATE} 00:00:00" --no-merges --numstat --date=short --decorate=short --pretty=format:'commit-----"%h"-----"%cd"-----"%cn"-----"%d"-----"%s"' > ${log_file_path}

  # specだけを対象にする場合の例
  FILTER=spec/
  log_file_path=/tmp/$(basename `pwd`)_$(git rev-parse --short HEAD)_numstat_log_since_${SINCE_DATE}_only_${FILTER//\//_}.txt
  git log --since "${SINCE_DATE} 00:00:00" --no-merges --numstat --date=short --decorate=short --pretty=format:'commit-----"%h"-----"%cd"-----"%cn"-----"%d"-----"%s"' -- ${FILTER} > ${log_file_path}

  cd ${SCRIPT_DIR}
  ruby ${SCRIPT_DIR}/numstat_log_file_analyze.rb ${log_file_path}
done
