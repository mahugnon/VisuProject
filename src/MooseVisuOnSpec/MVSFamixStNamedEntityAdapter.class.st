Class {
	#name : #MVSFamixStNamedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'as yet unclassified' }
MVSFamixStNamedEntityAdapter >> mvsContextMenu: aPresenter [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ "aPresenter itemSourceCode: context focus" ]);
		yourself
]

{ #category : #'as yet unclassified' }
MVSFamixStNamedEntityAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ "aPresenter itemSourceCode: context focus" ]);
		yourself
]
