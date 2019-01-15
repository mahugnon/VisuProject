Extension { #name : #Symbol }

{ #category : #'*Homework' }
Symbol >> drawers [
	^ OrderedCollection new
		add: HWDrawerMethodsImplementors;
		yourself
]
