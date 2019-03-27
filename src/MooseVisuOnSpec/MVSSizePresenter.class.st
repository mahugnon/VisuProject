Class {
	#name : #MVSSizePresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'sizeLabel'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSSizePresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #sizeLabel;
		yourself
]

{ #category : #initialization }
MVSSizePresenter >> initializeWidgets [
	sizeLabel := self newLabel
]

{ #category : #accessing }
MVSSizePresenter >> sizeLabel [
	^ sizeLabel
]

{ #category : #'model updates' }
MVSSizePresenter >> update [
	sizeLabel
		label: 'Number of items ' , ' :  ' , context mooseModelSize ;
		emphasis: #bold
]
