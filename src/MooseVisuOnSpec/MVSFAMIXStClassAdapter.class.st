Class {
	#name : #MVSFamixStClassAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSFamixStClassAdapter class >> adaptedClass [
	^ FamixStClass
]

{ #category : #'as yet unclassified' }
MVSFamixStClassAdapter >> drawers [
	^ OrderedCollection new
		add: MVSDeprecatedClassRelationWithForceLayoutPresenter;
		add: MVSSystemComplexityPresenter;
		yourself
]

{ #category : #'as yet unclassified' }
MVSFamixStClassAdapter >> mvsContextMenu [
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
