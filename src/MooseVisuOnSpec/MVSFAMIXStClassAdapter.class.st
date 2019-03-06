Class {
	#name : #MVSFAMIXStClassAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'as yet unclassified' }
MVSFAMIXStClassAdapter >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		add: MVSSystemComplexityPresenter;
		yourself
]

{ #category : #'as yet unclassified' }
MVSFAMIXStClassAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action: [ self visualizeAction ]);
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ self viewSourceCodeAction ]);
		yourself
]
