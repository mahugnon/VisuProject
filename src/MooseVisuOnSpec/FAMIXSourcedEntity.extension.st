Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*MooseVisuOnSpec' }
FAMIXSourcedEntity >> mvscontextMenuFor: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		
		add:
			(MenuItemPresenter new
				name: 'Souce code';
				action: [ aPresenter itemSourceCode: self ]).
	aPresenter buildContextMenuWith: col
]
