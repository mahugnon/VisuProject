Extension { #name : #FAMIXClass }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> contextMenuWith: aBoolean On: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						
						addItem: [ :item | 
							item
								name: 'Visualize';
								action: [ aPresenter visualizeOptionsOn: aPresenter selected.
									aBoolean
										ifTrue: [ aPresenter openResultInNewWindow ] ] ] ];
				buildWithSpecAsPopup ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> drawers [
	^ OrderedCollection new
		add: HWFMClassInheritanceTree ;
	
		yourself
]
