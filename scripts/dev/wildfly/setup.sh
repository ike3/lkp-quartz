#/bin/bash

export FCS_HOME=/mnt/c/Users/ike/Projects/fcs
export SHARED_LIBS_INPUT=$FCS_HOME/spikes/quartz/shared-lib
export SCHEDULER_DB_URL="jdbc:oracle:thin:@localhost:1521/FCSDB"


export WF_HOME=$FCS_HOME/wildfly-test
. ./common.sh
common_config
data_source
naming
cleanup

export WF_HOME=$FCS_HOME/wildfly-test-slave
. ./common.sh
common_config
data_source
naming
cleanup