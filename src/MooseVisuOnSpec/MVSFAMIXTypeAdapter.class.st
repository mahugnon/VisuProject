Class {
	#name : #MVSFAMIXTypeAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #action }
MVSFAMIXTypeAdapter >> mvsDoubleClick: aPresenter [
	
]

{ #category : #'as yet unclassified' }
MVSFAMIXTypeAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: focus  ]
						ifFalse: [ aPresenter updateListViewItems: focus ] ]).
	aPresenter buildContextMenuWith: col
]
