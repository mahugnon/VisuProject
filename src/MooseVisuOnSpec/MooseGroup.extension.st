Extension { #name : #MooseGroup }

{ #category : #'*MooseVisuOnSpec' }
MooseGroup >> mvsDoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self ]
		ifFalse: [ aPresenter updateListViewItems: self ]
]

{ #category : #'*MooseVisuOnSpec' }
MooseGroup >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self]
						ifFalse: [ aPresenter updateListViewItems: self  ] ]).
	aPresenter buildContextMenuWith: col
]
