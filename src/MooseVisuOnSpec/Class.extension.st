Extension { #name : #Class }

{ #category : #'*MooseVisuOnSpec' }
Class >> drawers [
	^ OrderedCollection new
		add: MVSDrawerSubclassesWithForceLayoutPresenter;
		add: MVSDrawerSuperclassesWithTreeLayoutPresenter;
		yourself
]
