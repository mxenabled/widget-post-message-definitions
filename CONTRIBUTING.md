# Contributing

## Reporting Bugs

When submitting a new bug report, please first
[search](https://github.com/mxenabled/widget-post-message-definitions/issues)
for an existing or similar report. If no duplicate exists, file the issue with
the following information:

1. Steps to reproduce the issue.
2. Example code snippet that causes the issue.


## Development

You'll need Ruby v3 and Node v16 to use and test this project. Other versions
of Node or Ruby that are compatible with the versions mentioned will work as
well. Below are commands we use to perform various tasks:

- `bin/run` runs the code generators.
- `bin/setup` installs Ruby and Node dependencies.
- `bin/console` starts REPL with the project loaded.
- `bin/lint` runs the linter.
- `bin/spellcheck` runs the spellchecker.


## Publishing a new version

As this project is made up of sub-packages, each is individually published to
their respective package managers. Refer to the documents linked below for
details on publishing each package:

- [TypeScript Package](/packages/typescript/CONTRIBUTING.md)
