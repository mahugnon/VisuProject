Class {
	#name : #MVSFAMIXTypeGroupAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSFAMIXTypeGroupAdapter class >> adaptedClass [
	^ FAMIXTypeGroup
]

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
				action: [ self openAction  ]);
		yourself
]
