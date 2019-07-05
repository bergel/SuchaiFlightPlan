Class {
	#name : #FPEvent,
	#superclass : #Object,
	#instVars : [
		'id',
		'fromString',
		'toString',
		'startTime',
		'endTime'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #'as yet unclassified' }
FPEvent >> fillFrom: separatedRow [

	"
	FPEvent new fillFrom: #(0.0 0.0 '706.33' 'S1' '1' '19 Jun 2019 17:04:52.397' '19 Jun 2019 17:16:38.728' 'S2' '2')
	"
	id := separatedRow second asInteger.
	fromString := separatedRow fourth.
	toString := separatedRow eighth.
	startTime := DateAndTime fromString: separatedRow sixth.
	endTime := DateAndTime fromString: separatedRow seventh.	
]

{ #category : #printing }
FPEvent >> printOn: str [
	str nextPut: $<.
	fromString ifNotNil: [ str nextPutAll: fromString ].
	str nextPutAll: ' <-> '.
	toString ifNotNil: [ str nextPutAll: toString ].
	str nextPut: $>
]
