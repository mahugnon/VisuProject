Class {
	#name : #MVSMooseModelAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #action }
MVSMooseModelAdapter >> mvsDoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: self mvsGroupEntitycache ]
		ifFalse: [ aPresenter updateListViewItems: self mvsGroupEntitycache ]
]

{ #category : #utilities }
MVSMooseModelAdapter >> mvsGroupEntitycache [
	^ focus cacheMooseGroups entityCache
]

{ #category : #action }
MVSMooseModelAdapter >> mvscontextMenuOn: aPresenter [
	| col |
	col := OrderedCollection new.
	col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action: [ aPresenter isOpenResultNewWindow
						ifTrue: [ aPresenter openResultInNewWindow: focus runPragmas ]
						ifFalse: [ aPresenter updateListViewItems: focus runPragmas ] ]);
		add:
			(MenuItemPresenter new
				name: 'Set root folder';
				action: [ focus setRootFolder ]).
	aPresenter buildContextMenuWith: col
]
