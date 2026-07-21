# Containers-KDTree

A high-performance **K-D Tree** (K-Dimensional Tree) for Pharo that supports arbitrary dimensional spaces (2D, 3D, 4D, N-D). It provides exact match lookups and nearest-neighbor spatial queries with average $O(\log N)$ time complexity.

![Pharo 14+](https://img.shields.io/badge/Pharo-14%2B-informational) ![License MIT](https://img.shields.io/badge/License-MIT-success)

---

## What is a K-D Tree?

In standard data structures, searching for a specific value in a one-dimensional list is easily optimized using a Binary Search Tree. However, when working with multi-dimensional data (such as 2D coordinates on a map or 3D points in a spatial simulation), standard search trees fail to efficiently calculate distances across multiple axes.

A **K-D Tree** solves this by cycling through the dimensions as you traverse deeper into the tree, partitioning space into distinct hyperplanes. This spatial indexing allows the algorithm to aggressively prune branches that are mathematically too far away to contain a nearest neighbor. This guarantees average $O(\log N)$ complexity for spatial queries, making it ideal for computational geometry, robotics point-cloud processing, and location-based services without the overhead of scanning every point in $O(N)$ time.

---

## Loading

To install `Containers-KDTree`, open the Playground (`Ctrl + O + W`) in your Pharo image and execute the following Metacello script:

```smalltalk
Metacello new
  baseline: 'ContainersKDTree';
  repository: 'github://pharo-containers/Containers-KDTree/src';
  load.
```

### If you want to depend on it

Add the following snippet to your own Metacello baseline:

```smalltalk
spec
  baseline: 'ContainersKDTree'
  with: [ spec repository: 'github://pharo-containers/Containers-KDTree/src' ].
```

---

## Basic Usage

```smalltalk
"Initialize a standard 2D tree"
tree := CTKDTree new.

"Or initialize a 3D tree for spatial mapping"
tree3D := CTKDTree new dimensions: 3.

"Add individual spatial points in O(log N)"
tree add: #(2 3).
tree add: #(5 4).
tree add: #(9 6).

"Find the single nearest neighbor to a query point in O(log N)"
tree nearest: #(9 2). "=> #(9 6)"

"Find the K nearest neighbors, returned sorted by closest distance"
tree nearest: #(9 2) k: 2. "=> An array of the 2 closest points"

"Check if a specific point exists in O(log N)"
tree includes: #(5 4). "=> true"
tree includes: #(1 1). "=> false"

"Check if the tree contains data"
tree isNotEmpty. "=> true"
```

### Building
You can build the tree efficiently from an existing collection of points:

```smalltalk
tree := CTKDTree new.
tree addAll: { #(4 7) . #(8 1) . #(7 2) }.
```

### Duplicate Handling
The tree fully supports duplicate points. Inserting identical coordinates will create distinct, valid nodes within the tree, and all duplicates will be evaluated normally during nearest-neighbor spatial queries.


### Safety & Error Handling
The tree enforces strict dimensionality and state checks to prevent silent failures during spatial computations.

```smalltalk
tree3D add: #(2 3). "Throws Error: Dimension mismatch. Expected 3D point."

emptyTree := CTKDTree new.
emptyTree nearest: #(1 1). "Throws CollectionIsEmpty Error"
```

---

## Time & Space Complexity

| Operation | Average Time Complexity | Space Complexity |
| :--- | :--- | :--- |
| `addAll:` (Bulk Build) | $O(N \log N)$ | $O(N)$ |
| `add:` | $O(\log N)$ | $O(1)$ per node |
| `includes:` | $O(\log N)$ | $O(1)$ |
| `nearest:` | $O(\log N)$ | $O(1)$ |
| `nearest:k:`| $O(\log N)$ | $O(K)$ |
| **Memory footprint** | | **$O(N)$ Nodes** |

**Performance Note:** This implementation follows the standard incremental KD-tree insertion algorithm and **does not automatically rebalance** the tree. The $O(\log N)$ search complexity assumes a randomized or reasonably balanced insertion order. Inserting pre-sorted data will cause the tree to become unbalanced, degrading traversal performance toward $O(N)$. For static datasets, use `addAll:` with randomized data to ensure optimal spatial partitioning.

---

## Performance & Empirical Proof

Benchmarks measure the core tree construction and multi-dimensional query operations in isolation. By optimizing the traversal logic and dynamically managing bounded priority queues for K-nearest queries, the garbage collection (GC) overhead is minimized.

| Workload | Execution Time (ms) | Full GC Time | Incremental GC Time |
| :--- | :--- | :--- | :--- |
| **100,000 Insertions** *(Bulk)* | 97.762 ms | 0.0 ms | 24.0 ms |
| **10,000 Nearest Queries** *(100k Grid)* | 49.076 ms | 0.0 ms | 3.0 ms |
| **10,000 K-Nearest Queries** *(K=5, 100k Grid)* | 116.952 ms | 0.0 ms | 10.0 ms |
| **Robotics Simulation** *(1k Queries vs 50k 3D Map)* | 12.517 ms | 0.0 ms | 0.0 ms |
| **Location Services** *(5k Queries vs 100k 2D Grid)*| 34.396 ms | 0.0 ms | 0.0 ms |

**Conclusion:** The optimized spatial distance pruning allows tens of thousands of complex nearest-neighbor and bounded K-nearest calculations to execute in a fraction of a second. The 0.0 ms Full GC times across all query benchmarks prove a highly stable memory footprint with zero mid-traversal garbage collection stalls.

---

## Contributing

This library is part of the [Pharo Containers](https://github.com/pharo-containers) project. Contributions are welcome, whether implementing additional functional combinators, improving test coverage, or enhancing documentation. Please open an issue or pull request on GitHub.