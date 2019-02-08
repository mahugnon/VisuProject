Extension { #name : #FAMIXTypeGroup }

{ #category : #'*MooseVisuOnSpec' }
FAMIXTypeGroup >> drawers [
	^ OrderedCollection new add: MVSDeprecatedClassRelationWithForceLayoutPresenter;yourself 
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXTypeGroup >> mvscontextMenuOn: aPresenter [
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
FAMIXTypeGroup >> mvsdoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self ]
		ifFalse: [ aPresenter updateListViewItems: self ]
]
