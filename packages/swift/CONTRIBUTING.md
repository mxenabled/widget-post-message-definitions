# Contributing

Refer to top-level [CONTRIBUTING.md](/CONTRIBUTING.md) for additional
information.


## Development

This library was developed on Swift v5 and expects a compatible version. Below
are commands that you will need to know about:

- `swift build` to build the main target.
- `swift test` to build the test target and then run unit tests.
- `Scripts/generate-mocks` to re-generate mocks. See the [mocking in unit
  tests](#mocking-in-unit-tests) section below for additional information.

Any changes that need to be done to the generated code in the `Sources`
directory should be done by updating the definitions file or the template
generator in [Widget Post Message
Definitions](https://github.com/mxenabled/widget-post-message-definitions).


### Mocking in unit tests

We use [Mockingbird](https://github.com/birdrides/mockingbird) to generate mock
classes. The generated test code lives in the `Tests/Generated` directory and
should only be modified by Mockingbird and never manually.

To generate a mocking class and start mocking a protocol, add
`mock(<protocol>.self)` in your test file and run `Scripts/generate-mocks`. You
only need to run this command if there's a change done to a mocked protocol, or
a new protocol is mocked. Make sure to commit any changes done to the generated
code.
