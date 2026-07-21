Class {
	#name : 'CTKDTreeInsertBenchmark',
	#superclass : 'CTKDTreeAbstractBenchmark',
	#instVars : [
		'pointsToInsert'
	],
	#category : 'Containers-KDTree-Benchmarks',
	#package : 'Containers-KDTree-Benchmarks'
}

{ #category : 'running' }
CTKDTreeInsertBenchmark >> run [
	tree addAll: pointsToInsert.
	^ self
]

{ #category : 'initialization' }
CTKDTreeInsertBenchmark >> setUp [
	| random |
	super setUp.
	elementsCount := 100000.
	tree := CTKDTree new dimensions: 2.
	random := Random new.
	
	"generate points"
	pointsToInsert := (1 to: elementsCount) collect: [ :i |
		Array 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000) ]
]
