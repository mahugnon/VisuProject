Extension { #name : #Class }

{ #category : #'*MooseVisuOnSpec' }
Class >> drawers [
	^ OrderedCollection new
		add: MVSDrawerSubclassesWithForceLayout;
		add: MVSDrawerSuperclassesWithTreeLayout;
		yourself
]
