Extension { #name : #ClassScanReport }

{ #category : #'*Homework' }
ClassScanReport >> drawers [
	^ OrderedCollection new add: HWDrawerClassNameSufix;yourself 
]
