Extension { #name : #FAMIXClassGroup }

{ #category : #'*Homework' }
FAMIXClassGroup >> contextMenuOn: aPresenter [
	^ aPresenter listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updatePastWith: aPresenter selected.
									aPresenter updateListViewItems: aPresenter selected cacheMooseGroups entityCache ] ];
						addItem: [ :item | 
							item
								name: 'Visualize';
								action: [ aPresenter visualizeOptionsOn: aPresenter selected ] ] ];
				buildWithSpecAsPopup ]
]

{ #category : #'*Homework' }
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
									aPresenter updateListViewItems: aPresenter selected cacheMooseGroups 									entityCache.
									aBoolean
										ifTrue: [ aPresenter openResultInNewWindow ] ] ];
						addItem: [ :item | 
							item
								name: 'Visualize';
								action: [ aPresenter visualizeOptionsOn: aPresenter selected ] ] ];
				buildWithSpecAsPopup ]
]

{ #category : #'*Homework' }
FAMIXClassGroup >> drawers [
	^ OrderedCollection new add: HWDeprecatedClassRelationWithForceLayout;yourself 
]
