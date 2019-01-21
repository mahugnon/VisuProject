Class {
	#name : #HWDrawerSuperclassesWithTreeLayout,
	#superclass : #HWRoassalDrawer,
	#category : #'MooseVisuOnSpec-core'
}

{ #category : #drawing }
HWDrawerSuperclassesWithTreeLayout >> drawOnRoassalView: roassalView [
	| es |
	roassalView @ RTDraggableView @ RTZoomableView.
	es := (RTBox new
		size: 15;
		color: [ :c | 
			c = selected
				ifTrue: [ Color green ]
				ifFalse: [ Color black alpha: 0.5 ] ]) elementsOn: selected withAllSuperclasses.
	roassalView addAll: es.
	RTMetricNormalizer new
		elements: es;
		normalizeHeight: [ :els | els numberOfMethods ] min: 15 max: 50;
		normalizeWidth: [ :cls | cls numberOfInstanceVariables ] min: 15 max: 50.
	es @ RTDraggable @ RTPopup.
	RTEdgeBuilder new
		view: roassalView;
		elements: es;
		connectFrom: #superclass.
	RTTreeLayout new on: es
]
