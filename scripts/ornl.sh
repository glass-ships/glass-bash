#!/bin/bash

alias cdlds='cd ~/dev/ornl/live_data_server'
alias cdmantid='cd ~/dev/ornl/mantid'
alias cdref='cd ~/dev/ornl/refl1d'
alias cdsans='cd ~/dev/ornl/sans-backend'
alias cdwebref='cd ~/dev/ornl/web_reflectivity'

# livedata-prod aliases
alias backup-db='nohup sudo docker exec -u postgres prod-db-1 pg_dump -Fc livedata > /backup/livedata_db-$(date -d "today" +"%Y%m%d_%H%M").dump > pg_dump-log.txt 2>pg_dump-log-errs.txt &'
alias backup-status='ps aux | grep "pg_dump"'
