Class {
	#name : 'CTKDTreeTest',
	#superclass : 'TestCase',
	#instVars : [
		'tree'
	],
	#category : 'Containers-KDTree-Tests',
	#package : 'Containers-KDTree-Tests'
}

{ #category : 'running' }
CTKDTreeTest >> setUp [
	super setUp.
	tree := CTKDTree new. "Defaults to 2D"
]

{ #category : 'tests' }
CTKDTreeTest >> test10Dimensions [
	| tree10D p1 p2 p3 |
	tree10D := CTKDTree new dimensions: 10.
	p1 := #(1 2 3 4 5 6 7 8 9 10).
	p2 := #(10 9 8 7 6 5 4 3 2 1).
	p3 := #(1 2 3 4 5 6 7 8 9 11). "Very close to p1"

	tree10D add: p1; add: p2; add: p3.
	
	self assert: tree10D size equals: 3.
	self assert: (tree10D includes: p2).
	
	"A point slightly offset from p1 and p3. p3 is still closest"
	self assert: (tree10D nearest: #(1 2 3 4 5 6 7 8 9 12)) equals: p3.
]

{ #category : 'tests' }
CTKDTreeTest >> test3DPoints [
	| tree3D |
	tree3D := CTKDTree new dimensions: 3.
	tree3D add: #(2 3 1).
	tree3D add: #(5 4 2).
	tree3D add: #(9 6 7).
	tree3D add: #(4 7 9).
	tree3D add: #(8 1 5).
	tree3D add: #(7 2 6).

	self assert: tree3D size equals: 6.
	self assert: (tree3D includes: #(4 7 9)).
	self deny: (tree3D includes: #(4 7 8)).

	"Nearest to (9 2 5)
	Dist to (8,1,5) = 1^2 + 1^2 + 0^2 = 2
	Dist to (7,2,6) = 2^2 + 0^2 + 1^2 = 5
	Closest should be (8 1 5)"
	self assert: (tree3D nearest: #(9 2 5)) equals: #(8 1 5).
]

{ #category : 'tests' }
CTKDTreeTest >> testAddAndSize [
	tree add: #(2 3).
	self assert: tree size equals: 1.
	self deny: tree isEmpty.
	
	tree add: #(5 4).
	tree add: #(9 6).
	self assert: tree size equals: 3.
]

{ #category : 'tests' }
CTKDTreeTest >> testCollinearPoints [
	tree add: #(5 5).
	tree add: #(5 2).
	tree add: #(5 8).
	tree add: #(5 1).
	tree add: #(5 9).

	self assert: tree size equals: 5.
	self assert: (tree includes: #(5 8)).
	
	"Query: (4 7). Closest should be (5 8)"
	self assert: (tree nearest: #(4 7)) equals: #(5 8).
	
	"Query: (10 2). Closest should be (5 2)"
	self assert: (tree nearest: #(10 2)) equals: #(5 2).
]

{ #category : 'tests' }
CTKDTreeTest >> testDimensionMismatchThrowsError [
	tree add: #(2 3).
	
	"Adding a 3D point to a 2D tree"
	self should: [ tree add: #(1 2 3) ] raise: AssertionFailure.
	
	"Querying a 1D point in a 2D tree"
	self should: [ tree includes: #(1) ] raise: AssertionFailure.
	self should: [ tree nearest: #(1) ] raise: AssertionFailure.
]

{ #category : 'tests' }
CTKDTreeTest >> testDuplicateInsertions [
	| results |
	
	"Insert the exact same point three times"
	tree add: #(5 5).
	tree add: #(5 5).
	tree add: #(5 5).
	
	"Prove the tree actually created three distinct nodes"
	self assert: tree size equals: 3.
	
	"Prove that a spatial query can successfully retrieve all duplicates"
	results := tree nearest: #(5 5) k: 3.
	
	self assert: results size equals: 3.
	self assert: results first equals: #(5 5).
	self assert: results second equals: #(5 5).
	self assert: results third equals: #(5 5).
]

{ #category : 'tests' }
CTKDTreeTest >> testDuplicates [
	tree add: #(2 3).
	tree add: #(2 3). 
	tree add: #(5 4).

	self assert: tree size equals: 3.
	self assert: (tree includes: #(2 3)).
	self assert: (tree nearest: #(2 3)) equals: #(2 3).
]

{ #category : 'tests' }
CTKDTreeTest >> testEmptyTree [
	self assert: tree isEmpty.
	self assert: tree size equals: 0.
	self deny: (tree includes: #(1 1)).
	self assert: (tree nearest: #(1 1)) isNil.
]

{ #category : 'tests' }
CTKDTreeTest >> testExactPointAsNearest [
	tree add: #(2 3).
	tree add: #(5 4).
	tree add: #(9 6).

	self assert: (tree nearest: #(5 4)) equals: #(5 4).
	self assert: (tree nearest: #(9 6)) equals: #(9 6).
]

{ #category : 'tests' }
CTKDTreeTest >> testIncludes [
	tree add: #(2 3).
	tree add: #(5 4).
	tree add: #(9 6).
	tree add: #(4 7).
	tree add: #(8 1).
	tree add: #(7 2).
	
	self assert: (tree includes: #(5 4)).
	self assert: (tree includes: #(9 6)).
	self assert: (tree includes: #(8 1)).
	
	"Should fail for coordinates not in the tree"
	self deny: (tree includes: #(2 4)).
	self deny: (tree includes: #(8 2)).
]

{ #category : 'tests' }
CTKDTreeTest >> testNearest [
	tree add: #(2 3).
	tree add: #(5 4).
	tree add: #(9 6).
	tree add: #(4 7).
	tree add: #(8 1).
	tree add: #(7 2).
	
	"Query point: (9 2)"
	"Distance to (8,1) = 1^2 + 1^2 = 2"
	"Distance to (7,2) = 2^2 + 0^2 = 4"
	"Closest should be (8 1)"
	self assert: (tree nearest: #(9 2)) equals: #(8 1).
	
	"Query point: (2 2), Closest should be (2 3)"
	self assert: (tree nearest: #(2 2)) equals: #(2 3).
	
	"Query point: (4 5)"
	"Distance to (5,4) = 1^2 + -1^2 = 2"
	"Distance to (4,7) = 0^2 + -2^2 = 4"
	"Closest should be (5 4)"
	self assert: (tree nearest: #(4 5)) equals: #(5 4).
]

{ #category : 'tests' }
CTKDTreeTest >> testNearestK [
	| results |
	"load 7 distinct points"
	tree addAll: { #(1 1). #(2 3). #(5 4). #(9 6). #(4 7). #(8 1). #(7 2) }.
	
	"Query the 3 nearest neighbors to (3, 3)"
	results := tree nearest: #(3 3) k: 3.
	
	"Expected order based on squared distances to (3,3):" 
	 "1. (2,3) -> distance 1"
	 "2. (5,4) -> distance 5"
	 "3. (1,1) -> distance 8"
	
	self assert: results size equals: 3.
	self assert: results first equals: #(2 3).
	self assert: results second equals: #(5 4).
	self assert: results third equals: #(1 1).
]

{ #category : 'tests' }
CTKDTreeTest >> testNearestKLargerThanTree [
	| results |
	tree addAll: { #(1 1). #(2 2). #(3 3) }.
	
	"Requesting 5 neighbors from a tree that only has 3 points"
	results := tree nearest: #(0 0) k: 5.
	
	"It should safely return all 3 points, sorted by distance, without crashing"
	self assert: results size equals: 3.
	self assert: results first equals: #(1 1).
	self assert: results second equals: #(2 2).
	self assert: results third equals: #(3 3).
]

{ #category : 'tests' }
CTKDTreeTest >> testNearestRequiresBacktracking [
	"Forces the algorithm to cross the splitting plane to find the true nearest neighbor"
	tree add: #(50 50). "Root, splits on X"
	tree add: #(20 50). "Left child"
	tree add: #(80 50). "Right child"
	tree add: #(45 60). "Left child's right child"

	"Query: (52 60)"
	"Greedily, it will go right to (80 50) because 52 > 50"
	"But (45 60) is much closer! It must cross the X=50 plane to find it"
	self assert: (tree nearest: #(52 60)) equals: #(45 60).
]

{ #category : 'tests' }
CTKDTreeTest >> testNegativeCoordinates [
	tree add: #(-2 -3).
	tree add: #(-5 4).
	tree add: #(9 -6).

	self assert: (tree includes: #(-5 4)).
	self assert: (tree nearest: #(-3 -4)) equals: #(-2 -3).
	self assert: (tree nearest: #(8 -5)) equals: #(9 -6).
]

{ #category : 'tests' }
CTKDTreeTest >> testRandomizedPointsAgainstNaiveSearch [
	| random points queryPoint bruteForceClosest minDistance currentDist kdClosest |
	random := Random new.
	points := OrderedCollection new.
	
	500 timesRepeat: [
		| pt |
		pt := Array with: (random nextInteger: 1000) with: (random nextInteger: 1000).
		points add: pt.
		tree add: pt.
	].
	
	queryPoint := Array with: (random nextInteger: 1000) with: (random nextInteger: 1000).
	
	minDistance := Float infinity.
	bruteForceClosest := nil.
	points do: [ :pt |
		currentDist := ((pt first - queryPoint first) squared) + ((pt second - queryPoint second) squared).
		currentDist < minDistance ifTrue: [
			minDistance := currentDist.
			bruteForceClosest := pt.
		]
	].
	
	kdClosest := tree nearest: queryPoint.
	
	self assert: kdClosest equals: bruteForceClosest.
]
