---
title: Determining Similarity
---

`Cosine Similarity` is probably the most reasonable to use at scale for vectors with high dimensionality, but I included other methods because they are interesting to compare. Keep in mind that unused dimensions probably need to be ignored if you don't want them to contribute to the result.

# Cosine Similarity / Distance

Similarity metric based on the angular difference between two vectors. The result of `Cosine Similarity` is a value between -1 and 1, with 1 being the most similar. `Cosine Distance` shifts this value so that it is between 0 and 2, with 2 being the least similar.

$$
\text{Cosine Similarity}
= S_{\cos}(A,B)
:= \frac{A \cdot B}{||A|| \space ||B||}
= \frac{\displaystyle\sum_{i=1}^{n} a_i b_i}{\sqrt{\displaystyle\sum_{i=1}^n a_i^2}\cdot \sqrt{\displaystyle\sum_{i=1}^n b_i^2}}
$$

$$
\text{Cosine Distance} = D_{\cos}(A,B) := 1 - S_C(A,B)
$$

# Taxicab Distance (Manhattan Distance)

The sum of the amount of travel required in each dimension in order to move from one vector to the other. Simplistic version of distance but also a bit easier to compute than `Euclidian Distance`.

$$
\text{Taxicab Distance} = D_1(A,B) := {{||A - B||}_T}
$$

$$
= {\sum_{i=1}^n {|a_i - b_i|}}
$$

# Euclidian Distance (Pythagorean Theorem)

The shortest possible path is a straight line. Effective similarity metric but somewhat expensive to compute.

$$
\text{Euclidian Distance} = D_2(A,B) := ||A - B||
= \sqrt{\sum_{i=1}^n (a_i - b_i)^2}
$$

# Chebyshev Distance

The magnitude of the distance in the dimension where the furthest travel is required.

$$
\text{Chebyshev Distance} = D_{\infty}(A,B) = \max_i(|a_i - b_i|)
$$

# Minkowski Distance

Generalized distance metric. Equivalent to:

- `Manhattan Distance` when $p = 1$
- `Euclidian Distance` when $p=2$
- `Chebyshev Distance` when $p\to\infty$
- $D_{\infty}(A,B) \leq D_2(A,B) \leq D_1(A,B)$

$$
  \text{Minkowski Distance} = D_p(A,B) := \Big(\sum_{i=1}^n |a_i - b_i|^p\Big)^\frac{1}{p}
$$

# SimRank

If you have a graph of nearest neighbors, you can rank them by similarity to each other.

# Searching for Similar Vectors

Index and sort vectors by similarity to "Landmark" vectors? (What I was looking for is Random Projection. More notes will follow.)
 