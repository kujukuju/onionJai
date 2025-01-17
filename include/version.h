/*
	Onion HTTP server library
	Copyright (C) 2010-2016 David Moreno Montero and others

	This library is free software; you can redistribute it and/or
	modify it under the terms of, at your choice:

	a. the Apache License Version 2.0.

	b. the GNU General Public License as published by the
		Free Software Foundation; either version 2.0 of the License,
		or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of both libraries, if not see
	<http://www.gnu.org/licenses/> and
	<http://www.apache.org/licenses/LICENSE-2.0>.
	*/

#ifndef __ONION_VERSION_H__
#define __ONION_VERSION_H__

#include <onion/log.h>

/// Current version your code is using
#define ONION_VERSION "0.8.191.de8ea"
/// Current major version your code is using
/* #undef ONION_VERSION_MAJOR */
/// Current minor version your code is using
#define ONION_VERSION_MINOR 8
/// Current patch version your code is using
#define ONION_VERSION_PATCH 191


// Cmake should substitue above here, but when == 0, it does not.
#ifndef ONION_VERSION_MAJOR
# define ONION_VERSION_MAJOR 0
#endif
#ifndef ONION_VERSION_MINOR
# define ONION_VERSION_MINOR 0
#endif
#ifndef ONION_VERSION_PATCH
# define ONION_VERSION_PATCH 0
#endif

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

/// current running onion version as a string
const char *onion_version();
/// current running onion major version
int onion_version_major();
/// current running onion minor version
int onion_version_minor();
/// current running onion patch version
int onion_version_patch();

/// Checks a specific set of major.minor.patch and returns if the current using onion is ABI compatible.
bool onion_version_is_compatible3(int major, int minor, int patch);

/// Macro to ensure the version of onion your program is using is ABI compatible with the library one
#define ONION_VERSION_IS_COMPATIBLE() onion_version_is_compatible3(ONION_VERSION_MAJOR, ONION_VERSION_MINOR, ONION_VERSION_PATCH)

/// Macro to ensure the version of onion your program is using is ABI compatible with the library one. It aborts if its not compatible.
#define ONION_VERSION_IS_COMPATIBLE_OR_ABORT() { \
	if (!ONION_VERSION_IS_COMPATIBLE()){ \
		ONION_ERROR("Onion version is not compatible. Requires a %s compatible version.", onion_version()); \
		abort(); \
 	} }

#ifdef __cplusplus
}
#endif

#endif
