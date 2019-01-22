Extension { #name : #FAMIXClassGroup }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> contextMenuOn: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updateListViewItems: aPresenter selected.
									aPresenter openResultInNewWindow ] ];
						addItem: [ :item | 
							item
								name: 'Visualize';
								action: [ aPresenter drawerOptionsOn: aPresenter selected.
									 ] ] ];
				buildWithSpecAsPopup ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> drawers [
	^ OrderedCollection new
		add: HWDeprecatedClassRelationWithForceLayout;
		add: HWSystemComplexity; yourself
]
