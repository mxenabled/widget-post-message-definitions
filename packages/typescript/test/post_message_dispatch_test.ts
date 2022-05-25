import {
  WidgetPostMessageCallbackProps,
  dispatchConnectLocationChangeEvent,
  dispatchConnectPostMessageEvent,
  dispatchPulseLocationChangeEvent,
  dispatchWidgetLocationChangeEvent,
} from "../src"

const genPostMessageUrl = (url: string, metadata: unknown = {}) =>
  `${url}?metadata=${encodeURIComponent(JSON.stringify(metadata))}`

const userGuid = "USR-123"
const sessionGuid = "SES-123"
const memberGuid = "MBR-123"
const accountGuid = "ACT-123"
const session = {
  user_guid: userGuid,
  session_guid: sessionGuid,
}

const loadUrl = genPostMessageUrl("mx://load")
const pingUrl = genPostMessageUrl("mx://ping", session)
const navigationUrl = genPostMessageUrl("mx://navigation", {
  ...session,
  did_go_back: true,
})
const focusTrapUrl = genPostMessageUrl("mx://focusTrap", session)

const connectMemberDeletedMessage = new MessageEvent("message", {
  data: {
    mx: true,
    type: "mx/connect/memberDeleted",
    metadata: {
      ...session,
      member_guid: memberGuid,
    },
  },
})

const connectMemberDeletedUrl = genPostMessageUrl("mx://connect/memberDeleted", {
  ...session,
  member_guid: memberGuid,
})

const connectMemberDeletedUrlInvalidField = genPostMessageUrl("mx://connect/memberDeleted", {
  ...session,
  member_guid: 777,
})

const connectMemberDeletedUrlMissingField = genPostMessageUrl("mx://connect/memberDeleted", {
  ...session,
})

const initialStep = "mfa"
const connectLoadedUrl = genPostMessageUrl("mx://connect/loaded", {
  ...session,
  initial_step: initialStep,
})

const connectionStatus = 6
const connectMemberStatusUpdateUrl = genPostMessageUrl("mx://connect/memberStatusUpdate", {
  ...session,
  member_guid: memberGuid,
  connection_status: connectionStatus,
})

const institutionCode = "INST"
const institutionGuid = "INS-123"
const connectUpdateCredentialsUrl = genPostMessageUrl("mx://connect/updateCredentials", {
  ...session,
  member_guid: memberGuid,
  institution: {
    code: institutionCode,
    guid: institutionGuid,
  },
})

const connectOAuthErrorWithMemberGuidUrl = genPostMessageUrl("mx://connect/oauthError", {
  ...session,
  member_guid: memberGuid,
})

const connectOAuthErrorWithoutMemberGuidUrl = genPostMessageUrl("mx://connect/oauthError", {
  ...session,
})

const amount = 42
const pulseOverdraftWarningCtaTransferFundsUrl = genPostMessageUrl(
  "mx://pulse/overdraftWarning/cta/transferFunds",
  {
    account_guid: accountGuid,
    amount: amount,
  },
)

const invalidMessageUrl = genPostMessageUrl("mx://bad/memberDeleted", {
  ...session,
})

const invalidMessage = new MessageEvent("message", {
  data: {},
})

const account = {
  guid: accountGuid,
}
const accountCreatedUrl = genPostMessageUrl("ms://account/created", account)

const testSharedCallbacks = (
  dispatch: (url: string, callbacks: WidgetPostMessageCallbackProps<string>) => void,
) => {
  describe("onMessage", () => {
    test("callback is called with valid post message", () => {
      expect.assertions(1)

      dispatch(connectMemberDeletedUrl, {
        onMessage: (url) => {
          expect(url).toBe(connectMemberDeletedUrl)
        },
      })
    })

    test("callback is called with invalid post message", () => {
      expect.assertions(1)

      dispatch(invalidMessageUrl, {
        onMessage: (url) => {
          expect(url).toBe(invalidMessageUrl)
        },
      })
    })
  })

  describe("onInvalidMessageError", () => {
    test("callback is called when the given post message is not recognized", () => {
      expect.assertions(2)

      dispatch(invalidMessageUrl, {
        onInvalidMessageError: (url, error) => {
          expect(url).toBe(invalidMessageUrl)
          expect(error.message).toContain("Unknown post message: mx/bad/memberDeleted")
        },
      })
    })

    test("callback is called when the given post message is recognized but contains a bad field", () => {
      expect.assertions(2)

      dispatch(connectMemberDeletedUrlInvalidField, {
        onInvalidMessageError: (url, error) => {
          expect(url).toBe(connectMemberDeletedUrlInvalidField)
          expect(error.message).toContain(
            "Unable to decode 'member_guid' from 'mx/connect/memberDeleted",
          )
        },
      })
    })

    test("callback is called when the given post message is recognized but contains a missing field", () => {
      expect.assertions(2)

      dispatch(connectMemberDeletedUrlMissingField, {
        onInvalidMessageError: (url, error) => {
          expect(url).toBe(connectMemberDeletedUrlMissingField)
          expect(error.message).toContain(
            "Unable to decode 'member_guid' from 'mx/connect/memberDeleted",
          )
        },
      })
    })
  })

  describe("errors", () => {
    test("when an error is thrown from a callback is it bubbled up", () => {
      expect(() => {
        dispatch(loadUrl, {
          onLoad: () => {
            throw new Error("bad to the bone")
          },
        })
      }).toThrow()
    })
  })

  describe("widget callbacks", () => {
    test("onLoad", () => {
      expect.assertions(1)

      dispatch(loadUrl, {
        onLoad: (payload) => {
          expect(payload).toBeDefined()
        },
      })
    })

    test("onPing", () => {
      expect.assertions(1)

      dispatch(pingUrl, {
        onPing: (payload) => {
          expect(payload.user_guid).toBe(userGuid)
        },
      })
    })

    test("onNavigation", () => {
      expect.assertions(1)

      dispatch(navigationUrl, {
        onNavigation: (payload) => {
          expect(payload.did_go_back).toBe(true)
        },
      })
    })

    test("onFocusTrap", () => {
      expect.assertions(1)

      dispatch(focusTrapUrl, {
        onFocusTrap: (payload) => {
          expect(payload.user_guid).toBe(userGuid)
        },
      })
    })
  })

  describe("entity callbacks", () => {
    test("onAccountCreated", () => {
      expect.assertions(1)

      dispatch(accountCreatedUrl, {
        onAccountCreated: (payload) => {
          expect(payload.guid).toBe(accountGuid)
        },
      })
    })
  })
}

describe("Post Message Dispatch", () => {
  describe(dispatchWidgetLocationChangeEvent, () => {
    testSharedCallbacks(dispatchWidgetLocationChangeEvent)
  })

  describe(dispatchPulseLocationChangeEvent, () => {
    testSharedCallbacks(dispatchPulseLocationChangeEvent)

    describe("pulse callbacks", () => {
      test("message with a non-standard url", () => {
        expect.assertions(2)

        dispatchPulseLocationChangeEvent(pulseOverdraftWarningCtaTransferFundsUrl, {
          onOverdraftWarningCtaTransferFunds: (payload) => {
            expect(payload.account_guid).toBe(accountGuid)
            expect(payload.amount).toBe(amount)
          },
        })
      })
    })
  })

  describe(dispatchConnectLocationChangeEvent, () => {
    testSharedCallbacks(dispatchConnectLocationChangeEvent)

    describe("connect callbacks", () => {
      test("corresponding callback is called with parsed payload", () => {
        expect.assertions(3)

        dispatchConnectLocationChangeEvent(connectMemberDeletedUrl, {
          onMemberDeleted: (payload) => {
            expect(payload.member_guid).toBe(memberGuid)
            expect(payload.user_guid).toBe(userGuid)
            expect(payload.session_guid).toBe(sessionGuid)
          },
        })
      })

      test("corresponding callback and onMessage are both called", () => {
        expect.assertions(2)

        dispatchConnectLocationChangeEvent(connectMemberDeletedUrl, {
          onMessage: (url) => {
            expect(url).toBe(connectMemberDeletedUrl)
          },
          onMemberDeleted: (payload) => {
            expect(payload.member_guid).toBe(memberGuid)
          },
        })
      })

      test("message with a one-of field", () => {
        expect.assertions(1)

        dispatchConnectLocationChangeEvent(connectLoadedUrl, {
          onLoaded: (payload) => {
            expect(payload.initial_step).toBe(initialStep)
          },
        })
      })

      test("message with a number field", () => {
        expect.assertions(1)

        dispatchConnectLocationChangeEvent(connectMemberStatusUpdateUrl, {
          onMemberStatusUpdate: (payload) => {
            expect(payload.connection_status).toBe(connectionStatus)
          },
        })
      })

      test("message with an object field", () => {
        expect.assertions(2)

        dispatchConnectLocationChangeEvent(connectUpdateCredentialsUrl, {
          onUpdateCredentials: (payload) => {
            expect(payload.institution.code).toBe(institutionCode)
            expect(payload.institution.guid).toBe(institutionGuid)
          },
        })
      })

      describe("optional fields", () => {
        test("optional field is included", () => {
          expect.assertions(1)

          dispatchConnectLocationChangeEvent(connectOAuthErrorWithMemberGuidUrl, {
            onOAuthError: (payload) => {
              expect(payload.member_guid).toBe(memberGuid)
            },
          })
        })

        test("optional field is excluded", () => {
          expect.assertions(1)

          dispatchConnectLocationChangeEvent(connectOAuthErrorWithoutMemberGuidUrl, {
            onOAuthError: (payload) => {
              expect(payload.member_guid).toBe(undefined)
            },
          })
        })
      })
    })
  })

  describe(dispatchConnectPostMessageEvent, () => {
    test("corresponding callback is called with parsed payload", () => {
      expect.assertions(3)

      dispatchConnectPostMessageEvent(connectMemberDeletedMessage, {
        onMemberDeleted: (payload) => {
          expect(payload.member_guid).toBe(memberGuid)
          expect(payload.user_guid).toBe(userGuid)
          expect(payload.session_guid).toBe(sessionGuid)
        },
      })
    })

    test("corresponding callback and onMessage are both called", () => {
      expect.assertions(2)

      dispatchConnectPostMessageEvent(connectMemberDeletedMessage, {
        onMessage: (message) => {
          expect(message.data.mx).toBe(true)
        },
        onMemberDeleted: (payload) => {
          expect(payload.member_guid).toBe(memberGuid)
        },
      })
    })

    test("callback is called when the given post message is not recognized", () => {
      expect.assertions(1)

      dispatchConnectPostMessageEvent(invalidMessage, {
        onInvalidMessageError: (message, error) => {
          expect(error.message).toContain("Unknown post message: type not provided")
        },
      })
    })
  })
})
