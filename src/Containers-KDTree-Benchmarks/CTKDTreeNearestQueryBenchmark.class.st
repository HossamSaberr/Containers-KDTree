Class {
	#name : 'CTKDTreeNearestQueryBenchmark',
	#superclass : 'CTKDTreeAbstractBenchmark',
	#instVars : [
		'queryPoints'
	],
	#category : 'Containers-KDTree-Benchmarks',
	#package : 'Containers-KDTree-Benchmarks'
}

{ #category : 'running' }
CTKDTreeNearestQueryBenchmark >> run [
	queryPoints do: [ :pt | tree nearest: pt ].
]

{ #category : 'initialization' }
CTKDTreeNearestQueryBenchmark >> setUp [
	| random |
	super setUp.
	elementsCount := 100000.
	tree := CTKDTree new dimensions: 2.
	random := Random new.
	
	"Build the tree OUTSIDE the timer"
	elementsCount timesRepeat: [
		tree add: (Array 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000)) ].
	
	"generate 10,000 query points"
	queryPoints := (1 to: 10000) collect: [ :i |
		Array 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000) ]
]
