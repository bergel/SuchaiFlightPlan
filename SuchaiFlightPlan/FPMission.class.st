Class {
	#name : #FPMission,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #initialization }
FPMission >> addRule: aRule [
	rules add: aRule
	
]

{ #category : #initialization }
FPMission >> initialize [
	super initialize.
	rules := OrderedCollection new
]
