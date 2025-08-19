#!/bin/bash

### LIVEDATA DB BACKUP

# CMD TEMPLATE: docker exec -u <your_postgres_user> <postgres_container_name> pg_dump <database_name_here> > db.dump
# TEST DB:      docker exec -u postgres test-db-1 pg_dump livedata > db.dump
# PROD DB:      sudo docker exec -u postgres prod-db-1 pg_dump -Fc livedata > /backup/livedata_db-$(date -d "today" +"%Y%m%d_%H%M").dump
alias backup-db='nohup sudo docker exec -u postgres prod-db-1 pg_dump --verbose livedata > /backup/livedata_db-$(date -d "today" +"%Y%m%d_%H%M").dump 2>pg_dump-log-errs.txt &'
alias backup-status='ps aux | grep "pg_dump"'
alias check-rpm="rpm -qa | grep nsd-app-wrap"
