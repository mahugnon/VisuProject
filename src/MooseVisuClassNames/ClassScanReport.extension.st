Extension { #name : #ClassScanReport }

{ #category : #'*MooseVisuClassNames' }
ClassScanReport >> drawers [
	^ OrderedCollection new add: MVSDrawerClassNameSufixPresenter;yourself 
]
