Class {
	#name : #MVSFAMIXTypeAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'as yet unclassified' }
MVSFAMIXTypeAdapter >> mvsContextMenu [
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
