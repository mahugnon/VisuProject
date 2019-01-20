Extension { #name : #Object }

{ #category : #'*Homework' }
Object >> contextMenuOn: aPresenter [
	^ aPresenter listView
		menu: [ :aMenu |  ];
		yourself
]
