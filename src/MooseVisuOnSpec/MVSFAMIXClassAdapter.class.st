Class {
	#name : #MVSFAMIXClassAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #utilities }
MVSFAMIXClassAdapter >> drawers [
	^ OrderedCollection new
		add: MVSFMClassInheritanceTreePresenter;
		yourself
]

{ #category : #actions }
MVSFAMIXClassAdapter >> mvsInteraction [
	"	col := self complexPropertyPragmas collect: [ :pragma | pragma methodSelector value: self ]."

	^ (MVSMainPresenter withElements: self runPragmas) openWithSpec
]

{ #category : #actions }
MVSFAMIXClassAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ aPresenter drawerOptionsOn: self ]);
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ aPresenter itemSourceCode: self ]).
	aPresenter buildContextMenuWith: col
]
