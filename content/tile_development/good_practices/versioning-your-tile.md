# Versioning Your Tile

This topic describes our recommendations for versioning your tile.

## Overview

In an ideal world, all tiles could all be independently versioned, per [Semantic Versioning](https://semver.org/), and we could call it a day.
However, there are other influences to tile version numbers.
Your marketing department could require your tile version to reflect align with your core product version.
Ops Manager has a more stringent version structure than full Semantic Versioning.
Here we describe the best practices for versioning your tile.

## Follow Semantic Versioning

[Semantic Versioning](https://semver.org/) is the place to start.

## Ops Manager Version Restrictions

Ops Manager supports [versions per the Ruby `Gem::Version` module](https://github.com/rubygems/rubygems/blob/ed6641c2f36268a89c6db150fca5768e225cf804/lib/rubygems/version.rb#L158).
This basically boils down to something of the form `1.2.3` or `1.2.3-alpha.123`, or `1.2.3-foobar`.
This is a subset of Semantic Versioning, most notably lacking the `+<build-number>` syntax.

## Give Each Build a Unique Version

Even without the Semantic Versioning build specifier syntax, it is possible to give each build a unique version number.
Doing so will help you, and help our team help you, in reproducing behavior while debugging your tile.
Iterating on a build using the same version is an easy way to cause confusion and waste time debugging the wrong bits.

## Putting It Together

A few patterns we have seen used successfully:

- **Increment patch**: `1.2.3` (the third build on the 1.2 release cycle).
- **Increment build number**: `1.2.3-build.42` (the 42nd build of the 1.2.3 release cycle).
- **Include a timestamp**: `1.2.3-build.20191021.1245.24` (build was performed on October 21, 2019, at 12:45:24pm).
