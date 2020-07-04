---
layout: post
title: Item Similarity Calculation Via Enhanced Graph Embedding with Side information
tags: [marketing, statistics]
comments: true
---

## Motivation
To understand customer

## Transaction Node2Vec Embedding

By utilizing transaction data and node2vec embedding, we got the following results. Without parameter tuning, we see transaction embedding gives out better results compared with NLP. I made a few assumptions and borrowed open source frameworks to reduce the development time.

1. Transaction data was collected in this manner  
   1. Only dog food subcategory was considered     
   2. Edges represent one item being purchased first and others purchased in the later transaction. Each edges starting point and ending point must be different     
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

## Weighted Pooling and Item Similarity Calculation
