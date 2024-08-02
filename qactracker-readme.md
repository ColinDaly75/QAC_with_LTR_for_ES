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


### Limitations




# How to Run
To reproduce, simply download the code (python ipynb files) and LTR dataset (txt file).  The code was compliled using python 3 (see addional package requirements below).
The scripts can be run independently, but the logical order is 
1. search-demand-curve-enterprise-search.ipynb   (dataset analysis and prepration)




# Dependencies


  


# Acknowledgements
This research was conducted with the financial support of Science Foundation Ireland under Grant Agreement No. 13/RC/2106 P2 at the ADAPT SFI Research Centre at Trinity College Dublin. ADAPT, the SFI Research Centre for AI-Driven Digital Content Technology, is funded by Science Foundation Ireland through the SFI Research Centres Programme.

