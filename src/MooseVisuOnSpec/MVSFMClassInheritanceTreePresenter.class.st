"
I draw inheritance tree
"
Class {
	#name : #MVSFMClassInheritanceTreePresenter,
	#superclass : #MVSRoassalDrawerPresenter,
	#category : #'MooseVisuOnSpec-VisualPresenters'
}

{ #category : #'drawing - helpers' }
MVSFMClassInheritanceTreePresenter >> drawOnRoassalView: aView [
	| es col |
	col := OrderedCollection new.
	col
		add: selected;
		addAll: selected subclassHierarchy;
		addAll: selected superclassHierarchy.
	aView @ RTDraggableView @ RTDraggableView.
	es := (RTEllipse new
		size: 15;
		color: [ :c | 
			c = selected
				ifTrue: [ Color green ]
				ifFalse: [ Color black alpha: 0.5 ] ]) elementsOn: col.
	aView addAll: es.
	RTMetricNormalizer new
		elements: es;
		normalizeSize: #numberOfMethods min: 15 max: 50;
		normalizeColorAsGray: #numberOfAttributes.
	es @ RTDraggable @ RTPopup @ RTMVSElInteraction .
	RTEdgeBuilder new
		view: aView;
		elements: es;
		connectFromAll: #directSuperclasses.
	RTTreeLayout new on: es.
	aView
]
