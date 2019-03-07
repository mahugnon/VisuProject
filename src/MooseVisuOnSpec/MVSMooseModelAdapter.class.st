Class {
	#name : #MVSMooseModelAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSMooseModelAdapter class >> adaptedClass [
	^ MooseModel
]

{ #category : #action }
MVSMooseModelAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action:
						[ self openAction ]);
		add:
			(MenuItemPresenter new
				name: 'Set root folder';
				action: [ context focus setRootFolder ]);
		yourself
]

{ #category : #action }
MVSMooseModelAdapter >> mvsDoubleClickOn: aMooseView [
	^ context isOpenResultNewWindow
		ifTrue: [ (MVSMainPresenter withElements: self mvsGroupEntitycache)
				openWithSpec ]
		ifFalse: [ context whenDrillDown: self mvsGroupEntitycache ]
]

{ #category : #utilities }
MVSMooseModelAdapter >> mvsGroupEntitycache [
	^ context focus cacheMooseGroups entityCache
]

{ #category : #action }
MVSMooseModelAdapter >> openAction [
	^ context isOpenResultNewWindow
		ifTrue: [ MVSMainPresenter withElements: self mvsGroupEntitycache ]
		ifFalse: [ context mooseModel: self mvsGroupEntitycache ]
]
