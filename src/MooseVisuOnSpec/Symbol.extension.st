Extension { #name : #Symbol }

{ #category : #'*MooseVisuOnSpec' }
Symbol >> drawers [
	^ OrderedCollection new
		add: HWDrawerMethodsImplementors;
		yourself
]
