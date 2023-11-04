---
title: Vector Search
---

A very important point here, is that we need to be able to search in ONLY the dimensions that are defined for the query AND the neighbors.
We have to assume that our query is poorly constructed and that the data might be as well.

# Algorithms

## PCA
## OPQ
## RR
## L2-norm
## ITQ
## Pad
## IVF
## Flat
## IMI
## Product Quantization (PQ)
## RCQ
## SQ
## RQ
## LSQ
## ZnLattice
## LSH
## Refine*
## Flat*
## RFlat
## K-shingling
## W-shingling
## Word2Vec
## Minhashing
## Jaccard
## K-nearest Neighbor
## Levenshtein
## Faiss
## LSH with Random Projection
## IndexPQ
## IVFPQ
## TF-IDF
## BM-25
## Sentence-BERT
## Falconn
## rii

# Approximate Nearest Neighbor (ANN)

## ANN Oh Yeah! (ANNOY)

Bisect data into cells and create a tree of cells. Hash value is the tree path required to locate cell. Spotify is ditching this in favor of [Voyager](#voyager)

# HNSW

## Voyager

Fork of HNSW-lib created by Spotify with a lot of performance improvements.

## Winner-take-all Hash (WTAHash)
## FlyHash
### DenseFly
### FlyHash Multi-probe (FlyHash-MP)
## SimHash
### SimRank

# Data Storage

## FP8 E4M3 8-Bit Floating Point

IEEE 754 recommends E5M2 (5-bit exponent and 2-bit mantissa), but E4M3 has some advantages outlined in [FP8 Formats for Deep Learning](https://arxiv.org/abs/2209.05433). 

|               | E4M3                         |
|---------------|------------------------------|
| Exponent Bias | `7`                          |
| Infinities    | `N/A` (Can't Represent)      |
| NaN           | `bX_1111_111`                |
| Zeroes        | `bX_0000_000`                |
| Max Normal    | `bX_1111_110 = 448`          |
| Min Normal    | `bX_0001_000 = 2E-6`         |
| Max Subnormal | `bX_0000_111 = 0.875 * 2E-6` |
| Min Subnormal | `bX_0000_001 = 2E-9`         |



---

Interlaced Shadow Search

What if we create multiple low-dimensional shadows from an interlaced set of dimensions and then compare the shadows to find approximate neighbors?

Find nearest $n$ in each shadow and then take the intersection of those sets. Issue here is that there isn't guaranteed to be an intersection. Although you could probably make it greedy. Or just take the union of all the shadow comparisons and then refine it more directly. 


