

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






