### globals Promise ###

Xml2Js=require 'xml2js'
XmlParser=new Xml2Js.Parser()
XmlBuilder=new Xml2Js.Builder()
Rx=require 'rxjs'

gpxTimeShift=(gpxString,offsetSeconds)->
	new Promise (rs,rj)->

		shiftTime=(time,offsetSeconds)->
			d=new Date(time).getTime()
			new Date(d+=offsetSeconds*1000).toISOString()

		Rx.Observable.of gpxString
		.flatMap (gpxxml)->Rx.Observable.bindNodeCallback(XmlParser.parseString)(gpxxml)
		.map (gpx)->
			if gpx.gpx?.time?
				gpx.gpx.time=shiftTime(gpx.gpx.time,offsetSeconds)
			for i in [0..gpx.gpx.trk.length-1]
				for j in [0..gpx.gpx.trk[i].trkseg.length-1]
					for k in [0..gpx.gpx.trk[i].trkseg[j].trkpt.length-1]
						if gpx.gpx.trk[i].trkseg[j].trkpt[k].time?
							gpx.gpx.trk[i].trkseg[j].trkpt[k].time=shiftTime(gpx.gpx.trk[i].trkseg[j].trkpt[k].time,offsetSeconds)
			gpx
		.map (gpx)->XmlBuilder.buildObject gpx
		.catch (e)->rj e
		.subscribe (r)->rs r

module.exports=gpxTimeShift
