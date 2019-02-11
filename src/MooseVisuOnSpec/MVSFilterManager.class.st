Class {
	#name : #MVSFilterManager,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #actions }
MVSFilterManager >> buildQueryBlockFrom: aText [
	| blockCode |
	blockCode := self checkTextCorrectnessAndBuildCorrespondingStringBlock: aText .
	^ OpalCompiler new
		source: blockCode;
		logged: false;
		evaluate
]

{ #category : #'as yet unclassified' }
MVSFilterManager >> checkTextCorrectnessAndBuildCorrespondingStringBlock: aText [
	^ aText
		ifEmpty: [ '[:each | true ]' ]
		ifNotEmpty: [
			(aText includes: $.)
			ifFalse:[  
			 '[:each | [((' , aText , ') ~= false)] on: Error do: [ true ] ]']
			ifTrue:['[:each|true]'] ]
]

{ #category : #actions }
MVSFilterManager >> executeQueryBlock: aBlock on: aFamixClassGroup [
	^ aFamixClassGroup select: aBlock
]

{ #category : #actions }
MVSFilterManager >> executeQueryWith: aText on: aFamixClassGroup [
	^ self executeQueryBlock: (self buildQueryBlockFrom: aText) on: aFamixClassGroup
]
