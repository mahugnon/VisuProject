Extension { #name : #TextPresenter }

{ #category : #'*MooseVisuOnSpecTests' }
TextPresenter >> type: aCharacter [
	additionalKeyBindings at: aCharacter asCharacter ifPresent: [ :block | ^ block value ].
	self text: (self text copyWith: aCharacter asCharacter)
]
