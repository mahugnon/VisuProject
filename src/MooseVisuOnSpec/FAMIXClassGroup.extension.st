Extension { #name : #FAMIXClassGroup }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> contextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self ]
						ifFalse: [ aPresenter updateListViewItems: self ] ]);
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self ]).
		aPresenter buildContextMenuWith: col
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> doubleClick: aPresenter [
self contextMenuOn: aPresenter .
^aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self ]
						ifFalse: [ aPresenter updateListViewItems: self ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		add: MVSSystemComplexityPresenter; yourself
]
