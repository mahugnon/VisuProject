Extension { #name : #TextPresenter }

{ #category : #'*BaselineOfMooseVisuOnSpec' }
TextPresenter >> type: aCharacter [
	additionalKeyBindings
		at: aCharacter
		ifPresent: [ :block | ^ block value ].
	
	self text: (self text copyWith: aCharacter asCharacter)
]
