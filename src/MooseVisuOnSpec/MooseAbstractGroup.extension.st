Extension { #name : #MooseAbstractGroup }

{ #category : #'*MooseVisuOnSpec' }
MooseAbstractGroup >> drawers [
	^ OrderedCollection new
		add: HWDrawerClassNameSufix;
		yourself
]
