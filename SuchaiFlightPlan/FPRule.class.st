Class {
	#name : #FPRule,
	#superclass : #Object,
	#instVars : [
		'fromString',
		'toString',
		'relatedEvents'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #'instance creation' }
FPRule class >> from: from to: to [
	^ self new from: from to: to
]

{ #category : #'instance creation' }
FPRule >> from: from to: to [
	fromString := from.
	toString := to.
]

{ #category : #initialization }
FPRule >> initialize [
	super initialize.
	relatedEvents := OrderedCollection new
]

{ #category : #private }
FPRule >> process: anEvent [
	({ fromString . toString } asSet = { anEvent fromString . anEvent toString } asSet )
		ifTrue: [ relatedEvents add: anEvent ]
]

{ #category : #accessing }
FPRule >> relatedEvents [
	^ relatedEvents
]

{ #category : #'as yet unclassified' }
FPRule >> relatedEventsAfter: aDateAndTime [
	| t |
	t := relatedEvents select: [ :e | aDateAndTime < e startTimeAsUnixEpoch ].
	^ t ifEmpty: [ relatedEvents ]
		ifNotEmpty: [ t ]
]

{ #category : #'as yet unclassified' }
FPRule >> relatedEventsAfterEvent: anEvent [

	^ self relatedEventsAfter: anEvent endTimeAsUnixEpoch
]
