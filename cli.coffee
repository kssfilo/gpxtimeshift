#!/usr/bin/env coffee

Rx=require 'rxjs'
require('rxjs-exec').patch(Rx.Observable)
GpxTimeShift=require './gpxtimeshift'

arg=process.argv[2]

if arg is '-h' or !arg
	console.log """
		gpxtimeshift [-h] <offset> < <gpxfile>

		example:
			gpxtimeshift +1s < today.gpx
			gpxtimeshift +1h < today.gpx
			gpxtimeshift +1d < today.gpx
			gpxtimeshift +1m < today.gpx
			gpxtimeshift -1d < today.gpx
	"""
	process.exit 0

pa=arg.match /^([+-])(\d+)([hdms])$/
if !pa
	console.error "Invalid offset"
	process.exit 1

offset=parseInt(pa[2])*
	switch pa[3]
		when 'h' then 3600
		when 'm' then 60
		when 's' then 1
		when 'd' then 3600*24
offset*=(if pa[1] is '-' then -1 else 1)

Rx.Observable.exec 'cat',{stdin:true}
.toArray().map (x)->x.join ''
.flatMap (gpxxml)->Rx.Observable.fromPromise GpxTimeShift(gpxxml,offset)
.catch (e)->console.error e
.subscribe (r)->console.log r
