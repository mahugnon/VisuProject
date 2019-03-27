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
			self baselineForRoassal2Spec: spec.

			"Packages "
			spec
				
				package: 'MooseVisuOnSpecModelLoader';
				package: 'MooseVisuOnSpec-utilities';
				package: 'MooseVisuOnSpec';
				package: 'MooseVisuOnSpecTests'
					with: [ spec
						requires: #('Roassal2' 'MooseVisuOnSpecModelLoader' 'MooseVisuOnSpec-utilities') ] ].
	spec
		for: #WithoutMoose
		do: [ "Dependencies"
			self baselineForMoose: spec.
			"Packages "
			spec
				package: 'MooseVisuOnSpec'
				with: [ spec
						requires:
							#('Roassal2' 'MooseVisuOnSpecModelLoader' 'MooseVisuOnSpec-utilities' 'Moose') ] ].
	"Groups"
	spec
		group: 'default' with: #('MooseVisuOnSpec' 'MooseVisuOnSpecTests');
		group: 'mvsLoader' with: #('MooseVisuOnSpecModelLoader');
		group: 'utilities' with: #('MooseVisuOnSpec-utilities')
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> baselineForMoose: spec [
	spec
				baseline: 'Moose'
				with: [ spec repository: 'github://moosetechnology/Moose:development/src' ] 
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> baselineForRoassal2Spec: spec [
	spec
		project: 'Roassal2'
		with: [ spec
				className: #ConfigurationOfRoassal2;
				versionString: '1.21-baseline';
				loads: #('NoGlamour');
				repository: 'http://smalltalkhub.com/mc/ObjectProfile/Roassal2/main/' ]
]

{ #category : #accessing }
BaselineOfMooseVisuOnSpec >> customProjectAttributes [
	self class environment
		at: #MooseEntity
		ifAbsent: [ ^ #(#WithoutMoose) ].
		
	^ #()
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> postload: loader package: packageSpec [

  Transcript crLog: 'Project loaded!'
]

{ #category : #baselines }
BaselineOfMooseVisuOnSpec >> preload: aloader package: packageSpec [
	Transcript crLog: 'Removing Moose repo for now'.
	(IceRepository registry select: [ :aRepository | aRepository name = 'Moose' ]) do: [ :aRepository | aRepository forget ].
]
