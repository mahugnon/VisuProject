Class {
	#name : #HWSystemComplexityWithTreeLayout,
	#superclass : #HWRoassalDrawer,
	#instVars : [
		'fxmTypeGroupe'
	],
	#category : #'Homework-version1'
}

{ #category : #drawing }
HWSystemComplexityWithTreeLayout >> drawOnRoassalView: aView [
fxmTypeGroupe :=FAMIXTypeGroup new.
	fxmTypeGroupe viewSimpleSystemComplexityOn: aView.
	fxmTypeGroupe addSystemComplexityLegendOn: aView
]
