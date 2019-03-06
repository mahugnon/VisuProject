Class {
	#name : #MVSAbstractPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'context'
	],
	#category : #'MooseVisuOnSpec-Core'
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
	context := aContext.
	context addListener: self.

]

{ #category : #initialization }
MVSAbstractPresenter >> unSubscribeToContext [
	context removeListener: self.
	context := nil
]

{ #category : #'model updates' }
MVSAbstractPresenter >> update [
	^self subclassResponsibility 

	
]
