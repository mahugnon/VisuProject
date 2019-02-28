Extension { #name : #MooseAbstractGroup }

{ #category : #'*MooseVisuClassNames' }
MooseAbstractGroup >> drawers [
	^ OrderedCollection new
		add: MVSDrawerClassNameSufixPresenter;
		yourself
]
