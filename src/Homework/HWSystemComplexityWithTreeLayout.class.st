Class {
	#name : #HWSystemComplexityWithTreeLayout,
	#superclass : #HWRoassalDrawer,
	#instVars : [
		'fxmTypeGroupe'
	],
	#category : #'Homework-core'
}

{ #category : #drawing }
HWSystemComplexityWithTreeLayout >> drawOnRoassalView: aView [
fxmTypeGroupe :=FAMIXTypeGroup new.
	fxmTypeGroupe viewSimpleSystemComplexityOn: aView.
	fxmTypeGroupe addSystemComplexityLegendOn: aView
]
