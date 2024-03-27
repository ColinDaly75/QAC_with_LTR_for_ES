# Learning to Rank for Query Auto-Complete with Language Modelling
for Enterprise Search.
-----------------------------------------------------------------------------------

Contact: dalyc24@tcd.ie

-----------------------------------------------------------------------------------

## Analysis & Experiments
This project analyses the the use of Learning to Rank for Query Auto-Complete suggestions on a ’real world’ Enterprise Search (ES) service of a large organisation.

###  LTR Weighting Calculation
We investigate the correlation between a) human relevance judgements and b) clickthrough rate (CTR) in a learning to rank dataset.

The click-through rate (CTR) is generally defined as the percentage of the number of clicks to the number of impressions.  For the purposes of this study, we calculate the CTR for document, d, and query, q, as follows: - 

$$ CTR_{(q,d)} = {\frac{ clicks_{(q,d)}}{impressions_{(q,d)}}} $$

where impressions is the sum of clicks for all documents returned for q.  A high CTR indicates that users find the document within the listings as helpful and relevant for the given query.  For example, a document with a CTR value of 0.26 means that 26% of the end-users selected that document for the given query.

The metric used to calculate the correlation is the Spearman correlation coefficient. 

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
