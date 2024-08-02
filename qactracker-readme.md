# QACTRACKER: Validation and Verification for QAC in Enterprise Search
-----------------------------------------------------------------------------------

Contact: dalyc24@tcd.ie

-----------------------------------------------------------------------------------
## Intro
A useful verification and validation test to ensure that all of the various features (i.e. fields in the Apache Solr index) are being utilised by QAC is to add a unique ‘tracking’ string that immediately conveys the source of the candidate. For example, “qactracker[1..n]”, where n is the number of features as shown in Figure below.

![fig-qac-validation-qactracker-2](https://github.com/user-attachments/assets/69c872ee-1352-49a2-a015-35f1af305068)


## Ranking And Recall
This tracker validation method performs a simple gauge of both the recall and ranking
aspects of QAC for ES: -
* Recall: the instance number appended to each string tells us the origin of the QAC candidate. If there are nine features, there should be nine candidates for the appropriate prefix.
* Ranking: the order in which the candidates are ranked is a reflection of the weightings that are assigned via LTR. In Figure 4.8, we see that feature number 6 (identified by qactracker6) has a relatively higher LTR weighting than, say, feature number 3.


## Limitations
The QAC tracker tool has two important limitations. 
* Firstly, if the ranking model contains more features than the number of candidates presented via the drop-down (usually ten or seven), those features with a lower LTR weighting will not be visible. This is easily overcome by typing the full prefix length (e.g., qactracker17).
* Secondly, the presented order of the tracking strings merely conveys the relative ranking order; it does not give any absolute information regarding the LTR weighting.


## Suitability for Enterprise Search

## Advanced verification

## How to Run
Download the `qactracker.sh` script to the Apache Solr server.
```
# ./qactracker.sh
QACTRACKER: deleting qactracker string (i.e. clean up if it already exists)
QACTRACKER: adding qactracker string to feature 1
QACTRACKER: adding qactracker string to feature 2
QACTRACKER: adding qactracker string to feature 3
QACTRACKER: adding qactracker string to feature 4
QACTRACKER: adding qactracker string to feature 5
QACTRACKER: adding qactracker string to feature 6
QACTRACKER: adding qactracker string to feature 7
QACTRACKER: adding qactracker string to feature 8
QACTRACKER: finished adding qactracker string to features
QACTRACKER: ReLoading REDACTED at port 8983
QACTRACKER: Here is a list of fields with the indexed qactracker string:
qactracker1 qactracker2 qactracker3 qactracker4 qactracker5 qactracker6 qactracker7 qactracker8
#
```

## Dependencies
For the above to work, there should be a separate field for each QAC ranking feature.  The fields are designed in the Solr schema as follows: -
 ```
# grep suggestion /opt/solr/server/solr/REDACTED/conf/managed-schema
  <field name="suggestion_term_1" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_2" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_3" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_4" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_5" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_6" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_7" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_8" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_all" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_weight_1" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_2" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_3" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_4" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_5" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_6" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_7" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_8" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <copyField source="suggestion_term_1" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_2" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_3" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_4" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_5" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_6" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_7" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_8" dest="suggestion_term_all"/>
#
```




## Acknowledgements
This research was conducted with the financial support of Science Foundation Ireland under Grant Agreement No. 13/RC/2106 P2 at the ADAPT SFI Research Centre at Trinity College Dublin. ADAPT, the SFI Research Centre for AI-Driven Digital Content Technology, is funded by Science Foundation Ireland through the SFI Research Centres Programme.

