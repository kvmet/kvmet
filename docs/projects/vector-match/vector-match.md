# Vector Match

There are many applications where we need to search through a dataset to find similar items. Simple text and tag searching is (relatively) easy in relational databases and is fairly well explored. More recently, vector databases have grown in popularity for quickly searching across a large number of dimensions to find similar entities based on proximity. These kinds of databases are very useful when paired with certain types of machine learning and their effectiveness can be amplified through the use of embeddings.

Embeddings are very useful because they can effectively reduce the number of dimensions required to represent a dataset (dimensional compression), but they have the disadvantage of not being able to freely add/remove dimensions. This property makes embeddings very useful for cases where the entire problem space is available in advance, but doesn't lend itself to cases that need "on-the-fly" addition or removal of dimensions. To deal with this limitation, one might choose to avoid embeddings and instead choose to preserve the higher dimensionality of the original data. All databases that I am aware of have a dimensionality limit of tens of thousands, which is impressively high but it is still easy to imagine cases where even higher limits would be useful.

Finally, sparseness is one of the biggest properties that limits readily available vector databases. Being able to define entities without having all dimensions described and _simultaneously_ being able to search across that data without having to provide search terms for every dimension would be valuable in many cases, but isn't an easily solveable thing. It is tempting to use straightforward hash tables, but simple hashing will quickly run into performance issues or massively high cardinalities to describe the data space. 

What I am describing is pretty much the worst case, but I just want to explore this problem and see how far I can get with it. 

## Main goals
- Unlimited dimensionality
- Unlimited sparseness of both data and search (nullable columns)
- No recalculation of existing indexes required when
    - Adding or removing datapoints
    - Adding dimensions (I expect that removing dimensions might require some cleanup)
        - Can potentially tolerate some work to add dimensions but it would really be nice to avoid
- Reasonable performance
    - I doubt this can achieve super low latency
 
## Prevailing Thoughts
- I won't be able to write a better db engine than what is already available
- My best option might be
    - Relational db for the raw data (postgres?)
    - Vector db for the embedded data (pg-vector?)
    - Periodically recalculate embeddings
 


## Topics to research
### Principal Component Analysis (PCA)
- Efficient but really only good for linear data

### t-Distributed Stochastic Neighbor Embedding (t-SNE)
- Good general purpose approach, but is computationally intensive compared to others
- Can handle linear and non-linear data reasonably well
- Emphasizes preserving pairwise similarities which is a boon for match market scenarios
    
### UMAP (Uniform Manifold Approximation and Projection)
- Good for non-linear relationships, but assumes data is uniformly distributed.
- Computationally efficient and flexible.
- Good for general purpose use and visualization
- https://umap-learn.readthedocs.io/en/latest/
- https://umap-learn.readthedocs.io/en/latest/how_umap_works.html
 
## Other Thoughts
- I don't think you can just "zero" out unused elements to buy yourself sparseness. Perhaps though you could estimate the average of a dimension and use that? The issue there is you could get interference from dimensions that you aren't interested in (two elements that are close the average in a higher dimension might cause the proximity to appear closer than it actually is?), so it might be a good thing to have as an option for faster search. If I can prove though that the total distances are still in the correct _order_ though, maybe it could work for search and then more accurate distances could be determined after the fact?
    - If I can find an effective way to do this, it would allow you to use some sort of proximity checking algorithm?
    - Fast way to estimate the average for a large dataset?
- It's probably unreasonable to expect to be able to condense everything into a single hash, so normal hashing won't really work
- I don't really have an interest in writing a whole db engine. I think my ideal case is to make something that can be integrated into postgres or sql (or something else robust and well-known) that implements a vector search on top
    - [pg-vector](https://github.com/pgvector/pgvector/) Has comparable limits to others, but could be useful as a base if we go with some sort of dimensionality compression
    - pinecone
    - (Milvus)[https://milvus.io/docs/install_standalone-docker.md]
- The goal here isn't really to make the most performant thing. I am choosing to lose some performance to gain system flexibility and overall capacity. This makes it more useful for analyzing data relevant to matching markets.
  
