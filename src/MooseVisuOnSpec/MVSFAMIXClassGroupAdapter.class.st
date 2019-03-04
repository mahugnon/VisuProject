Class {
	#name : #MVSFAMIXClassGroupAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #utilities }
MVSFAMIXClassGroupAdapter >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		add: MVSSystemComplexityPresenter;
		yourself
]

{ #category : #action }
MVSFAMIXClassGroupAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self ]
						ifFalse: [ aPresenter updateListViewItems: self ] ]);
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self ]).
	aPresenter buildContextMenuWith: col
]
