Extension { #name : #Class }

{ #category : #'*MooseVisuOnSpec' }
Class >> drawers [
	^ OrderedCollection new
		add: HWDrawerSubclassesWithForceLayout;
		add: HWDrawerSuperclassesWithTreeLayout;
		yourself
]
