

Here is how the suggester was implemented using Apache Solr.

Note the 'weightExpression' parameter.  These weights were calculated offline using the RankEval framework.

```
   <searchComponent name="suggest" class="solr.SuggestComponent">
   <lst name="suggester">
     <str name="name">suggester_all</str>  <!--combines all sources -->
     <str name="lookupImpl">AnalyzingInfixLookupFactory</str>
     <str name="highlight">false</str>
     <str name="dictionaryImpl">DocumentExpressionDictionaryFactory</str>
     <str name="field">suggestion_term_all</str>
     <int name="rows">10</int>
     <str name="weightExpression">((suggestion_weight_1 * 50.1) + (suggestion_weight_2 *1.2) + (suggestion_weight_3 *1.3)  + (suggestion_weight_4 / 14000) + (suggestion_weight_5 * 1) + (suggestion_weight_6 * 300)+ (suggestion_weight_7 * 1))</str>
     <str name="sortField">suggestion_weight_1</str>
     <str name="sortField">suggestion_weight_2</str>
     <str name="sortField">suggestion_weight_3</str>
     <str name="sortField">suggestion_weight_4</str>
     <str name="sortField">suggestion_weight_5</str>
     <str name="sortField">suggestion_weight_6</str>
     <str name="sortField">suggestion_weight_7</str>
     <str name="suggestAnalyzerFieldType">text_en</str>
     <str name="buildOnStartup">true</str>
   </lst>
  </searchComponent>
  ```

And this is how the suggestion terms and weights are defined within the Solr (managed) schema: -

```
# grep -i sugg /opt/solr/server/solr/<CORPUS_NAME>/conf/managed-schema
  <field name="suggestion_term_1" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_2" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_3" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_4" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_5" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_6" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_7" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_term_all" type="text_general" indexed="true" stored="true"/>
  <field name="suggestion_weight_1" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_2" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_3" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_4" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_5" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_6" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <field name="suggestion_weight_7" type="pdouble" docValues="false" indexed="true" stored="true"/>
  <copyField source="suggestion_term_1" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_2" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_3" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_4" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_5" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_6" dest="suggestion_term_all"/>
  <copyField source="suggestion_term_7" dest="suggestion_term_all"/>
#
#
```
Further notes below show the exact steps taken: -


# 0 BACKUPS
cd /opt/solr/server/solr
service solr stop
tar cvf TCD_Sugg-11-May-2024.tar TCD_Sugg
service solr start

tail -300 /var/log/solr/solr.log | grep TCD_Sugg | grep -i suggester_

# 1 ADD FIELDS

grep suggestion_ /opt/solr/server/solr/TCD_Sugg/conf/*schema

curl -X POST -H 'Content-type:application/json' --data-binary '{"add-field": {"name":"suggestion_term_8", "type":"text_general", "indexed":"true", "stored":"true"}}' 'http://solrsearch1.tcd.ie:8983/solr/TCD_Sugg/schema'
curl -X POST -H 'Content-type:application/json' --data-binary '{"add-field": {"name":"suggestion_weight_8", "type":"pdouble", "docValues":"false", "indexed":"true", "stored":"true"}}'  'http://solrsearch1.tcd.ie:8983/solr/TCD_Sugg/schema'

curl -X POST -H 'Content-type:application/json' --data-binary '{"add-copy-field": {"source":"suggestion_term_8", "dest":"suggestion_term_all"}}' 'http://solrsearch1.tcd.ie:8983/solr/TCD_Sugg/schema'


# 2 UPLOAD CONTENT
scp -p root@solrsearch2:/home/dalyc13/completions/post_8.sh /home/dalyc13/completions/

scp -p root@solrsearch2:/home/dalyc13/completions/qaces-completions-qac.txt /home/dalyc13/completions/
cd /home/dalyc13/completions/
./post_8.sh

/opt/solr/bin/post -p 8983 -params "separator=%09" -c TCD_Sugg /home/dalyc13/completions/qaces-completions-qac.csv

wc -l /home/dalyc13/completions/qaces-completions-qac.csv

curl http://localhost:8983/solr/TCD_Sugg/update?commit=true

# 3 CONFIGURE SUGGESTOR
cp -p /opt/solr/server/solr/TCD_Sugg/conf/solrconfig.xml /opt/solr/server/solr/TCD_Sugg/conf/solrconfig.xml-11-May-2024
 vi +944 /opt/solr/server/solr/TCD_Sugg/conf/solrconfig.xml

grep suggestion_weight_8 /opt/solr/server/solr/TCD_Sugg/conf/solrconfig.xml
#     <str name="weightExpression">((suggestion_weight_1 * 50.1) + (suggestion_weight_2 *1.2) + (suggestion_weight_3 *1.3)  + (suggestion_weight_4 / 14000) + (suggestion_weight_5 * 1) + (suggestion_weight_6 * 300) + (suggestion_weight_7 * 1) + (suggestion_weight_8 * 1))</str>
#     <str name="sortField">suggestion_weight_8</str>

service solr restart
netstat -tulpn | grep 8983
tail -300 /var/log/solr/solr.log | grep TCD_Sugg | grep -i suggester_







