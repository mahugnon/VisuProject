Class {
	#name : #MVSFamixStNamedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSFamixStNamedEntityAdapter class >> adaptedClass [
	^ FamixStNamedEntity
]

{ #category : #utilities }
MVSFamixStNamedEntityAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ self viewSourceCodeAction ]);
		yourself
]
