Class {
	#name : #MVSFilterManager,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #actions }
MVSFilterManager >> buildQueryBlockFrom: aText [

	| blockCode |
	blockCode := aText
		ifEmpty: [ '[:each | true ]' ]
		ifNotEmpty: [ '[:each | [(' , aText , ') ~= false] on: Error do: [ true ] ]' ].

	^ OpalCompiler new
		source: blockCode;
		logged: false;
		evaluate
]

{ #category : #actions }
MVSFilterManager >> executeQueryBlock: aBlock on: aFamixClassGroup [
	^ aFamixClassGroup select: aBlock
]

{ #category : #actions }
MVSFilterManager >> executeQueryWith: aText on: aFamixClassGroup [
	^ self executeQueryBlock: (self buildQueryBlockFrom: aText) on: aFamixClassGroup
]
