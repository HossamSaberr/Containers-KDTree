Class {
	#name : 'BaselineOfContainersKDTree',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersKDTree',
	#package : 'BaselineOfContainersKDTree'
}

{ #category : 'baselines' }
BaselineOfContainersKDTree >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'Containers-KDTree';
			package: 'Containers-KDTree-Tests' with: [ spec requires: #('Containers-KDTree') ];
			package: 'Containers-KDTree-Benchmarks' with: [ spec requires: #('Containers-KDTree') ].

		spec
			group: 'Core' with: #('Containers-KDTree');
			group: 'Tests' with: #('Containers-KDTree-Tests');
			group: 'Benchmarks' with: #('Containers-KDTree-Benchmarks');
			group: 'default' with: #('Core' 'Tests' 'Benchmarks') ]
]
