Extension { #name : #Object }

{ #category : #'*MooseVisuOnSpec' }
Object >> contextMenuWith:aBoolean On: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu |  ];
		yourself
]
