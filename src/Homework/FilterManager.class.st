Class {
	#name : #FilterManager,
	#superclass : #Object,
	#category : #'Homework-version2'
}

{ #category : #'as yet unclassified' }
FilterManager >> buildQueryBlockFrom: aText [
	^ OpalCompiler new
		source: '[:each |',aText,']';
		logged: false;
		evaluate
]

{ #category : #'as yet unclassified' }
FilterManager >> executeQueryBlock: aBlock on: aFamixClassGroup [
	^aFamixClassGroup collect: aBlock 
]

{ #category : #'as yet unclassified' }
FilterManager >> executeQueryWith: aText on: aFamixClassGroup [
	^ self executeQueryBlock: (self buildQueryBlockFrom: aText) on: aFamixClassGroup
]
