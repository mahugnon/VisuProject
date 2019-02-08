Extension { #name : #Object }

{ #category : #'*MooseVisuOnSpec' }
Object >> mvscontextMenuOn: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu |  ];
		yourself
]
