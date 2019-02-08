Extension { #name : #MooseModel }

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> mvsGroupEntitycache [
^self cacheMooseGroups entityCache
]

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self runPragmas ]
						ifFalse: [ aPresenter updateListViewItems: self runPragmas ] ]);
		add:
			(MenuItemPresenter new
				name: 'Set root folder';
				action: [ self setRootFolder ]);
		add:
			(MenuItemPresenter new
				name: 'Rename model';
				action: [ self setRootFolder ]).
	aPresenter buildContextMenuWith: col
]

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> mvsdoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self mvsGroupEntitycache ]
		ifFalse: [ aPresenter updateListViewItems: self mvsGroupEntitycache  ]
]
