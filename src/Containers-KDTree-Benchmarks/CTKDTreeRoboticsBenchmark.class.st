Class {
	#name : 'CTKDTreeRoboticsBenchmark',
	#superclass : 'CTKDTreeAbstractBenchmark',
	#category : 'Containers-KDTree-Benchmarks',
	#package : 'Containers-KDTree-Benchmarks'
}

{ #category : 'running' }
CTKDTreeRoboticsBenchmark >> run [
	"Simulate a robot moving and querying its nearest obstacle 1,000 times"
	| random sensorQuery |
	random := Random new.
	
	1000 timesRepeat: [
		sensorQuery := Array 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000).
		tree nearest: sensorQuery.
	]
]

{ #category : 'initialization' }
CTKDTreeRoboticsBenchmark >> setUp [
	| random |
	super setUp.
	elementsCount := 50000. "50k points in the 3D map"
	tree := CTKDTree new dimensions: 3.
	random := Random new.
	
	elementsCount timesRepeat: [
		tree add: (Array 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000) 
			with: (random nextInteger: 10000))
	].
]
