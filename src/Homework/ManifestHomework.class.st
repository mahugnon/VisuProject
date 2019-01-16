"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestHomework,
	#superclass : #PackageManifest,
	#category : #'Homework-Manifest'
}

{ #category : #'code-critics' }
ManifestHomework class >> ruleRBSelfSentNotImplementedRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#HWMainPresenter)) #'2019-01-16T14:48:51.669821+01:00') )
]
