Extension { #name : #FamixStNamedEntity }

{ #category : #'*MooseVisuOnSpec' }
FamixStNamedEntity >> contextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Souce code';
				action: [ aPresenter itemSourceCode: self ]).
	aPresenter buildContextMenuWith: col
]
