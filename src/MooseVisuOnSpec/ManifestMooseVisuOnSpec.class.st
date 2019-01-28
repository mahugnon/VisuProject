"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMooseVisuOnSpec,
	#superclass : #PackageManifest,
	#category : #'MooseVisuOnSpec-Manifest'
}

{ #category : #'code-critics' }
ManifestMooseVisuOnSpec class >> ruleRBConsistencyCheckRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MVSMainPresenter #importSt #false)) #'2019-01-29T00:17:53.591651+01:00') )
]
