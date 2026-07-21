Class {
	#name : 'CTKDTreeBenchmarkerResult',
	#superclass : 'Object',
	#instVars : [
		'executionTime',
		'fullGCTime',
		'incrementalGCTime'
	],
	#category : 'Containers-KDTree-Benchmarks',
	#package : 'Containers-KDTree-Benchmarks'
}

{ #category : 'accessing' }
CTKDTreeBenchmarkerResult >> executionTime [
	^ executionTime
]

{ #category : 'accessing' }
CTKDTreeBenchmarkerResult >> executionTime: aDuration [
	executionTime := aDuration
]

{ #category : 'accessing' }
CTKDTreeBenchmarkerResult >> fullGCTime [
	^ fullGCTime
]

{ #category : 'accessing' }
CTKDTreeBenchmarkerResult >> fullGCTime: aDuration [
	fullGCTime := aDuration
]

{ #category : 'accessing' }
CTKDTreeBenchmarkerResult >> incrementalGCTime [
	^ incrementalGCTime
]

{ #category : 'accessing' }
CTKDTreeBenchmarkerResult >> incrementalGCTime: aDuration [
	incrementalGCTime := aDuration
]
