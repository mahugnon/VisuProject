Class {
	#name : #MVSSourceTextPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'sourceText'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSSourceTextPresenter class >> createWithSource: aSource [
	self new
		sourceCode: aSource;
		openWithSpec
]

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

{ #category : #api }
MVSSourceTextPresenter >> title [
^'Source text'
]
