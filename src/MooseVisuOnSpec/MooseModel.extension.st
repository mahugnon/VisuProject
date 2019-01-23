Extension { #name : #MooseModel }

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> contextMenuOn: aPresenter [
	| col  |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [  aPresenter openResultInNewWindow: self cacheMooseGroups entityCache ]
						ifFalse: [ aPresenter updateListViewItems: self cacheMooseGroups entityCache ] ]).
		aPresenter buildContextMenuWith: col
]
