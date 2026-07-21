Class {
	#name : 'CTKDTreeAbstractBenchmark',
	#superclass : 'Object',
	#instVars : [
		'tree',
		'elementsCount'
	],
	#category : 'Containers-KDTree-Benchmarks',
	#package : 'Containers-KDTree-Benchmarks'
}

{ #category : 'running' }
CTKDTreeAbstractBenchmark >> run [
	^ self subclassResponsibility
]

{ #category : 'initialization' }
CTKDTreeAbstractBenchmark >> setUp [
	tree := CTKDTree new.
	elementsCount := 10000.
]
