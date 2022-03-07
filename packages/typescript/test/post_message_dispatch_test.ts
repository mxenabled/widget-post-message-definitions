import { dispatchConnectLocationChangeEvent } from "../src"

describe("Post Message Dispatch", () => {
  const sessionData = {
    user_guid: "USR-123",
    session_guid: "SES-123",
  }

  const memberPayload = { ...sessionData, member_guid: "MBR-123" }

  const genPostMessageUrl = (url: string, metadata: unknown) =>
    `${url}?metadata=${encodeURIComponent(JSON.stringify(metadata))}`

  describe("dispatchConnectLocationChangeEvent", () => {
    test("onMessage callback is called with valid post message", () => {
      const url = genPostMessageUrl("mx://connect/memberDeleted", memberPayload)

      dispatchConnectLocationChangeEvent(url, {
        onMessage: (postMessageUrl) => {
          expect(postMessageUrl).toBe(url)
        }
      })
    })

    test("corresponding callback is called with parsed payload", () => {
      const url = genPostMessageUrl("mx://connect/memberDeleted", memberPayload)

      dispatchConnectLocationChangeEvent(url, {
        onMemberDeleted: (payload) => {
          expect(payload.member_guid).toBe(memberPayload.member_guid)
          expect(payload.user_guid).toBe(memberPayload.user_guid)
          expect(payload.session_guid).toBe(memberPayload.session_guid)
        }
      })
    })

    test("corresponding callback and onMessage are both called", () => {
      const url = genPostMessageUrl("mx://connect/memberDeleted", memberPayload)

      dispatchConnectLocationChangeEvent(url, {
        onMessage: (postMessageUrl) => {
          expect(postMessageUrl).toBe(url)
        },
        onMemberDeleted: (payload) => {
          expect(payload.member_guid).toBe(memberPayload.member_guid)
        }
      })
    })
  })
})
