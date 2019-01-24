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
