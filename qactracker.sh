#!/bin/bash
# who: CD
# date: 02-04-2024
# function:  a script to add/test/remove QAC tracker string.  See https://github.com/ColinDaly75/QAC_LTR_for_ES/ for more info

QAC_STRING=qactracker  #make sure this is not used in the corpus as regular content!
MAX_NO_OF_FEATURES=9
CORE=REDACTED
SOLR_PORT=8983
DEBUG=false


# delete the tracker if it already exists in the index
echo "QACTRACKER: deleting $QAC_STRING string (i.e. clean up if it already exists)"
/usr/bin/curl -s http://localhost:$SOLR_PORT/solr/$CORE/update?commit=true --data "<delete><query>suggestion_term_all:${QAC_STRING}*</query></delete>" >/dev/null 2>&1


# add the QAC tracker string to each feature field in the QAC index
for FEATURE_NUMBER in $(seq 1 $MAX_NO_OF_FEATURES)
do
        LAST_ID_NUM=`curl -s "http://localhost:$SOLR_PORT/solr/$CORE/select?q=id:$FEATURE_NUMBER*&fl=id&rows=1&wt=csv&sort=id%20desc" | grep -v id`
        if [ -n "${LAST_ID_NUM}" ];
        then
                NEXT_ID_NUM=$((LAST_ID_NUM + 1)) #var=$((var + 1))
                if [ $DEBUG = "true" ];
                then
                        echo "QACTRACKER: FEATURE_NUMBER is $FEATURE_NUMBER"
                        echo "QACTRACKER: LAST_ID_NUM is $LAST_ID_NUM"
                        echo "QACTRACKER: NEXT_ID_NUM is $NEXT_ID_NUM"
                fi
                echo "QACTRACKER: adding $QAC_STRING string to feature $FEATURE_NUMBER"
                curl -s "http://localhost:$SOLR_PORT/solr/$CORE/update?commit=true" -H 'Content-type:application/json' -d "[{"id":"$NEXT_ID_NUM","suggestion_term_$FEATURE_NUMBER":"${QAC_STRING}${FEATURE_NUMBER}","suggestion_weight_$FEATURE_NUMBER":1}]" >/dev/null
        fi
done
echo "QACTRACKER: finished adding $QAC_STRING string to features"

# RELOAD of the core is required
echo "QACTRACKER: ReLoading $CORE at port $SOLR_PORT"
/usr/bin/curl -s http://localhost:$SOLR_PORT/solr/admin/cores?action=RELOAD\&core=$CORE >/dev/null 2>&1


# step 5: verify that the tracker is now in the index for each field (feature)
LIST=`/usr/bin/curl -s "http://localhost:$SOLR_PORT/solr/$CORE/select?q=suggestion_term_all:${QAC_STRING}*&fl=suggestion_term_all&wt=csv" | grep ${QAC_STRING}[0-9]`
if [ -n "${LIST}" ];
then
        echo "QACTRACKER: Here is a list of fields with the indexed $QAC_STRING string: "
        echo $LIST
        exit 0
else
        echo "QACTRACKER: No fields have an indexed $QAC_STRING string"
        exit 1
fi


