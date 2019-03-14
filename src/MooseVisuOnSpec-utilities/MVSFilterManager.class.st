"
My object represent the model of the filter in  the main presenter.
My main responsibility is  to execute a select query on a mooseModel  from the filter typed by the user on the ui. The filter is then an arbitrary text.  I convert the text into a Block that always returns a boolean. I use that block for the select.

I manage the following cases the user might type.
- valid boolean expression :'7 = 5'>> false.
- valid non boolean expression returns always true 'Object new'>>true.
- non valid  exception return true 'self error'>>true.
- invalid pharo syntax return true '{'>true.
monCode := '1+2 . true'>>true.
monCode := ''>>true.

RBParser parseFaultyExpression: monCode.

wrap := [ :code | '[([', code , '] value = false) not] on: Error do: [ true ] ' ].

OpalCompiler evaluate: (wrap value: monCode).

[ ] value
"
Class {
	#name : #MVSFilterManager,
	#superclass : #Object,
	#category : #'MooseVisuOnSpec-utilities'
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

{ #category : #actions }
MVSFilterManager >> checkTextCorrectnessAndBuildCorrespondingStringBlock: aText [
	^ '[:each | ' , aText , ']'
]

{ #category : #actions }
MVSFilterManager >> executeQueryWith: aText on: aFamixClassGroup [
	^ aFamixClassGroup select: (self buildQueryBlockFrom: aText)
	
]
