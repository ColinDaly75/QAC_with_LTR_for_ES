# QACTRACKER: Validation and Verification for QAC in Enterprise Search
-----------------------------------------------------------------------------------

Contact: dalyc24@tcd.ie

-----------------------------------------------------------------------------------
## Intro
A useful verification and validation test to ensure that all of the various features (i.e. fields in the Apache Solr index) are being utilised by QAC is to add a unique ‘tracking’ string that immediately conveys the source of the candidate. For example, “qactracker[1..n]”, where n is the number of features as shown in Figure below.
![fig-qac-validation-qactracker-2](https://github.com/user-attachments/assets/69c872ee-1352-49a2-a015-35f1af305068)


## Analysis & Experiments
This project analyses the the use of Learning to Rank for Query Auto-Complete suggestions on a ’real world’ Enterprise Search (ES) service of a large organisation.

### Dataset
We generate a small LTR QAC dataset. Most Popular Completions(MPC) is widely used as a QAC baseline and can be regarded as an approximate maximum likelihood estimator ~\cite{li-google-2017,yadav2021}. MPC is limited by its dependence on historical data and cannot make predictions about the popularity of future query candidates.  In our study, we use MPC as a surrogate for judgements of query-candidate tuples.   Enumerated judgements \{1-5\} are allocated to the completions, representing \{utterly irrelevant, irrelevant, moderately relevant, relevant, highly relevant\}.   These tuples will form the basis of our LTR QAC dataset, whose ranking model will also predict candidates for `unseen' queries.The LTR dataset is constructed and formatted as follows: -

<img src="https://github.com/ColinDaly75/QAC_LTR_for_ES/assets/51714656/96cc5642-c9d1-47a6-9ddd-1f30bb6e46e3" width="500" height="400">

Figure: The LTR formatted dataset including a sample of the candidates for the ``open" query prefix.  Each candidate has an associated judgement (generated using MPC), a candidate identifier and a series of feature vectors.




# How to Run
To reproduce, simply download the code (python ipynb files) and LTR dataset (txt file).  The code was compliled using python 3 (see addional package requirements below).
The scripts can be run independently, but the logical order is 
1. search-demand-curve-enterprise-search.ipynb   (dataset analysis and prepration)




# Dependencies


  


# Acknowledgements
This research was conducted with the financial support of Science Foundation Ireland under Grant Agreement No. 13/RC/2106 P2 at the ADAPT SFI Research Centre at Trinity College Dublin. ADAPT, the SFI Research Centre for AI-Driven Digital Content Technology, is funded by Science Foundation Ireland through the SFI Research Centres Programme.

