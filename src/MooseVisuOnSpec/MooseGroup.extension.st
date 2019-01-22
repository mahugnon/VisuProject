Extension { #name : #MooseGroup }

{ #category : #'*MooseVisuOnSpec' }
MooseGroup >> contextMenuOn: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updateListViewItems: aPresenter selected.
									aPresenter openResultInNewWindow  ] ] ];
				buildWithSpecAsPopup ]
]
