Class {
	#name : #FPModel,
	#superclass : #Object,
	#instVars : [
		'events',
		'satellites',
		'locations',
		'rules'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #initialization }
FPModel >> addEvent: anEvent [
	events add: anEvent
]

{ #category : #initialization }
FPModel >> addLocation: aSatelliteName [
	satellites add: (FPLocation new name: aSatelliteName)
]

{ #category : #initialization }
FPModel >> addRule: aRule [
	rules add: aRule
]

{ #category : #initialization }
FPModel >> addSatellite: aSatelliteName [
	satellites add: (FPSatellite new name: aSatelliteName)
]

{ #category : #initialization }
FPModel >> example [
	<script: 'self new example inspect'>
	self parseText: FlightPlanTest new data.
	
	
]

{ #category : #'as yet unclassified' }
FPModel >> exampleFull [
	<script: 'self new exampleFull inspect'>
	| model g |
	model := FPModel new.
	model exampleMission.

	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 300.
	g numberOfGenes: model numberOfRules.
	g createGeneBlock: [ :rand :index :ind | 
		(model rules at: index) relatedEvents atRandom: rand 
	].
	g minimizeComparator.
	g fitnessBlock: [ :genes | (FPMission new events: genes) fitness ].

	g run.
	g inspect.

	^ FPMission new events: g result.
]

{ #category : #initialization }
FPModel >> exampleLongMission [
	<script: 'self new exampleLongMission inspect'>
	"
	SCL sends mission to S1 
	S1 says to S2 to take picture of CAL
	S2 takes picture of CAL
	S2 sends to S1 the picture
	S1 sends picture to SCL 
	"

	self addSatellite: 'S1'.
	self addSatellite: 'S2'.
	self addLocation: 'CAL'.
	self addLocation: 'SCL'.
	
	self addRule: (FPRule from: 'SCL' to: 'S1'). "perform send instruction"
	self addRule: (FPRule from: 'S1' to: 'S2'). "Send mission to S2"
	self addRule: (FPRule from: 'S2' to: 'CAL').
	self addRule: (FPRule from: 'S2' to: 'S1').
	self addRule: (FPRule from: 'S1' to: 'SCL').

	self addRule: (FPRule from: 'S2' to: 'SAA').
	self addRule: (FPRule from: 'S2' to: 'S1').
	self addRule: (FPRule from: 'S1' to: 'SCL').

	
	self parseText: FlightPlanTest new data.
	self processEvents.
	
]

{ #category : #initialization }
FPModel >> exampleLongMission2 [
	<script: 'self new exampleLongMission2 inspect'>
	"
	SCL sends mission to S1 
	S1 says to S2 to take picture of CAL
	S2 takes picture of CAL
	S2 sends to S1 the picture
	S1 sends picture to SCL 
	"

	self addSatellite: 'S1'.
	self addSatellite: 'S2'.
	self addLocation: 'CAL'.
	self addLocation: 'SCL'.
	
	self addRule: (FPRule from: 'SCL' to: 'S1'). "perform send instruction"
	self addRule: (FPRule from: 'S1' to: 'S2'). "Send mission to S2"
	
	self addRule: (FPRule from: 'S2' to: 'CAL').
	self addRule: (FPRule from: 'S2' to: 'S1').
	
	self addRule: (FPRule from: 'S2' to: 'CAL').
	self addRule: (FPRule from: 'S2' to: 'S1').

	self addRule: (FPRule from: 'S1' to: 'SCL').

	
	self parseText: FlightPlanTest new data.
	self processEvents.
	
]

{ #category : #initialization }
FPModel >> exampleMission [
	<script: 'self new exampleMission inspect'>
	"
	SCL sends mission to S1 
	S1 says to S2 to take picture of CAL
	S2 takes picture of CAL
	S2 sends to S1 the picture
	S1 sends picture to SCL 
	"

	self addSatellite: 'S1'.
	self addSatellite: 'S2'.
	self addLocation: 'CAL'.
	self addLocation: 'SCL'.
	
	self addRule: (FPRule from: 'SCL' to: 'S1'). "perform send instruction"
	self addRule: (FPRule from: 'S1' to: 'S2'). "Send mission to S2"
	self addRule: (FPRule from: 'S2' to: 'CAL'). "S2 takes picture of California"
	self addRule: (FPRule from: 'S2' to: 'S1'). "S2 sends the picture to S1"
	self addRule: (FPRule from: 'S1' to: 'SCL'). "S1 sends the picture to the ground"
	
	self parseText: FlightPlanTest new data.
	self processEvents.
	
]

{ #category : #'as yet unclassified' }
FPModel >> getEventFrom: from to: to [
	^ events select: [ :e | e from = from and: [ e to = to ] ]
]

{ #category : #initialization }
FPModel >> initialize [
	super initialize.
	events := OrderedCollection new.
	satellites := OrderedCollection new.
	locations := OrderedCollection new.
	rules := OrderedCollection new
]

{ #category : #'as yet unclassified' }
FPModel >> numberOfRules [
	^ rules size
]

{ #category : #initialization }
FPModel >> parseText: aText [
	| table |
	table := RTTable new input: FlightPlanTest new data.
	table removeFirstRow.
	table convertColumnsToFloat: #(1 2).
	table values do: [ :row | self addEvent: (FPEvent new fillFrom: row) ]
]

{ #category : #initialization }
FPModel >> processEvents [
	events do: [ :evt |
		rules do: [ :r | r process: evt ] ]
]

{ #category : #'as yet unclassified' }
FPModel >> rules [
	^ rules
]
