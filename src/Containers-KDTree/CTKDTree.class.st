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

{ #category : 'initialization' }
CTKDTree >> initialize [
	super initialize.
	size := 0.
	root := nil.
	dimensions := 2. "Default to 2D"
]

{ #category : 'testing' }
CTKDTree >> isEmpty [
	^ size = 0
]

{ #category : 'accessing' }
CTKDTree >> root [
	^ root
]

{ #category : 'accessing' }
CTKDTree >> size [
	^ size
]
