"
monCode := '7 = 5'.
monCode := 'Object new'.
monCode := 'self error'.
monCode := '{'.
monCode := '1+2 . true'.
monCode := ''.

RBParser parseFaultyExpression: monCode.

wrap := [ :code | '[([', code , '] value = false) not] on: Error do: [ true ] ' ].

OpalCompiler evaluate: (wrap value: monCode).

[ ] value
"
Class {
	#name : #MVSFilterManager,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #actions }
MVSFilterManager >> buildQueryBlockFrom: aText [
	| blockCode |
		blockCode := self checkTextCorrectnessAndBuildCorrespondingStringBlock: aText.
	^ OpalCompiler new
		source: blockCode;
		logged: false;
		evaluate
]

{ #category : #'as yet unclassified' }
MVSFilterManager >> checkTextCorrectnessAndBuildCorrespondingStringBlock: aText [
	" Joli commentaire "
	(RBParser parseFaultyExpression: aText)
		isFaulty ifTrue: [ ^ '[:each | true ]' ].

	^ '[:each | [([' , aText , '] value ~= false)] on: Error do: [ true ] ]'
]

{ #category : #actions }
MVSFilterManager >> executeQueryBlock: aBlock on: aFamixClassGroup [
	^ aFamixClassGroup select: aBlock
]

{ #category : #actions }
MVSFilterManager >> executeQueryWith: aText on: aFamixClassGroup [
	^ self executeQueryBlock: (self buildQueryBlockFrom: aText) on: aFamixClassGroup
]
