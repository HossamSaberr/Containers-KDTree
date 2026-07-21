Class {
	#name : 'CTKDTree',
	#superclass : 'Object',
	#instVars : [
		'root',
		'dimensions',
		'size'
	],
	#category : 'Containers-KDTree',
	#package : 'Containers-KDTree'
}

{ #category : 'adding' }
CTKDTree >> add: aPoint [
	self assert: [ aPoint size = dimensions ] description: 'Point dimensions must match tree dimensions'.
	
	root ifNil: [ 
		root := CTKDTreeNode new point: aPoint axis: 1.
		size := size + 1.
		^ self 
	].
	
	self insert: aPoint at: root.
	size := size + 1.
]

{ #category : 'adding' }
CTKDTree >> addAll: aCollection [
	"Add all elements from the given collection to the tree"
	aCollection do: [ :each | self add: each ].
	^ self
]

{ #category : 'accessing' }
CTKDTree >> dimensions: anInteger [
	dimensions := anInteger
]

{ #category : 'searching' }
CTKDTree >> includes: aPoint [
	self assert: [ aPoint size = dimensions ] description: 'Point dimensions must match tree dimensions'.
	root ifNil: [ ^ false ].
	^ self search: aPoint at: root
]

{ #category : 'initialization' }
CTKDTree >> initialize [
	super initialize.
	size := 0.
	root := nil.
	dimensions := 2. "Default to 2D"
]

{ #category : 'private' }
CTKDTree >> insert: aPoint at: aNode [
	| currentAxis nextAxis goesLeft |
	currentAxis := aNode axis.
	"Rotate the axis"
	nextAxis := (currentAxis \\ dimensions) + 1.
	
	goesLeft := (aPoint at: currentAxis) < (aNode point at: currentAxis).
	
	goesLeft 
		ifTrue: [
			aNode left 
				ifNil: [ aNode left: (CTKDTreeNode new point: aPoint axis: nextAxis) ]
				ifNotNil: [ self insert: aPoint at: aNode left ] ]
		ifFalse: [
			aNode right 
				ifNil: [ aNode right: (CTKDTreeNode new point: aPoint axis: nextAxis) ]
				ifNotNil: [ self insert: aPoint at: aNode right ] ]
]

{ #category : 'testing' }
CTKDTree >> isEmpty [
	^ size = 0
]

{ #category : 'searching' }
CTKDTree >> nearest: aPoint [
	self assert: [ aPoint size = dimensions ] description: 'Point dimensions must match tree dimensions'.
	root ifNil: [ ^ nil ].
	^ (self nearest: aPoint at: root bestNode: root) point
]

{ #category : 'private' }
CTKDTree >> nearest: targetPoint at: currentNode bestNode: currentBest [
	| currentAxis goesLeft best axisDistance currentDistance bestDistance |
	
	currentNode ifNil: [ ^ currentBest ].
	
	best := currentBest.
	currentDistance := self squaredDistanceBetween: targetPoint and: currentNode point.
	bestDistance := self squaredDistanceBetween: targetPoint and: best point.
	
	"Update best if the current node is closer"
	currentDistance < bestDistance ifTrue: [ best := currentNode ].
	
	currentAxis := currentNode axis.
	goesLeft := (targetPoint at: currentAxis) < (currentNode point at: currentAxis).
	
	"Explore the most promising branch first"
	best := goesLeft 
		ifTrue: [ self nearest: targetPoint at: currentNode left bestNode: best ]
		ifFalse: [ self nearest: targetPoint at: currentNode right bestNode: best ].
		
	"Unwind and check if we need to explore the other branch"
	bestDistance := self squaredDistanceBetween: targetPoint and: best point.
	axisDistance := (targetPoint at: currentAxis) - (currentNode point at: currentAxis).
	
	"If the distance to the splitting plane is less than our best distance, a closer point might exist on the other side"
	(axisDistance * axisDistance) < bestDistance ifTrue: [
		best := goesLeft 
			ifTrue: [ self nearest: targetPoint at: currentNode right bestNode: best ]
			ifFalse: [ self nearest: targetPoint at: currentNode left bestNode: best ]
	].
	
	^ best
]

{ #category : 'accessing' }
CTKDTree >> root [
	^ root
]

{ #category : 'private' }
CTKDTree >> search: aPoint at: aNode [
	| currentAxis goesLeft |
	aNode ifNil: [ ^ false ].
	
	"Exact match found"
	aNode point = aPoint ifTrue: [ ^ true ].
	
	currentAxis := aNode axis.
	goesLeft := (aPoint at: currentAxis) < (aNode point at: currentAxis).
	
	^ goesLeft 
		ifTrue: [ self search: aPoint at: aNode left ]
		ifFalse: [ self search: aPoint at: aNode right ]
]

{ #category : 'accessing' }
CTKDTree >> size [
	^ size
]

{ #category : 'private' }
CTKDTree >> squaredDistanceBetween: point1 and: point2 [
	| sum diff |
	sum := 0.
	1 to: dimensions do: [ :i |
		diff := (point1 at: i) - (point2 at: i).
		sum := sum + (diff * diff)
	].
	^ sum
]
