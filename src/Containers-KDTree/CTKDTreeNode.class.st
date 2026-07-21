Class {
	#name : 'CTKDTreeNode',
	#superclass : 'Object',
	#instVars : [
		'point',
		'left',
		'right',
		'axis'
	],
	#category : 'Containers-KDTree',
	#package : 'Containers-KDTree'
}

{ #category : 'accessing' }
CTKDTreeNode >> axis [
	^ axis
]

{ #category : 'testing' }
CTKDTreeNode >> isLeaf [
	^ left isNil and: [ right isNil ]
]

{ #category : 'accessing' }
CTKDTreeNode >> left [
	^ left
]

{ #category : 'accessing' }
CTKDTreeNode >> left: aNode [
	left := aNode
]

{ #category : 'accessing' }
CTKDTreeNode >> point [
	^ point
]

{ #category : 'initialization' }
CTKDTreeNode >> point: aPoint axis: anInteger [
	point := aPoint.
	axis := anInteger.
	left := nil.
	right := nil.
]

{ #category : 'accessing' }
CTKDTreeNode >> right [
	^ right
]

{ #category : 'accessing' }
CTKDTreeNode >> right: aNode [
	right := aNode
]
