Extension { #name : #Object }

{ #category : #'*Homework' }
Object >> contextMenuOn: aPresenter [
	^ aPresenter listViewMenu: [ :aMenu |  ];
		yourself
]
