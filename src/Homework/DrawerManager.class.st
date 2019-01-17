"
I collect Roassal drawers applicable on a specific type of object.
"
Class {
	#name : #DrawerManager,
	#superclass : #Object,
	#category : #'Homework-core'
}

{ #category : #utility }
DrawerManager >> drawersFor: aType [
	aType
		isNotNil
		ifTrue:
			[ ^ aType
				drawers ]
]
