Extension { #name : #MooseGroup }

{ #category : #'*MooseVisuOnSpec' }
MooseGroup >> contextMenuWith: aBoolean On: aPresenter [
	^ aPresenter
		listViewMenu: [ :aMenu | 
			MenuPresenter new
				addGroup: [ :group | 
					group
						addItem: [ :item | 
							item
								name: 'Open';
								action: [ aPresenter updatePastWith: aPresenter selected.
									aPresenter updateListViewItems: aPresenter selected .
									aBoolean ifTrue: [aPresenter openResultInNewWindow]] ] ];
				buildWithSpecAsPopup ]
]