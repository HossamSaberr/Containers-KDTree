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
CTKDTreeTest >> testAddAndSize [
	tree add: #(2 3).
	self assert: tree size equals: 1.
	self deny: tree isEmpty.
	
	tree add: #(5 4).
	tree add: #(9 6).
	self assert: tree size equals: 3.
]

{ #category : 'tests' }
CTKDTreeTest >> testEmptyTree [
	self assert: tree isEmpty.
	self assert: tree size equals: 0.
	self deny: (tree includes: #(1 1)).
	self assert: (tree nearest: #(1 1)) isNil.
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
