Extension { #name : #MooseAbstractGroup }

{ #category : #'*MooseVisuOnSpec' }
MooseAbstractGroup >> drawers [
	^ OrderedCollection new
		add: MVSDrawerClassNameSufixPresenter;
		yourself
]
