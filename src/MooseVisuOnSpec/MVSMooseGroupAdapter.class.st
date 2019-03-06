Class {
	#name : #MVSMooseGroupAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #action }
MVSMooseGroupAdapter >> mvsContextMenu [
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

{ #category : #action }
MVSMooseGroupAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: focus ]
						ifFalse: [ aPresenter updateListViewItems: focus ] ]).
	aPresenter buildContextMenuWith: col
]
