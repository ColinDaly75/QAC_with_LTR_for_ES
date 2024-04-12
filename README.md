# Learning to Rank for Query Auto-Complete with Language Modelling for Enterprise Search.
-----------------------------------------------------------------------------------

Contact: email redacted
<!-- Contact: dalyc24@tcd.ie  -->

-----------------------------------------------------------------------------------
## Intro
The code outlined in this repository pertains to the field of Query Auto-Completion (QAC) in the domain of Enterprise Search (ES).   This code accompanies my paper entitled "**Learning to Rank for Query Auto-Complete with Language Modelling for Enterprise Search.**"


## Analysis & Experiments
This project analyses the the use of Learning to Rank for Query Auto-Complete suggestions on a ’real world’ Enterprise Search (ES) service of a large organisation.

### Dataset
We generate a small LTR QAC dataset. Most Popular Completions(MPC) is widely used as a QAC baseline and can be regarded as an approximate maximum likelihood estimator ~\cite{li-google-2017,yadav2021}. MPC is limited by its dependence on historical data and cannot make predictions about the popularity of future query candidates.  In our study, we use MPC as a surrogate for judgements of query-candidate tuples.   Enumerated judgements \{1-5\} are allocated to the completions, representing \{utterly irrelevant, irrelevant, moderately relevant, relevant, highly relevant\}.   These tuples will form the basis of our LTR QAC dataset, whose ranking model will also predict candidates for `unseen' queries.The LTR dataset is constructed and formatted as follows: -

<img src="https://github.com/ColinDaly75/QAC_LTR_for_ES/assets/51714656/d32fd4eb-f7a5-4198-a371-bcf05c88a49a" width="500" height="400">

Figure: The LTR formatted dataset including a sample of the candidates for the ``tim" query prefix.  Each candidate has an associated judgement (generated using MPC), a candidate identifier and a series of feature vectors.


### Search Demand Curve
The search demand curve below shows the outsize impact that a small number of popular queries has on the overall volume of search activity. In our enterprise search query logs, we see that the same 65 queries account for 18.5% of all search volume. 


<img src="https://github.com/ColinDaly75/QAC_LTR_for_ES/assets/51714656/60b77712-58df-4141-80fe-6b296886156c" width="700" height="500">

Figure: Search Demand Curve for Enterprise Search, showing the so-called 'Fat Head', 'Chunky Middle' and 'Long Tail' zones.  For our ES dataset, the most popular 65 queries represent 18.5\% of all search volume.

Here is the code used to generate my Search Demand Curve [search-demand-curve-enterprise-search.ipynb](https://github.com/ColinDaly75/QAC_LTR_for_ES/blob/main/search-demand-curve-enterprise-search.ipynb)

### QACES
LLMs, such as OpenAI's GPT (Generative Pre-trained Transformer) models, are trained on large datasets containing vast amounts of text from diverse sources.  Word embeddings (e.g., Word2Vec, GloVe) can capture semantic relationships between words in text data.  While LLMs and embeddings are regularly used in e-commerce~\cite{singh2023} and commercial search engines~\cite{li-google-2017}, their use for ES has not been sufficiently explored.  In this paper, we introduce a ranking feature explicitly designed for ES.  We call this `QACES' (Query Auto-Complete for Enterprise Search).   This feature is centred on the unusualness of words, such as those used in a specific organisation's jargon/phraseology.

Here is the code for QACES detection [es-llm-jargon.ipynb](https://github.com/ColinDaly75/QAC_LTR_for_ES/blob/main/es-llm-jargon.ipynb)




###  LTR Weighting Calculation
In the Figure below, the typed "aca" prefix presents a list of completion choices via a ranked list of query candidates. Candidates are sourced from various features, each of which is `weighted' using LTR.

<img src="https://github.com/ColinDaly75/QAC_LTR_for_ES/assets/51714656/9fed8c16-992d-4219-b0d3-2e519e93735c" width="600" height="300">



### MRR Calculations
The Reciprocal Rank (RR) of a query response is the multiplicative inverse of the rank of the first correct answer: 1 for first place, 1⁄3 for third place, or zero if the submitted query is not present in the ranked list~\cite{singh2023}. The mean reciprocal rank is the average of the RR results for a sample of queries Q:

$$ MRR = \frac  {1}{|Q|} \sum_{{i=1}}^{{|Q|}}{\frac  {1}{{{rank}}_{i}}} $$


where $rank_{i}$ refers to the rank position of the first relevant document for the $i^{th}$ query. MRR only considers the rank of the first relevant candidate (if there are further relevant candidates, they are ignored).

The MRR calculations are genated by this code [mrr-enterprise-search.ipynb](https://github.com/ColinDaly75/QAC_LTR_for_ES/blob/main/mrr-enterprise-search.ipynb).


### Experiment :  Offline evaluation of QAC ranking performance using MRR with Ablation Analysis
Ablation/leave-one-out analysis showing the contribution of individual features to the MRR performance across the QAC ranking models.  In the Figure below, the red line represents the cumulative total MRR score as each feature is added.

<img src="https://github.com/ColinDaly75/QAC_LTR_for_ES/assets/51714656/dcdfeb73-3548-4e5a-93b2-a21cd785b049" width="600" height="400">

The ablation plot above is genated by this code [mrr-enterprise-search.ipynb](https://github.com/ColinDaly75/QAC_LTR_for_ES/blob/main/mrr-enterprise-search.ipynb).



# How to Run
To reproduce, simply download the code (python ipynb files) and LTR dataset (txt file).  The code was compliled using python 3 (see addional package requirements below).
The scripts can be run independently, but the logical order is 
1. search-demand-curve-enterprise-search.ipynb   (dataset analysis and prepration)
2. es-llm-jargon.ipynb                           (detects 'Divergent Terms' used by organisations)
3. mrr-enterprise-search.ipynb			 (evaluation ranking model)



# Citation
<!--
```
@inproceedings{dalyc2024a,
	title={Learning to Rank for Query Auto-Complete with Language Modelling
for Enterprise Search.},
	author={Daly, C. and Hederman, L.},
	booktitle={KDIR 2024 : 16th International Conference on Knowledge Discovery and Information Retrieval},
	year={2024},
	organization={IEEE}
}
```
-->


# Dependencies
- python = 3.8
- [Tensorflow](https://www.tensorflow.org) >= 1.4
- [Python](https://www.python.org) >= 3.5
- [numpy](https://numpy.org)
- [sklearn](https://scikit-learn.org)
- [openai]{https://pypi.org/project/openai/) = 1.16.1

  


# Acknowledgements
redacted
<!-- This research was conducted with the financial support of Science Foundation Ireland under Grant Agreement No. 13/RC/2106 P2 at the ADAPT SFI Research Centre at Trinity College Dublin. ADAPT, the SFI Research Centre for AI-Driven Digital Content Technology, is funded by Science Foundation Ireland through the SFI Research Centres Programme.
-->
