Class {
	#name : #MVSMooseGroupAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSMooseGroupAdapter class >> adaptedClass [
	^ MooseGroup
]

{ #category : #action }
MVSMooseGroupAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Open';
				action:
						[ self openAction ]);
		yourself
]
