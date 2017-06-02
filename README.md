gpxtimeshift
==========

Command line tool to shift timestamps in GPX file by specified offset

```
#example
gpxtimeshift +1h < today.gpx
```

## Install

```
sudo npm install -g gpxtimeshift
```

## Usage

```
@PARTPIPE@|dist/cli.js -h

!!SEE NPM README!!

@PARTPIPE@
```

## Use as module

```
var GpxTimeShift=require('gpxtimeshift')

gpxString="<?xml version ......</gpx>"
offsetSeconds=-3600;

GpxTimeShift(gpxString,offsetSeconds)
.then(function(gpxString){
	console.log(gpxString);
});
```

## Change Log

- 0.1.x:first release
