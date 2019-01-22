Extension { #name : #FAMIXClass }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> contextMenuOn: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Visualize';
								action: [ aPresenter drawerOptionsOn: aPresenter selected.
									aPresenter openResultInNewWindow ] ] ];
				buildWithSpecAsPopup ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClass >> drawers [
	^ OrderedCollection new
		add: HWFMClassInheritanceTree ;
	
		yourself
]
