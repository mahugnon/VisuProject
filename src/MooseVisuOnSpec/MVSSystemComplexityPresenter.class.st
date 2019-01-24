"
I draw system complexity on view
"
Class {
	#name : #MVSSystemComplexityPresenter,
	#superclass : #MVSRoassalDrawerPresenter,
	#category : #'MooseVisuOnSpec-roassalDrawPresenters'
}

{ #category : #drawing }
MVSSystemComplexityPresenter >> drawOnRoassalView: aView [
	| es |
	aView @ RTZoomableView @ RTDraggableView.
	es := (RTBox new
		borderColor: Color black;
		width: [ :cls | cls numberOfAttributes * 5 max: 5 ];
		height: [ :cls | cls numberOfMethods max: 5 ];
		color: Color black) elementsOn: selected allModelClasses.
	aView addAll: es.
	es @ RTPopup @RTMVSElInteraction .
	RTEdgeBuilder new
		elements: es;
		view: aView;
		connectToAll: [ :cls | cls directSubclasses ].
	RTTreeLayout new on: es.
	RTMetricNormalizer new
		elements: es;
		normalizeColorAsGray: [ :cls | cls numberOfLinesOfCode ].
	aView
]
