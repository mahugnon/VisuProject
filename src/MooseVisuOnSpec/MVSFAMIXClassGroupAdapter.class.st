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
MVSFAMIXClassGroupAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ context  isOpenResultNewWindow
						ifTrue: [ MVSMainPresenter withElements: context focus ]
						ifFalse: [ context mooseModel: context focus ] ]);
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ "aPresenter drawerOptionsOn: self" ]);
		yourself
]

{ #category : #action }
MVSFAMIXClassGroupAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ MVSMainPresenter withElements: context focus ]
						ifFalse: [ context mooseModel: context focus ] ]);
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ "aPresenter drawerOptionsOn: self" ]);
		yourself
]
