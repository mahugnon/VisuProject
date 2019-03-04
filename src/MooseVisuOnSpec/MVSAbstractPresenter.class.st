Class {
	#name : #MVSAbstractPresenter,
	#superclass : #DynamicComposablePresenter,
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
MVSAbstractPresenter >> unSubscribeToContext: aContext [
	context := nil.
	context removeListener: self
]

{ #category : #initialization }
MVSAbstractPresenter >> upadate [
	^self subclassResponsibility 

	
]
