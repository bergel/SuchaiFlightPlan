Class {
	#name : #FPModel,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #initialization }
FPModel >> addEvent: anEvent [
	events add: anEvent
]

{ #category : #initialization }
FPModel >> example [
	<script: 'self new example inspect'>
	self parseText: FlightPlanTest new data.
	
	
]

{ #category : #initialization }
FPModel >> exampleMission [
	"
	SCL sends mission to S1 
	S1 says to S2 to take picture of CAL
	S2 takes picture of CAL
	S2 sends to S1 the picture
	S1 sends picture to SCL 
	"

	| rule1 rule2 rule3 rule4 rule5 |
	rule1 := FPRule from: 'SCL' to: 'S1'. "perform send instruction"
	rule2 := FPRule from: 'S1' to: 'S2'. "Send mission to S2"
	rule3 := FPRule from: 'S2' to: 'CAL'.
	rule4 := FPRule from: 'S2' to: 'S1'.
	rule5 := FPRule from: 'S1' to: 'SCL'
]

{ #category : #'as yet unclassified' }
FPModel >> getEventFrom: from to: to [
	^ events select: [ :e | e from = from and: [ e to = to ] ]
]

{ #category : #initialization }
FPModel >> initialize [
	super initialize.
	events := OrderedCollection new
]

{ #category : #initialization }
FPModel >> parseText: aText [
	| table |
	table := RTTable new input: FlightPlanTest new data.
	table removeFirstRow.
	table convertColumnsToFloat: #(1 2).
	table values do: [ :row | self addEvent: (FPEvent new fillFrom: row) ]
]
