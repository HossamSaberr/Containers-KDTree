Class {
	#name : 'CTKDTreeLocationServicesBenchmark',
	#superclass : 'CTKDTreeAbstractBenchmark',
	#category : 'Containers-KDTree-Benchmarks',
	#package : 'Containers-KDTree-Benchmarks'
}

{ #category : 'running' }
CTKDTreeLocationServicesBenchmark >> run [
	"Simulate 5,000 users opening the app and finding their nearest driver"
	| random userLocation |
	random := Random new.
	
	5000 timesRepeat: [
		userLocation := Array 
			with: (random nextInteger: 50000) 
			with: (random nextInteger: 50000).
		tree nearest: userLocation.
	]
]

{ #category : 'initialization' }
CTKDTreeLocationServicesBenchmark >> setUp [
	| random |
	super setUp.
	elementsCount := 100000. "100k active drivers"
	tree := CTKDTree new dimensions: 2.
	random := Random new.
	
	elementsCount timesRepeat: [
		tree add: (Array 
			with: (random nextInteger: 50000) 
			with: (random nextInteger: 50000))
	].
]
