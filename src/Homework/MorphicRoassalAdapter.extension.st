Extension { #name : #MorphicRoassalAdapter }

{ #category : #'*Homework' }
MorphicRoassalAdapter >> basicApplyScript [
	self model script cull: view cull: canvas.
	self view canvas camera adjust.
	self widgetDo: [ :w | w startStepping ]
]
