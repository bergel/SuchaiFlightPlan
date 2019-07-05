Class {
	#name : #FPObject,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #accessing }
FPObject >> name [
	^ name
]

{ #category : #accessing }
FPObject >> name: aString [
	name := aString
]
