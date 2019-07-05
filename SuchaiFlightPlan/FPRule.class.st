Class {
	#name : #FPRule,
	#superclass : #Object,
	#instVars : [
		'fromString',
		'toString'
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
