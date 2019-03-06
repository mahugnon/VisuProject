Class {
	#name : #MVSFAMIXSourcedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #action }
MVSFAMIXSourcedEntityAdapter >> mvsDoubleClick: aPresenter [
	
]

{ #category : #action }
MVSFAMIXSourcedEntityAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Souce code';
				action: [ aPresenter itemSourceCode: focus ]).
	aPresenter buildContextMenuWith: col
]