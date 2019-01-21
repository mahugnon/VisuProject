Extension { #name : #ClassScanReport }

{ #category : #'*MooseVisuOnSpec' }
ClassScanReport >> drawers [
	^ OrderedCollection new add: HWDrawerClassNameSufix;yourself 
]
