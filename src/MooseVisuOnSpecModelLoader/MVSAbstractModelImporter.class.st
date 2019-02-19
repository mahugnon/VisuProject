"
I'm a model importer
"
Class {
	#name : #MVSAbstractModelImporter,
	#superclass : #Object,
	#category : #MooseVisuOnSpecModelLoader
}

{ #category : #hook }
MVSAbstractModelImporter class >> importModel [
self subclassResponsibility 
]

{ #category : #utilities }
MVSAbstractModelImporter class >> loadFileWithExtension:anExtension andWindowTitle:aText [
^UIManager default
		chooseExistingFileReference: aText
		extensions: anExtension 
		path: ''
		preview: ''.
]
