Extension { #name : #MooseModel }

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> contextMenuWith: aBoolean On:  aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updatePastWith: aPresenter selected.
									aPresenter updateListViewItems: aPresenter selected cacheMooseGroups entityCache . aBoolean
										ifTrue: [ aPresenter openResultInNewWindow ] ] ] ];
				buildWithSpecAsPopup ]
]
