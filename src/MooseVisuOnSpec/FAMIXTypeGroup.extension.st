Extension { #name : #FAMIXTypeGroup }

{ #category : #'*MooseVisuOnSpec' }
FAMIXTypeGroup >> contextMenuOn: aPresenter [
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

{ #category : #'*MooseVisuOnSpec' }
FAMIXTypeGroup >> doubleClick: aPresenter [
	self contextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self ]
		ifFalse: [ aPresenter updateListViewItems: self ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXTypeGroup >> drawers [
	^ OrderedCollection new add: MVSDeprecatedClassRelationWithForceLayoutPresenter;yourself 
]
