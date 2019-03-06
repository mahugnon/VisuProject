Class {
	#name : #MVSFAMIXStClassAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'as yet unclassified' }
MVSFAMIXStClassAdapter >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		add: MVSSystemComplexityPresenter;
		yourself
]

{ #category : #'as yet unclassified' }
MVSFAMIXStClassAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ "aPresenter drawerOptionsOn: self runPragmas" ]);
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ "aPresenter itemSourceCode: context focus" ]);yourself 
]

{ #category : #'as yet unclassified' }
MVSFAMIXStClassAdapter >> mvscontextMenuOn: aPresenter [
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
				action: [ aPresenter itemSourceCode: context focus ]).
	aPresenter buildContextMenuWith: col
]
