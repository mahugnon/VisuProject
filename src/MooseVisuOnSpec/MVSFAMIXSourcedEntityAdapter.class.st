Class {
	#name : #MVSFAMIXSourcedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #action }
MVSFAMIXSourcedEntityAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^col
		add:
			(MenuItemPresenter new
				name: 'Souce code';
				action: [ "aPresenter itemSourceCode: context focus" ]);
		yourself
]
