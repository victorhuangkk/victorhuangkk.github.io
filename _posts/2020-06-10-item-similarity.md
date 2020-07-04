---
layout: post
title: Item Similarity Calculation Via Enhanced Graph Embedding with Side information
tags: [marketing, statistics]
comments: true
---

## Motivation
To unveil products' intrinsic similarities, I decided to develop an data mining approach combining text data and transactional data. The basic ideas are:
1. Products' description contains enough information for us to use. Compared with traditional topic modeling, the more recent word embedding approach enables us to find out intrinsic relationship between items
2. Customers tend to purchase similar products in certain categories (Fast Moving Consumer Goods).
3. The goal is to discover items' similarity, which is different from traditional recommendation's goal, who cared more about transactional similarity. For example, beer and diaper might be purchased together but they are not manufactured similarly.
And from engineering perspective, the system is designed to be scaled up easily. So, speed and robustness is more important than novelty.

## Transaction Node2Vec Embedding

By utilizing transaction data and node2vec embedding, we got the following results. Without parameter tuning, we see transaction embedding gives out better results compared with NLP. I made a few assumptions and borrowed open source frameworks to reduce the development time.

1. Transaction data was collected in this manner  
   1. Only specific subcategory was considered     
   2. Edges represent one item being purchased first and the other purchased in the later transaction. To simplify the process, starting point and ending point is different.      
   3. For instance, if user Jerry purchased dog food three times, purchased item (A, B), (A, C), (A, B, C) in each basket respectively. Then, edges would be the following:     
      1. A -> C    
      2. B -> A    
      3. B -> C    
      4. A -> B    
      5. A -> C     
      6. C -> A
      7. C -> B
   4. For Jerry, edges would be stored in a manner: (A, C): 2, (A, B): 1, (B, A): 1, (B, C): 1, (C, A): 1, (C, B): 1
   5. Repeat step 3, 4 to exhaust all users
2. Currently, I used networkX (a python implementation of graph structure) and node2vec (implemented node2vec by gensim word2vec)
3. Parameters were not tuned for now. The final results might be better by changing parameters


## Natural Language Processing and Word2Vec Embedding

I utilized gensim's functionality to compute product description's similarity between products. Currently, doc2vec is used. But for better embedding, we may use BERT model in the next round. I found a service called Jina but, which expose BERT as a web service, good for large scale deployment. Here are a few technical details:

1. Standard text processing has been done for string cleaning process.
2. Only specific subcategory has been selected. And one thing interesting is that there are more records in the product table than in the transaction table. I haven't dig into that yet, but my guess is that some products might not available.
3. I adopted paragraph embedding in the embedding part, details might be retrieved at.
4. Cosine similarity was used to calculated distance between two products' description records.


## Weighted Pooling and Item Similarity Calculation
There are multiple ways to combine embedding layers together. I listed a few in the reference section. We finally ended up using simple mean to combine embedding layers. That main reason is this approach is simple and easy to scale up. Even we lost some mathematical interpretation, we don't have to manually tune weights for each subcategory. Embedding layers perceived more similar information would gain more weights.


## Reference:
I borrowed a lot from others' previous work. Here are the original sources:
1. [Document Embedding](https://arxiv.org/pdf/1405.4053v2.pdf)
2. [NetworkX](https://networkx.github.io/documentation/latest/)
3. [Node2Vec](https://github.com/aditya-grover/node2vec)
4. [Gensim Word2Vec](https://radimrehurek.com/gensim/models/word2vec.html)
5. [Gensim Doc2Vec](https://radimrehurek.com/gensim/models/doc2vec.html)
6. [Embedding Averging](https://arxiv.org/abs/1804.05262)
7. [EGES Paper](https://arxiv.org/pdf/1803.02349.pdf)
