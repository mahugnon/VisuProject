Extension { #name : #Object }

{ #category : #'*MooseVisuOnSpec' }
Object >> contextMenuOn: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu |  ];
		yourself
]
