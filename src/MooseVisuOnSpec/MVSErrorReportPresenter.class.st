Class {
	#name : #MVSErrorReportPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'logHolder'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSErrorReportPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #logHolder;
		yourself
]

{ #category : #specs }
MVSErrorReportPresenter class >> show [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
MVSErrorReportPresenter >> createLogHolder [
	logHolder := self newLabel
		color: Color red;
		emphasis: #bold;
		yourself
]

{ #category : #initialization }
MVSErrorReportPresenter >> initializeWidgets [
	self createLogHolder.
]

{ #category : #accessing }
MVSErrorReportPresenter >> logError: anException [
	logHolder
		label: anException class name , ': ' , anException messageText
]

{ #category : #accessing }
MVSErrorReportPresenter >> logHolder [
^logHolder
]

{ #category : #accessing }
MVSErrorReportPresenter >> message [
	^ logHolder label
]

{ #category : #subscription }
MVSErrorReportPresenter >> subscribeTo: aContext [
	aContext errorListener: self.
	context := aContext
]

{ #category : #'model updates' }
MVSErrorReportPresenter >> update [
	self logError: context mvsError
]
