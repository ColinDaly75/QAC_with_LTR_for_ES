# Learning to Rank for Query Auto-Complete with Language Modelling for Enterprise Search.
-----------------------------------------------------------------------------------

Contact: dalyc24@tcd.ie

-----------------------------------------------------------------------------------
## Abstract
Query auto-completion (QAC) is of particular importance to the field of Enterprise Search, where query suggestions can prompt searchers to use the appropriate organisational jargon/phraseology and avoid submitting
queries that produce no results. The order in which QAC candidates are presented to users (for a given prefix) can be influenced by signals, such as how often the prefix appears in the corpus, most popular completions, most frequently queried, anchor text and other fields of a document, or what queries are currently trending in the organisation. We measure the individual contribution of each of these heuristic ranking signals, which
can be combined and supplemented with predictions generated using a generic large language model (LLM) ‘tuned’ with an Enterprise Search corpus. We use Learning To Rank (LTR) to combine these signals and
predictions to create a QAC ranking model for a ‘live’ Enterprise Search service. In an online A/B test, our preliminary results show that the addition of the jargon/phraseology detection LLM feature to the heuristic LTR model results in an increase of 4% to the Mean Reciprocal Rank score.

## Analysis & Experiments
This project analyses the the use of Learning to Rank for Query Auto-Complete suggestions on a ’real world’ Enterprise Search (ES) service of a large organisation.

###  LTR Weighting Calculation



### MRR Calculations
The Reciprocal Rank (RR) of a query response is the multiplicative inverse of the rank of the first correct answer: 1 for first place, 1⁄3 for third place, or zero if the submitted query is not present in the ranked list~\cite{singh2023}. The mean reciprocal rank is the average of the RR results for a sample of queries Q:

$$ MRR = \frac  {1}{|Q|} \sum_{{i=1}}^{{|Q|}}{\frac  {1}{{{rank}}_{i}}} $$


where $rank_{i}$ refers to the rank position of the first relevant document for the $i^{th}$ query. MRR only considers the rank of the first relevant candidate (if there are further relevant candidates, they are ignored).

The MRR calculations are shown in the [mrr-enterprise-search.ipynb](https://github.com/ColinDaly75/QAC_LTR_for_ES/blob/main/mrr-enterprise-search.ipynb) script.


### Experiment :  Offline evaluation of QAC ranking performance using MRR
We use the CTR values in place of human relevance judgements are recreate our learning to rank model.   This involves subsitiuting the CTR values into the first column of the LTR dataset.   The nDCG values are calculated using 
- human relevance judgements and 
- clickthrough rate.

# Dataset
We generate and publish a small manually annotated LTR dataset (ENTRP-SRCH.txt) that includes both kinds of feedback as well as a number of features used for learning to rank.  The LTR dataset is formatted as follows: -
![LETOR_format_diagram-with-clickthroughrate](https://user-images.githubusercontent.com/51714656/184387570-87e33de2-a985-4d8f-8a71-4cd7f43bb87a.png)

# How to Run
The attached dataset and code were used to perform correlation and ranking performance tests.  To reproduce, simply download the code (python ipynb files) and LTR dataset (txt file).  It was compliled using python 3 and requires the installation (pip3) of datapane,jinja2 and scipy packages.
The two scripts can be run independently, but the logical order is 
1. ES-LTR-explicit-implicit-correlation.ipynb
2. ES-LTR-ranking-performance.ipynb  (simply change the judgements variable to 'HUMAN' or 'CTR')



# Citation
```
FOR EXAMPLE:
@inproceedings{dalyc2024a,
	title={Learning to Rank for Query Auto-Complete with Language Modelling
for Enterprise Search.},
	author={Daly, C. and Hederman, L.},
	booktitle={KDIR 2024 : 16th International Conference on Knowledge Discovery and Information Retrieval},
	year={2024},
	organization={IEEE}
}
```


# Dependencies
- [Tensorflow](https://www.tensorflow.org) >= 1.4
- [Python](https://www.python.org) >= 3.5
- [numpy](https://numpy.org)
- [sklearn](https://scikit-learn.org)
  


# Acknowledgements
This research was conducted with the financial support of Science Foundation Ireland under Grant Agreement No. 13/RC/2106 P2 at the ADAPT SFI Research Centre at Trinity College Dublin. ADAPT, the SFI Research Centre for AI-Driven Digital Content Technology, is funded by Science Foundation Ireland through the SFI Research Centres Programme.
