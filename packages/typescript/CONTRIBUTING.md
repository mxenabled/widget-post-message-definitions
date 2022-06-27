# Contributing

Refer to top-level [CONTRIBUTING.md](/CONTRIBUTING.md) for additional
information.


## Development

You'll need Node v16 to build and test this project. Below are commands we use
to perform various tasks:

- `npm install` install dependencies.
- `npm run build` compile code.
- `npm run test` run tests.
- `npm run lint` run linter.
- `npm run format` run code formatter.


## Publishing a new version

1. Update the `version` in `package.json`.
2. Run `npm install` to update lock file.
3. Commit your changes.
4. Create the git tag with `git tag v<version>` (eg, `git tag v1.0.3`)
5. Push the commit and the tag, `git push origin master --tags`
6. Run `npm login` and log into an account with permission to publish to the
   [mxenabled][mxenabled_npm_org] organization in npm.
7. Run `npm publish` to publish. Note that running this command will
   automatically execute `npm run build` for you.


[mxenabled_npm_org]: https://www.npmjs.com/org/mxenabled "mxenabled npm organization"
