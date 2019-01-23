Extension { #name : #FAMIXClass }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> contextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self ]).
	aPresenter buildContextMenuWith: col
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> drawers [
	^ OrderedCollection new
		add: MVSFMClassInheritanceTree ;
	
		yourself
]
