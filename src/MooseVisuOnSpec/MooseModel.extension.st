Extension { #name : #MooseModel }

{ #category : #'*MooseVisuOnSpec' }
MooseModel >> contextMenuOn: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updateListViewItems: aPresenter selected cacheMooseGroups entityCache.
									aPresenter openResultInNewWindow ] ] ];
				buildWithSpecAsPopup ]
]
