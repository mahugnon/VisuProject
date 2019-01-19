Extension { #name : #MooseGroup }

{ #category : #'*Homework' }
MooseGroup >> contextMenuOn: aPresenter [
	^ aPresenter listView
		menu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updatePastWith: aPresenter selected.
									aPresenter updateListViewItems: aPresenter selected cacheMooseGroups entityCache ] ] ];
				buildWithSpecAsPopup ]
]
