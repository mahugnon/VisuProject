Class {
	#name : #MVSOpenInNewWindowOptionPresenter,
	#superclass : #MVSAbstractPresenter,
	#instVars : [
		'option'
	],
	#category : #'MooseVisuOnSpec-Core'
}

{ #category : #specs }
MVSOpenInNewWindowOptionPresenter class >> defaultSpec [
	^ SpecLayout composed
		add: #option;
		yourself
]

{ #category : #specs }
MVSOpenInNewWindowOptionPresenter class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
MVSOpenInNewWindowOptionPresenter >> initializePresenter [
	option whenChangedDo: [ context isOpenResultNewWindow: self state ]
]

{ #category : #initialization }
MVSOpenInNewWindowOptionPresenter >> initializeWidgets [ 
	option := self newCheckBox
]

{ #category : #initialization }
MVSOpenInNewWindowOptionPresenter >> label: aString [
	option label: aString
]

{ #category : #initialization }
MVSOpenInNewWindowOptionPresenter >> option [
	^ option
]

{ #category : #initialization }
MVSOpenInNewWindowOptionPresenter >> state [
	^ option state
]
