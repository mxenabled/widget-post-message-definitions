import type { EnvironmentContext } from "@jest/environment"

const NodeEnvironment = require("jest-environment-node")

/**
 * Our tests need to create new MessageEvent objects which are not available in
 * Jest's global environment. Jest has addressed this but hasn't released a
 * version with the fix yet. When they do we can remove this file and the
 * corresponding configuration in package.json.
 *
 * This is the Jest PR with the fix: https://github.com/facebook/jest/pull/12553
 */
module.exports = class Environment extends NodeEnvironment {
  constructor(config: unknown, _context: EnvironmentContext) {
    super(config, _context)

    if (typeof MessageEvent !== "undefined") {
      this.global.MessageEvent = MessageEvent
    }
  }
}
