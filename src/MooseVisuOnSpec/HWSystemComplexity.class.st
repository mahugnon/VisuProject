"
I draw system complexity on view
"
Class {
	#name : #HWSystemComplexity,
	#superclass : #HWRoassalDrawer,
	#category : #'MooseVisuOnSpec-drawers'
}

{ #category : #drawing }
HWSystemComplexity >> drawOnRoassalView: aView [
	| es |
	aView @RTZoomableView @RTDraggableView  .
es:=(RTBox new borderColor:Color black  ;
width: [ :cls | (cls numberOfAttributes * 5) max: 5 ];
height: [ :cls | cls numberOfMethods max: 5];
color: Color black ) elementsOn: selected allModelClasses.
aView addAll: es.
es @RTPopup .
RTEdgeBuilder new 
elements: es;
view: aView;
connectToAll:[ :cls |
	cls directSubclasses   ].
RTTreeLayout new on: es.
RTMetricNormalizer new 
elements: es;
normalizeColorAsGray: [ :cls | cls numberOfLinesOfCode
	] .
aView
]
