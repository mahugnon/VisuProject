"
I define the interaction when mouse click on a drawePresenter element.

Example:
When clicked on a Famix Class I display all its properties
"
Class {
	#name : #RTMVSElInteraction,
	#superclass : #RTInteraction,
	#category : #'MooseVisuOnSpec-Interaction'
}

{ #category : #hooks }
RTMVSElInteraction >> initializeElement: element [
	 element announcer when: TRMouseClick do:[
	   element model mvsInteraction].
]
