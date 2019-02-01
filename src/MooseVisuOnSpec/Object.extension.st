Extension { #name : #Object }

{ #category : #'*MooseVisuOnSpec' }
Object >> mvscontextMenuFor: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu |  ];
		yourself
]
