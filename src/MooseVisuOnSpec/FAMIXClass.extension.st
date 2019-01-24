Extension { #name : #FAMIXClass }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> contextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self runPragmas ]).
	aPresenter buildContextMenuWith: col
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> doubleClick: aPresenter [
	self contextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self ]
		ifFalse: [ aPresenter updateListViewItems: self ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> drawers [
	^ OrderedCollection new
		add: MVSFMClassInheritanceTreePresenter ;
	
		yourself
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> mvsInteraction [
	
	"	col := self complexPropertyPragmas collect: [ :pragma | pragma methodSelector value: self ]."
	^ (MVSMainPresenter withDrawer: nil elements: self runPragmas) openWithSpec
]
