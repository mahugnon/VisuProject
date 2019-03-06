Class {
	#name : #MVSFAMIXTypeAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'as yet unclassified' }
MVSFAMIXTypeAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ context isOpenResultNewWindow
						ifTrue: [ MVSMainPresenter withElements: context focus ]
						ifFalse: [ context mooseModel: context focus ] ]);
		yourself
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
						ifTrue: [ aPresenter openResultInNewWindow: context focus ]
						ifFalse: [ aPresenter updateListViewItems: context focus ] ]).
	aPresenter buildContextMenuWith: col
]
