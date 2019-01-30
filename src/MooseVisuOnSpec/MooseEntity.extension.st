Extension { #name : #MooseEntity }

{ #category : #'*MooseVisuOnSpec' }
MooseEntity >> runPragmas [
	^ (MooseNavigationPresentation
		new displayFor: self)
			collect: [ :each | each value ]
]
