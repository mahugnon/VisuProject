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
MVSFAMIXClassAdapter >> mvsContextMenu [
	| col |
	col := OrderedCollection new.
	^ col
		add:
			(MenuItemPresenter new
				name: 'Visualize';
				action:
						[ self visualizeAction ]);
		add:
			(MenuItemPresenter new
				name: 'Source code';
				action: [ MVSSourceTextPresenter createWithSource: context focusSourceText ]);
		yourself
]

{ #category : #actions }
MVSFAMIXClassAdapter >> mvsInteraction [
	"	col := self complexPropertyPragmas collect: [ :pragma | pragma methodSelector value: self ]."

	^ (MVSMainPresenter withElements: self runPragmas) openWithSpec
]
