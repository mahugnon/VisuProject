"
I draw class name suffix dependecies graph
"
Class {
	#name : #HWDrawerClassNameSufix,
	#superclass : #HWRoassalDrawer,
	#category : #'Homework-version1'
}

{ #category : #Visualisation }
HWDrawerClassNameSufix >> buildHierarchyBlueprintOf: aDicoOfSuffixesAndSubhierarchies using: dicoOfColors and: dicoOfVisualElementsIndices on: aView [
	| allHierarchieClasses aDicoOfSuffixesAndClasses layers classNameSufix |
	classNameSufix := selected vocabularyScanner allHierarchies.
	aView @ RTDraggableView.
	aView @ RTZoomableView.
	aDicoOfSuffixesAndClasses := (aDicoOfSuffixesAndSubhierarchies keys collect: [ :aSuffix | aSuffix -> ((aDicoOfSuffixesAndSubhierarchies at: aSuffix) values flatCollect: #yourself) ]) asDictionary.
	allHierarchieClasses := aDicoOfSuffixesAndClasses values flatCollect: #yourself.
	layers := classNameSufix createLayersFor: aDicoOfSuffixesAndClasses with: dicoOfColors in: aView.
	classNameSufix setDimentionsOf: layers.
	classNameSufix nestLayers: layers with: dicoOfVisualElementsIndices.
	allHierarchieClasses do: [ :aClass | classNameSufix createEdgesFor: aClass on: aView ]
]

{ #category : #drawing }
HWDrawerClassNameSufix >> drawOnRoassalView: aView [
self hierarchieBlueprintOn: aView 
]

{ #category : #Visualisation }
HWDrawerClassNameSufix >> hierarchieBlueprint [
	| allHierarchieClasses subRootClasses aDico dicoOfVisualElementsIndices dicoOfColors 
	classNameSufix |
	classNameSufix := selected vocabularyScanner allHierarchies.
	allHierarchieClasses := classNameSufix hierarchieSuffixesAndClasses values flatCollect: #yourself.
	subRootClasses := allHierarchieClasses select: [ :aScanReport | aScanReport indiceOfTheClassInSubHierarchy = 1 ].
	dicoOfColors := classNameSufix affectRandomColorsTo: subRootClasses.
	aDico := classNameSufix classesGroupedBySuffixesAndSubhierarchies.
	dicoOfVisualElementsIndices := classNameSufix affectIndicesToSubhierarchyClasses: aDico.
	aDico := classNameSufix classesGroupedBySuffixesAndSubhierarchies.
	^ classNameSufix buildHierarchyBlueprintOf: aDico using: dicoOfColors and: dicoOfVisualElementsIndices
]

{ #category : #Visualisation }
HWDrawerClassNameSufix >> hierarchieBlueprintOn: aView [
	| allHierarchieClasses subRootClasses aDico dicoOfVisualElementsIndices dicoOfColors classNameSufix |
	classNameSufix:=selected vocabularyScanner allHierarchies.
	allHierarchieClasses := classNameSufix hierarchieSuffixesAndClasses values flatCollect: #yourself.
	subRootClasses := allHierarchieClasses select: [ :aScanReport | aScanReport indiceOfTheClassInSubHierarchy = 1 ].
	dicoOfColors := classNameSufix affectRandomColorsTo: subRootClasses.
	aDico := classNameSufix classesGroupedBySuffixesAndSubhierarchies.
	dicoOfVisualElementsIndices := classNameSufix affectIndicesToSubhierarchyClasses: aDico.
	aDico := classNameSufix classesGroupedBySuffixesAndSubhierarchies.
	^ self
		buildHierarchyBlueprintOf: aDico
		using: dicoOfColors
		and: dicoOfVisualElementsIndices
		on: aView
]
