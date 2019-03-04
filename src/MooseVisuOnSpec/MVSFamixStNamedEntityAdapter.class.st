Class {
	#name : #MVSFamixStNamedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #action }
MVSFamixStNamedEntityAdapter >> mvsDoubleClick: aPresenter [
	
]

{ #category : #'as yet unclassified' }
MVSFamixStNamedEntityAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ aPresenter itemSourceCode: focus ]).
	aPresenter buildContextMenuWith: col
]
