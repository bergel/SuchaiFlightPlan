Class {
	#name : #FPMission,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #SuchaiFlightPlan
}

{ #category : #accessing }
FPMission >> events: someEvents [
	events := someEvents
]

{ #category : #accessing }
FPMission >> fitness [
	"We want to minimize the fitness"
	| t penaltyForOrder prev |
	
	"julianDayNumber"
	t := (events collect: [ :e | e startTimeAsUnixEpoch ]) - events first startTimeAsUnixEpoch.
	penaltyForOrder := 0.
	prev := t first.
	t allButFirst do: [ :tt |
		prev > tt ifTrue: [ penaltyForOrder := penaltyForOrder + ((tt - prev) raisedTo: 2) ].
		prev := tt ].
	^ penaltyForOrder * 100 + (self length asMinutes max: 0)
]

{ #category : #visualization }
FPMission >> gtInspectorEventsIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite list
		title: 'Events';
		display: [ events ]
]

{ #category : #visualization }
FPMission >> gtInspectorMetricsIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: 'Metrics';
		display: [ 
			| w |
			w := WriteStream on: String new.
			w nextPutAll: 'Is Valid = '.
			w nextPutAll: self isValid asString.
			w cr.
			w nextPutAll: 'Length (days) = '.
			w nextPutAll: self length asDays asString.
			w cr.
			w nextPutAll: 'Length (hours) = '.
			w nextPutAll: self length asHours asString.
			w cr.
			w nextPutAll: 'Length (minutes) = '.
			w nextPutAll: self length asMinutes asString.
			w cr.
			w contents 
			]
]

{ #category : #visualization }
FPMission >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'View';
		initializeView: [ 
			self visualizeEvents ]
]

{ #category : #accessing }
FPMission >> isValid [
	| t |
	t := events first endTimeAsUnixEpoch.
	events allButFirst do: [ :e | 
		t < e startTimeAsUnixEpoch ifFalse: [ ^ false ].
		t := e startTimeAsUnixEpoch ].
	^ true
]

{ #category : #accessing }
FPMission >> length [
	^ events last endTime - events first startTime
	"^ Duration milliSeconds: (events last endTimeAsUnixEpoch - events first startTimeAsUnixEpoch)"
]

{ #category : #visualization }
FPMission >> visualizeEvents [
	| v es |
	v := RTView new.
	es := RTShapeBuilder new 
				circle;
				size: 10;
				color: Color red trans;
				elementsOn: events.
	v addAll: es.
	RTMetricNormalizer new
		elements: es;
		normalizeX: #startTimeAsUnixEpoch.
	es @ RTPopup.
	^ v
]
