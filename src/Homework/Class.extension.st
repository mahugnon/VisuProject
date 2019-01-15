Extension { #name : #Class }

{ #category : #'*Homework' }
Class >> drawers [
	^ OrderedCollection new
		add: HWDrawerSubclassesWithForceLayout;
		add: HWDrawerSuperclassesWithTreeLayout;
		yourself
]
