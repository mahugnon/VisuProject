"
I draw inheritance tree
"
Class {
	#name : #HWFMClassInheritanceTree,
	#superclass : #HWRoassalDrawer,
	#category : #'MooseVisuOnSpec-drawers'
}

{ #category : #drawing }
HWFMClassInheritanceTree >> drawOnRoassalView: aView [
	| es col |
	col:=OrderedCollection new.
	col add: selected ;
	addAll: selected directSubclasses;
	addAll: selected directSuperclasses.
	aView @ RTDraggableView @ RTDraggableView.
	es := (RTBox new
		size: 15;
		color: [ :c | 
			c = selected
				ifTrue: [ Color green ]
				ifFalse: [ Color black alpha: 0.5 ] ])
		elementsOn: col.
	aView addAll: es.
	RTMetricNormalizer new
		elements: es;
		normalizeHeight: #numberOfMethods min: 15 max: 50;
		normalizeWidth: #numberOfAttributes min: 15 max: 50.
	es @ RTDraggable @ RTPopup.
	RTEdgeBuilder new
		view: aView;
		elements: es;
		connectFrom: #superclass.
	RTTreeLayout new on: es.
	aView
]
