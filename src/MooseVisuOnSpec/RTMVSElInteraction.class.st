"
I define the interaction when mouse click on a drawePresenter element
"
Class {
	#name : #RTMVSElInteraction,
	#superclass : #RTInteraction,
	#category : #'MooseVisuOnSpec-rtInteraction'
}

{ #category : #hooks }
RTMVSElInteraction >> initializeElement: element [
	 element announcer when: TRMouseClick do:[
	   element model mvsInteraction].
]
