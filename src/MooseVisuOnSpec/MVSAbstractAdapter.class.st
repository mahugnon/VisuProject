Class {
	#name : #MVSAbstractAdapter,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #'instance creation' }
MVSAbstractAdapter class >> adapterFor: aString [
	| adapter |
	adapter:= (self allSubclasses
		select: [ :each | each name = ('MVS' , aString , 'Adapter') ]).
		^adapter isEmpty
		ifTrue:  [  self new ]
		ifFalse:[adapter first new]
]

{ #category : #accessing }
MVSAbstractAdapter >> context [
	^ context
]

{ #category : #accessing }
MVSAbstractAdapter >> context: aContext [
	context := aContext
]

{ #category : #action }
MVSAbstractAdapter >> mvsDoubleClickOn:aMooseView [
	
	^ context  isOpenResultNewWindow
		ifTrue: [( MVSMainPresenter withElements: context focus) openWithSpec  ]
		ifFalse: [ aMooseView update ]
]

{ #category : #action }
MVSAbstractAdapter >> mvscontextMenuOn: aPresenter [
	^ self subclassResponsibility
]

{ #category : #processing }
MVSAbstractAdapter >> runPragmas [
	^ (MooseNavigationPresentation new displayFor: context  focus)
		collect: [ :each | each value ]
]
