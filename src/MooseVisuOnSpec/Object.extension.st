Extension { #name : #Object }

{ #category : #'*MooseVisuOnSpec' }
Object >> mvscontextMenuOn: aPresenter [
	^ aPresenter
		mooseViewMenu: [ :aMenu |  ];
		yourself
]
