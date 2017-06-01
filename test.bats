#!/usr/bin/env bats

@test "+1d" {
	[ "$(cat test/hiking.gpx|dist/cli.js +1d|shasum)" = "21fe52f066736b2c2f57ca6cb7e65e876e09089c  -" ]
}

@test "+1h" {
	[ "$(cat test/hiking.gpx|dist/cli.js +1h|shasum)" = "0064616bc1cd1eeaffb86ddebc97e0711ecfce56  -" ]
}

@test "+1000m" {
	[ "$(cat test/hiking.gpx|dist/cli.js +1000m|shasum)" = "ada9d78e06b5fdd5f8c014e0c97bdf5d8fed5aa5  -" ]
}

@test "-1000s" {
	[ "$(cat test/hiking.gpx|dist/cli.js -1000s|shasum)" = "99405bc6430e631f21fa522a88796f0276040beb  -" ]
}

@test "notimestamp" {
	[ "$(cat test/notimestamp.gpx|dist/cli.js -1s|shasum)" = "0b1accf753ba8ed4367e6488b5c3d560f6d1be1b  -" ]
}
