"
I collect Roassal drawers applicable on a specific type of object.
"
Class {
	#name : #MVSDrawerManager,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #utility }
MVSDrawerManager >> drawersFor: aType [
	aType
		isNotNil
		ifTrue:
			[ ^ aType
				drawers ]
]
