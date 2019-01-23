"
I draw class name suffix dependecies graph
"
Class {
	#name : #MVSDrawerClassNameSufix,
	#superclass : #MVSRoassalDrawer,
	#category : #'MooseVisuOnSpec-drawers'
}

{ #category : #Visualisation }
MVSDrawerClassNameSufix >> buildHierarchyBlueprintOf: aDicoOfSuffixesAndSubhierarchies using: dicoOfColors and: dicoOfVisualElementsIndices on: aView [
	| allHierarchieClasses aDicoOfSuffixesAndClasses layers |
	aView @ RTDraggableView.
	aView @ RTZoomableView.
	aDicoOfSuffixesAndClasses := (aDicoOfSuffixesAndSubhierarchies keys collect: [ :aSuffix | aSuffix -> ((aDicoOfSuffixesAndSubhierarchies at: aSuffix) values flatCollect: #yourself) ]) asDictionary.
	allHierarchieClasses := aDicoOfSuffixesAndClasses values flatCollect: #yourself.
	layers := selected createLayersFor: aDicoOfSuffixesAndClasses with: dicoOfColors in: aView.
	selected setDimentionsOf: layers.
	selected nestLayers: layers with: dicoOfVisualElementsIndices.
	allHierarchieClasses do: [ :aClass | selected createEdgesFor: aClass on: aView ]
]

{ #category : #drawing }
MVSDrawerClassNameSufix >> drawOnRoassalView: aView [
self hierarchieBlueprintOn: aView 
]

{ #category : #Visualisation }
MVSDrawerClassNameSufix >> hierarchieBlueprint [
	| allHierarchieClasses subRootClasses aDico dicoOfVisualElementsIndices dicoOfColors |
	allHierarchieClasses := selected hierarchieSuffixesAndClasses values flatCollect: #yourself.
	subRootClasses := allHierarchieClasses select: [ :aScanReport | aScanReport indiceOfTheClassInSubHierarchy = 1 ].
	dicoOfColors := selected  affectRandomColorsTo: subRootClasses.
	aDico := selected  classesGroupedBySuffixesAndSubhierarchies.
	dicoOfVisualElementsIndices := selected  affectIndicesToSubhierarchyClasses: aDico.
	aDico := selected  classesGroupedBySuffixesAndSubhierarchies.
	^ selected  buildHierarchyBlueprintOf: aDico using: dicoOfColors and: dicoOfVisualElementsIndices
]

{ #category : #Visualisation }
MVSDrawerClassNameSufix >> hierarchieBlueprintOn:aView [
	| allHierarchieClasses subRootClasses aDico dicoOfVisualElementsIndices dicoOfColors |
	allHierarchieClasses := selected hierarchieSuffixesAndClasses values flatCollect: #yourself.
	subRootClasses := allHierarchieClasses select: [ :aScanReport | aScanReport indiceOfTheClassInSubHierarchy = 1 ].
	dicoOfColors := selected affectRandomColorsTo: subRootClasses.
	aDico := selected classesGroupedBySuffixesAndSubhierarchies.
	dicoOfVisualElementsIndices := selected affectIndicesToSubhierarchyClasses: aDico.
	aDico := selected classesGroupedBySuffixesAndSubhierarchies.
	^ self buildHierarchyBlueprintOf: aDico using: dicoOfColors and: dicoOfVisualElementsIndices on: aView
]

{ #category : #accessing }
MVSDrawerClassNameSufix >> selected [
super selected .
self selected: self selected vocabularyScanner allHierarchies .
]
