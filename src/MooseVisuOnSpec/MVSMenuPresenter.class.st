Class {
	#name : #MVSMenuPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'menu'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #initialization }
MVSMenuPresenter >> initializeWidgets [
	menu := self menuBarFor: self.
]

{ #category : #initialization }
MVSMenuPresenter >> menuBarFor: aPresenter [
	| aMenu |
	aMenu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import model from MSE file';
						icon: MooseIcons mooseImportMse;
						action: [ context importMSE ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Import Smalltalk';
						icon: MooseIcons mooseImportSmalltalk;
						action: [ context importSt ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Previous';
						icon: (self iconNamed: #smallUndoIcon);
						action: [ self prev ] ].
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Next';
						icon: (self iconNamed: #smallRedoIcon);
						action: [ self next ] ] ].
	aMenu applyTo: aPresenter.
	^ aMenu
]
