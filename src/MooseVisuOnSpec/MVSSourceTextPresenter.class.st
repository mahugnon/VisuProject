Class {
	#name : #MVSSourceTextPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sourceText'
	],
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #specs }
MVSSourceTextPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #sourceText;
		yourself
]

{ #category : #initialization }
MVSSourceTextPresenter >> initializeWidgets [
	sourceText :=self newText .
]

{ #category : #initialization }
MVSSourceTextPresenter >> sourceCode:aSourceText [
sourceText text: aSourceText  .
]

{ #category : #accessing }
MVSSourceTextPresenter >> sourceText [
	^ sourceText
]

{ #category : #initialization }
MVSSourceTextPresenter >> title [
^'Source text'
]
