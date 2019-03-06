Class {
	#name : #MVSFAMIXTypeGroupAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #utilities }
MVSFAMIXTypeGroupAdapter >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		yourself
]

{ #category : #action }
MVSFAMIXTypeGroupAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ context isOpenResultNewWindow
						ifTrue: [ MVSMainPresenter withElements: context focus ]
						ifFalse: [ context mooseModel: context focus ] ]);
		yourself
]

{ #category : #action }
MVSFAMIXTypeGroupAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: self ]
						ifFalse: [ aPresenter updateListViewItems: self ] ]).
	aPresenter buildContextMenuWith: col
]
