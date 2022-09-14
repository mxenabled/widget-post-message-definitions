import Foundation
import Mockingbird
import Quick

@testable import MXPostMessageDefinitions

class DispatchingEventsToDelegateTests: QuickSpec {
    override func spec() {
        var delegate: ConnectWidgetEventDelegateMock!
        var dispatcher: ConnectWidgetEventDispatcher!

        beforeEach {
            delegate = mock(ConnectWidgetEventDelegate.self)
            dispatcher = ConnectWidgetEventDispatcher(delegate)
        }

        describe("Generic widgetEvent handler") {
            context("when the post message event is valid") {
                it("calls the generic widgetEvent handler and the event specific handler") {
                    let payload = ConnectWidgetEvent.InstitutionSearch(userGuid: "USR-123",
                                                                       sessionGuid: "SES-123",
                                                                       query: "Epic")
                    dispatcher.dispatch(url("connect/institutionSearch", payload))
                    verify(delegate.widgetEvent(URL(string: "mx://connect/institutionSearch?metadata=\(encode(payload))")!)).wasCalled()
                    verify(delegate.widgetEvent(any(ConnectWidgetEvent.InstitutionSearch.self))).wasCalled()
                }
            }

            context("when the post message event is invalid and cannot be parsed") {
                it("calls the generic widgetEvent handler but not the event specific handler") {
                    dispatcher.dispatch(url("connect/institutionSearch", "badToTheBone"))
                    verify(delegate.widgetEvent(URL(string: "mx://connect/institutionSearch?metadata=%22badToTheBone%22")!)).wasCalled()
                    verify(delegate.widgetEvent(any(ConnectWidgetEvent.InstitutionSearch.self))).wasNeverCalled()
                }
            }
        }

        describe("Error widgetEvent handler") {
            it("calls the error handler when unable to parse the event URL") {
                dispatcher.dispatch(url("bad", "toTheBone"))
                verify(delegate.widgetEvent(.invalidEventURL(url: URL(string: "mx://bad?metadata=%22toTheBone%22")!))).wasCalled()
            }
        }

        describe("ConnectWidgetEventDelegate") {
            it("calls the specific widgetEvent handler") {
                let payload = ConnectWidgetEvent.InstitutionSearch(userGuid: "USR-123",
                                                                   sessionGuid: "SES-123",
                                                                   query: "Epic")
                dispatcher.dispatch(url("connect/institutionSearch", payload))
                verify(delegate.widgetEvent(any(where: { $0 == payload }))).wasCalled()
            }

            it("is able to dispatch an event that includes a struct value") {
                let payload = ConnectWidgetEvent.EnterCredentials(userGuid: "USR-123",
                                                                  sessionGuid: "SES-123",
                                                                  institution: ConnectEnterCredentialsInstitution(code: "i-code",
                                                                                                                  guid: "INS-123"))
                dispatcher.dispatch(url("connect/enterCredentials", payload))
                verify(delegate.widgetEvent(any(where: { $0 == payload }))).wasCalled()
            }

            it("is able to dispatch an event that includes an optional field") {
                let payload = ConnectWidgetEvent.OAuthError(userGuid: "USR-123",
                                                            sessionGuid: "SES-123",
                                                            memberGuid: "MBR-123")
                dispatcher.dispatch(url("connect/oauthError", payload))
                verify(delegate.widgetEvent(any(where: { $0 == payload }))).wasCalled()
            }

            it("is able to dispatch an event that excludes an optional field") {
                let payload = ConnectWidgetEvent.OAuthError(userGuid: "USR-123",
                                                            sessionGuid: "SES-123")
                dispatcher.dispatch(url("connect/oauthError", payload))
                verify(delegate.widgetEvent(any(where: { $0 == payload }))).wasCalled()
            }
        }

        describe("PulseWidgetEventDelegate") {
            var delegate: PulseWidgetEventDelegateMock!
            var dispatcher: PulseWidgetEventDispatcher!

            beforeEach {
                delegate = mock(PulseWidgetEventDelegate.self)
                dispatcher = PulseWidgetEventDispatcher(delegate)
            }

            it("is able to dispatch an event with a complex path") {
                let payload = PulseWidgetEvent.OverdraftWarningCtaTransferFunds(accountGuid: "ACT-123",
                                                                                amount: 321)
                dispatcher.dispatch(url("pulse/overdraftWarning/cta/transferFunds", payload))
                verify(delegate.widgetEvent(any(where: { $0 == payload }))).wasCalled()
            }
        }
    }
}

func url<T: Encodable>(_ hostAndPath: String, _ metadata: T) -> URL {
    return URL(string: "mx://\(hostAndPath)?metadata=\(encode(metadata))")!
}

func encode<T: Encodable>(_ value: T) -> String {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    let data = try! encoder.encode(value)
    let string = String(data: data, encoding: .utf8)!
    return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
}
