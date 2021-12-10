# Odontoradiosis SemiautomaticLandmarks

TODO: Put a short description of the package here that helps potential users know whether this
package might be useful for them.

## Features

Calculate the position of all landmarks given in routine descriptions. This is done based on
information given about tracing curves

## Getting started

This package has as its only requisite the package `odontoradiosis_interfaces`

## Usage

TODO: Include short and useful examples for package users. Add longer examples to `/example` folder.

How to use semiautomatic_routines

```dart
import 'package:odontoradiosis_semiautomatic_landmarks/semiautomatic_routines.dart' as routines;

void main() {
  /* ... */
  final routineExecutor = SemiautomaticLandmarks(
    const [
      routines.a,
      routines.b,
      routines.condilio,
      routines.ena,
      routines.enp,
      routines.fissuraPtergoMaxilar,
      routines.gnatio,
      routines.gonio,
      routines.mento,
      routines.nasio,
      routines.orbitale,
      routines.palatoMole,
      routines.pogonio,
      routines.pogonioMole,
      routines.porio,
      routines.proNasal,
      routines.pterigoide,
      routines.sela,
    ],
    null,
    null,
  );
  /* ... */
}
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to contribute to the
package, how to file issues, what response they can expect from the package authors, and more.
