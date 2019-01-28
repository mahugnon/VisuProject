Extension { #name : #MooseModel }

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> contextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self runPragmas ]
						ifFalse: [ aPresenter updateListViewItems: self runPragmas ] ]);
					add: (MenuItemPresenter new
				name: 'Set root folder';
				action: [self setRootFolder  ]).
	aPresenter buildContextMenuWith: col
]

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> doubleClick: aPresenter [
	self contextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self mvsGroupEntitycache ]
		ifFalse: [ aPresenter updateListViewItems: self mvsGroupEntitycache  ]
]

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> mvsGroupEntitycache [
^self cacheMooseGroups entityCache
]
