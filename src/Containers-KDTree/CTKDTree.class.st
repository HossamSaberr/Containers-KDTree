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
