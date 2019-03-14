Class {
	#name : #MVSAbstractPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context'
	],
	#category : #'MooseVisuOnSpec-MenuBar'
}

{ #category : #accessing }
MVSAbstractPresenter >> context [
	^ context
]

{ #category : #accessing }
MVSAbstractPresenter >> context: anObject [
	context := anObject
]

{ #category : #initialization }
MVSAbstractPresenter >> subscribeToContext: aContext [
	aContext addListener: self.
context := aContext.
]

{ #category : #'model updates' }
MVSAbstractPresenter >> update [
	

	
]
