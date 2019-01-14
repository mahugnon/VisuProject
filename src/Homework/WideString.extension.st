Extension { #name : #WideString }

{ #category : #'*Homework' }
WideString >> drawers [
	^ OrderedCollection new add: HWDrawerMethodsImplementors;yourself 
]
