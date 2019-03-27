Class {
	#name : #MVSFAMIXClassGroupAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSFAMIXClassGroupAdapter class >> adaptedClass [
	^ FAMIXClassGroup
]

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
				action: [ self openAction ]);
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ self visualizeAction ]);
		yourself
]
