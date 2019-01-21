Extension { #name : #FAMIXClassGroup }

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> contextMenuWith: aBoolean On: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updatePastWith: aPresenter selected.
									aPresenter updateListViewItems: aPresenter selected.
									aBoolean
										ifTrue: [ aPresenter openResultInNewWindow ] ] ];
						addItem: [ :item | 
							item
								name: 'Visualize';
								action: [ aPresenter visualizeOptionsOn: aPresenter selected .
									aBoolean
										ifTrue: [ aPresenter openResultInNewWindow ]] ] ];
				buildWithSpecAsPopup ]
]

{ #category : #'*MooseVisuOnSpec' }
FAMIXClassGroup >> drawers [
	^ OrderedCollection new add: HWDeprecatedClassRelationWithForceLayout;yourself 
]