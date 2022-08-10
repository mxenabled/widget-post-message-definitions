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

        it("calls the generic widgetEvent handler") {
            let payload = WidgetEvent.Load()
            dispatcher.dispatch(url("load", payload))
            verify(delegate.widgetEvent(any(WidgetEvent.Load.self))).wasCalled()
        }

        it("calls the specific widgetEvent handler") {
            let payload = ConnectWidgetEvent.InstitutionSearch(userGuid: "USR-123",
                                                               sessionGuid: "SES-123",
                                                               query: "Epic")
            dispatcher.dispatch(url("connect/institutionSearch", payload))
            verify(delegate.widgetEvent(any(where: { $0 == payload }))).wasCalled()
        }

        it("is able to dispatch an event that includes an enum value") {
            let payload = ConnectWidgetEvent.Loaded(userGuid: "USR-123",
                                                    sessionGuid: "SES-123",
                                                    initialStep: .search)
            dispatcher.dispatch(url("connect/loaded", payload))
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

        context("PulseWidgetEventDelegate") {
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

func encode(_ string: String) -> String {
    return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
}

func encode<T: Encodable>(_ value: T) -> String {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    let data = try! encoder.encode(value)
    let string = String(data: data, encoding: .utf8)!
    return string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
}
