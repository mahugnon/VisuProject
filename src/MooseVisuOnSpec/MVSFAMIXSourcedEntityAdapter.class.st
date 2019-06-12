Class {
	#name : #MVSFAMIXSourcedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSFAMIXSourcedEntityAdapter class >> adaptedClass [
	^ FAMIXSourcedEntity
]

{ #category : #action }
MVSFAMIXSourcedEntityAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Souce code';
				action: [ self viewSourceCodeAction ]);
		yourself
]
