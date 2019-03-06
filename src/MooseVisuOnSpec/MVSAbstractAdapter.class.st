Class {
	#name : #MVSAbstractAdapter,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #display }
MVSAbstractAdapter class >> adaptedClass [
	^self subclassResponsibility 
]

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
MVSAbstractAdapter >> mvsContextMenu [
	^ self subclassResponsibility
]

{ #category : #action }
MVSAbstractAdapter >> mvsDoubleClickOn: aMooseView [
	^ context isOpenResultNewWindow
		ifTrue: [ (MVSMainPresenter withElements: context focus) openWithSpec ]
		ifFalse: [ context mooseModel: context focus. ]
]

{ #category : #action }
MVSAbstractAdapter >> openAction [
	^ context isOpenResultNewWindow
		ifTrue: [ MVSMainPresenter withElements: context focus ]
		ifFalse: [ context mooseModel: context focus ]
]

{ #category : #processing }
MVSAbstractAdapter >> runPragmas [
	^ (MooseNavigationPresentation new displayFor: context  focus)
		collect: [ :each | each value ]
]

{ #category : #'as yet unclassified' }
MVSAbstractAdapter >> viewSourceCodeAction [
	^ MVSSourceTextPresenter createWithSource: context focusSourceText
]

{ #category : #actions }
MVSAbstractAdapter >> visualizeAction [
	context drawers: self drawers.
	^ MVSDrawerOptionsPresenter openInContext: context
]
