Extension { #name : #MVSMainPresenter }

{ #category : #'*MooseVisuOnSpecTests' }
MVSMainPresenter >> simulateDoubleClick [
	self mooseView mooseModels
		doubleClick: self mooseView mooseModels doubleClickAction
]
