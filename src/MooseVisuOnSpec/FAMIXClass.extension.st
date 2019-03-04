Extension { #name : #FAMIXClass }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> drawers [
	^ OrderedCollection new
		add: MVSFMClassInheritanceTreePresenter ;
	
		yourself
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> mvsDoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self ]
		ifFalse: [ aPresenter updateListViewItems: self ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> mvsInteraction [
	"	col := self complexPropertyPragmas collect: [ :pragma | pragma methodSelector value: self ]."

	^ (MVSMainPresenter
		withElements:
			self
				runPragmas)
		openWithSpec
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self]);
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ aPresenter itemSourceCode: self ]).
	aPresenter buildContextMenuWith: col
]
