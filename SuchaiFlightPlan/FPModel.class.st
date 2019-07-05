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
	self parseText: FlightPlanTest new data
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
