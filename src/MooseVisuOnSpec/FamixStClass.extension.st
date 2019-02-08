Extension { #name : #FamixStClass }

{ #category : #'*MooseVisuOnSpec' }
FamixStClass >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		add: MVSSystemComplexityPresenter;
		yourself
]

{ #category : #'*MooseVisuOnSpec' }
FamixStClass >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self runPragmas ]);
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ aPresenter itemSourceCode: self ]).
	aPresenter buildContextMenuWith: col
]
