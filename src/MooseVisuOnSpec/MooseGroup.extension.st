Extension { #name : #MooseGroup }

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

{ #category : #'*MooseVisuOnSpec' }
MooseGroup >> mvsdoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self ]
		ifFalse: [ aPresenter updateListViewItems: self ]
]
