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
MVSAbstractAdapter class >> adapterFor: aModel [
	| adapter |
	adapter := self allSubclasses
		select: [ :each | each adaptedClass = aModel class ].
	^ adapter isEmpty
		ifTrue: [ self new ]
		ifFalse: [ adapter first new ]
]

{ #category : #accessing }
MVSAbstractAdapter >> context [
	^ context
]

{ #category : #accessing }
MVSAbstractAdapter >> context: aContext [
	context := aContext
]

{ #category : #utilities }
MVSAbstractAdapter >> mvsContextMenu [
	^ self subclassResponsibility
]

{ #category : #utilities }
MVSAbstractAdapter >> mvsDoubleClickOn: aMooseView [
	^ context isOpenResultNewWindow
		ifTrue: [ (MVSMainPresenter withElements: context focus) openWithSpec ]
		ifFalse: [ context whenDrillDown: context focus ]
]

{ #category : #actions }
MVSAbstractAdapter >> openAction [
	^ context isOpenResultNewWindow
		ifTrue: [ MVSMainPresenter withElements: context focus ]
		ifFalse: [ context whenDrillDown: context focus ]
]

{ #category : #processing }
MVSAbstractAdapter >> runPragmas [
	^ (MooseNavigationPresentation new displayFor: context  focus)
		collect: [ :each | each value ]
]

{ #category : #actions }
MVSAbstractAdapter >> viewSourceCodeAction [
	^ MVSSourceTextPresenter createWithSource: context focusSourceText
]

{ #category : #actions }
MVSAbstractAdapter >> visualizeAction [
	context drawers: self drawers.
	^ MVSDrawerOptionsPresenter openInContext: context
]
