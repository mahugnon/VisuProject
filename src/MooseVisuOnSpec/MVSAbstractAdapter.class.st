Class {
	#name : #MVSAbstractAdapter,
	#superclass : #Object,
	#instVars : [
		'focus'
	],
	#category : #'MooseVisuOnSpec-Adapter'
}

{ #category : #accessing }
MVSAbstractAdapter >> focus [
	^ focus
]

{ #category : #accessing }
MVSAbstractAdapter >> focus: anObject [
	focus := anObject
]

{ #category : #action }
MVSAbstractAdapter >> mvsDoubleClick: aPresenter [
	self mvscontextMenuOn: aPresenter.
	^ aPresenter isOpenResultNewWindow
		ifTrue: [ aPresenter openResultInNewWindow: focus ]
		ifFalse: [ aPresenter updateListViewItems: focus ]
]

{ #category : #action }
MVSAbstractAdapter >> mvscontextMenuOn: aPresenter [
	^ self subclassResponsibility
]

{ #category : #processing }
MVSAbstractAdapter >> runPragmas [
	^ (MooseNavigationPresentation new displayFor: focus )
		collect: [ :each | each value ]
]
