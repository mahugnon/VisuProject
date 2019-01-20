Extension { #name : #Object }

{ #category : #'*Homework' }
Object >> contextMenuWith:aBoolean On: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu |  ];
		yourself
]
