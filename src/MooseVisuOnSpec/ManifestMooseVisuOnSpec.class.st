"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooseVisuOnSpec,
	#superclass : #PackageManifest,
	#category : #'MooseVisuOnSpec-Manifest'
}

{ #category : #'code-critics' }
ManifestMooseVisuOnSpec class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'MVSAbstractAdapter class' #adapterFor: #true)) #'2019-03-06T04:24:03.448298+01:00') )
]
