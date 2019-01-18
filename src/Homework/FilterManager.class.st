Class {
	#name : #FilterManager,
	#superclass : #Object,
	#category : #'Homework-core'
}

{ #category : #actions }
FilterManager >> buildQueryBlockFrom: aText [
	^ OpalCompiler new
		source: '[:each |',aText,']';
		logged: false;
		evaluate
]

{ #category : #actions }
FilterManager >> executeQueryBlock: aBlock on: aFamixClassGroup [
	^ aFamixClassGroup select: aBlock
]

{ #category : #actions }
FilterManager >> executeQueryWith: aText on: aFamixClassGroup [
	^ self executeQueryBlock: (self buildQueryBlockFrom: aText) on: aFamixClassGroup
]
