Extension { #name : #FAMIXSourcedEntity }

{ #category : #'*MooseVisuOnSpec' }
FAMIXSourcedEntity >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		
		add:
			(MenuItemPresenter new
				name: 'Souce code';
				action: [ aPresenter itemSourceCode: self ]).
	aPresenter buildContextMenuWith: col
]
