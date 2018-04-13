#!/usr/bin/env bats

@test "+1d" {
	[ "$(cat test/hiking.gpx|dist/cli.js +1d|shasum)" = "a94c71a7358b484e4b0977981e00110f620b44e8  -" ]
}

@test "+1h" {
	[ "$(cat test/hiking.gpx|dist/cli.js +1h|shasum)" = "67ce59f0b361482868b715d272bfa6bae086f116  -" ]
}

@test "+1000m" {
	[ "$(cat test/hiking.gpx|dist/cli.js +1000m|shasum)" = "5c28b705f04c21452e712a621a3fb59841b836cd  -" ]
}

@test "-1000s" {
	[ "$(cat test/hiking.gpx|dist/cli.js -1000s|shasum)" = "468228c6fbae69d9051ee8ddc90ce0a81aff0e9f  -" ]
}

@test "notimestamp" {
	[ "$(cat test/notimestamp.gpx|dist/cli.js -1s|shasum)" = "0b1accf753ba8ed4367e6488b5c3d560f6d1be1b  -" ]
}
