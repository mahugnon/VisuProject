Extension { #name : #MooseGroup }

{ #category : #'*Homework' }
MooseGroup >> contextMenuOn: aPresenter [
	^ aPresenter listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updatePastWith: aPresenter selected.
									aPresenter updateListViewItems: aPresenter selected ] ] ];
				buildWithSpecAsPopup ]
]
