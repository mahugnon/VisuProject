Extension { #name : #MooseAbstractGroup }

{ #category : #'*Homework' }
MooseAbstractGroup >> drawers [
	^ OrderedCollection new
		add: HWDrawerClassNameSufix;
		yourself
]
