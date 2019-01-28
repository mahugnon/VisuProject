Extension { #name : #FAMIXType }

{ #category : #'*MooseVisuOnSpec' }
FAMIXType >> contextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self ]
						ifFalse: [ aPresenter updateListViewItems: self ] ]).
						aPresenter buildContextMenuWith: col
]