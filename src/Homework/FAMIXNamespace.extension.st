Extension { #name : #FAMIXNamespace }

{ #category : #'*Homework' }
FAMIXNamespace >> drawers [
	^ OrderedCollection new
		add: HWDrawerClassNameSufix;
		yourself
]
