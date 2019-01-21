"
I specify the project dependencies and packages 
"
Class {
	#name : #BaselineOfMooseVisuOnSpec,
	#superclass : #BaselineOf,
	#category : #BaselineOfMooseVisuOnSpec
}

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> baseline: spec [
	"baselines"

	<baseline>
	spec
		for: #common
		do: [ spec preLoadDoIt: #preload:package:.
			spec postLoadDoIt: #postload:package:.
			"Dependencies"
			self
				baselineForRoassal2Spec: spec;
				baselineForClassNamesAnalyzer: spec.

			"Packages"
			spec package: 'MooseVisuOnSpec' with: [ spec requires: #('Roassal2' 'ClassNamesAnalyzer') ] ].
	"Groups"
	spec group: 'All' with: #('MooseVisuOnSpec')
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> baselineForClassNamesAnalyzer: spec [
	spec 
		baseline: 'ClassNamesAnalyzer'
		with: [ spec repository: 'github://MoussaSak/BluePrintVisualization:master/repository' ]
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> baselineForRoassal2Spec: spec [
	spec
		project: 'Roassal2'
		with: [ spec
				className: #ConfigurationOfRoassal2;
				versionString: #stable;
				loads: #('NoGlamour');
				repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ]
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> postload: loader package: packageSpec [

  Transcript crLog: 'Project loaded!'
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> preload: aloader package: packageSpec [
	Transcript crLog: 'The fetching is finish. wait until loading finish'
]