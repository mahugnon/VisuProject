Class {
	#name : #MVSErrorReportPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'logHolder'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSErrorReportPresenter class >> defaultSpec [
	^ SpecLayout composed  add: #logHolder
]

{ #category : #specs }
MVSErrorReportPresenter class >> show [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
MVSErrorReportPresenter >> createLogHolder [
	logHolder := self newTextInput ghostText: 'Query error log console'
]

{ #category : #initialization }
MVSErrorReportPresenter >> initializeWidgets [
	self createLogHolder.
]

{ #category : #accessing }
MVSErrorReportPresenter >> logError: anException [
	logHolder text: anException class name, ': ', anException messageText
]

{ #category : #accessing }
MVSErrorReportPresenter >> logHolder [
^logHolder
]

{ #category : #accessing }
MVSErrorReportPresenter >> message [
	^ logHolder text
]
