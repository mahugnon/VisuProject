Class {
	#name : #MVSFAMIXTypeAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSFAMIXTypeAdapter class >> adaptedClass [
	^ FAMIXType
]

{ #category : #utilities }
MVSFAMIXTypeAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ self openAction ]);
		yourself
]
