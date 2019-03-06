Class {
	#name : #MVSFamixStNamedEntityAdapter,
	#superclass : #MVSAbstractAdapter,
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'as yet unclassified' }
MVSFamixStNamedEntityAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ MVSSourceTextPresenter createWithSource: context focusSourceText ]);
		yourself
]
