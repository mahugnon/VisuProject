Class {
	#name : #MVSDeprecatedClassRelationWithForceLayoutPresenter,
	#superclass : #MVSRoassalDrawerPresenter,
	#category : #'MooseVisuOnSpec-roassalDrawPresenters'
}

{ #category : #drawing }
MVSDeprecatedClassRelationWithForceLayoutPresenter >> drawOnRoassalView: aView [
	| model es |
	model := selected  select: [ :each | (each isAnnotatedWith: 'Deprecated') & each clientTypes notEmpty ].
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTEllipse new
		size: 15;
		color: [ :c | 
			(c isAnnotatedWith: 'Deprecated')
				ifTrue: [ Color red ]
				ifFalse: [ Color gray ] ]) elementsOn: (model , (model flatCollect: #clientTypes)) asSet.
	aView addAll: es.
	es @ RTDraggable @ RTPopup.
	RTEdgeBuilder new
		view: aView;
		elements: es;
		connectFromAll: #clientTypes.
	RTForceBasedLayout new on: es.
	aView view pushBackEdges.
	aView
]
