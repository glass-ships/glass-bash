#!/bin/bash

alias cdlds='cd ~/dev/ornl/live_data_server'
alias cdmantid='cd ~/dev/ornl/mantid'
alias cdref='cd ~/dev/ornl/refl1d'
alias cdsans='cd ~/dev/ornl/sans-backend'
alias cdwebref='cd ~/dev/ornl/web_reflectivity'

# LIVEDATA DB BACKUP

# CMD TEMPLATE: docker exec -u <your_postgres_user> <postgres_container_name> pg_dump -Fc <database_name_here> > db.dump
# TEST DB:      docker exec -u postgres test-db-1 pg_dump -Fc livedata > db.dump
# PROD DB:      sudo docker exec -u postgres prod-db-1 pg_dump -Fc livedata > /backup/livedata_db-$(date -d "today" +"%Y%m%d_%H%M").dump
alias backup-db='nohup sudo docker exec -u postgres prod-db-1 pg_dump -Fc livedata > /backup/livedata_db-$(date -d "today" +"%Y%m%d_%H%M").dump 2>pg_dump-log-errs.txt &'
# alias backup-db='nohup sudo docker exec -u postgres prod-db-1 pg_dump -Fc livedata > /backup/livedata_db-$(date -d "today" +"%Y%m%d_%H%M").dump > pg_dump-log.txt 2>pg_dump-log-errs.txt &'
alias backup-status='ps aux | grep "pg_dump"'
