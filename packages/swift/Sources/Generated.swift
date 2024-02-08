/**
 * This file is auto-generated by widget-post-message-definitions,
 * DO NOT EDIT.
 *
 * If you need to make changes to the code in this file, you can do so by
 * modifying the definitions found in the widget-post-message-definitions
 * project.
 */

import Foundation

public protocol Event: Codable {}

public enum EventError: Error, Equatable {
    case invalidEventURL(url: URL)
}

/** Payloads **/

public enum WidgetEvent {
    public struct Load: Event {

        public static func == (lhs: WidgetEvent.Load, rhs: WidgetEvent.Load) -> Bool {
            return true
        }
    }
    public struct Ping: Event {
        public var userGuid: String
        public var sessionGuid: String

        public static func == (lhs: WidgetEvent.Ping, rhs: WidgetEvent.Ping) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
        }
    }
    public struct Navigation: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var didGoBack: Bool

        public static func == (lhs: WidgetEvent.Navigation, rhs: WidgetEvent.Navigation) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.didGoBack == rhs.didGoBack
        }
    }
    public struct FocusTrap: Event {
        public var userGuid: String
        public var sessionGuid: String

        public static func == (lhs: WidgetEvent.FocusTrap, rhs: WidgetEvent.FocusTrap) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
        }
    }
}

public enum ClientEvent {
    public struct OAuthComplete: Event {
        public var url: String

        public static func == (lhs: ClientEvent.OAuthComplete, rhs: ClientEvent.OAuthComplete) -> Bool {
            return lhs.url == rhs.url
        }
    }
}

public enum ConnectWidgetEvent {
    public struct Loaded: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var initialStep: String

        public static func == (lhs: ConnectWidgetEvent.Loaded, rhs: ConnectWidgetEvent.Loaded) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.initialStep == rhs.initialStep
        }
    }
    public struct EnterCredentials: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var institution: ConnectEnterCredentialsInstitution

        public static func == (lhs: ConnectWidgetEvent.EnterCredentials, rhs: ConnectWidgetEvent.EnterCredentials) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.institution == rhs.institution
        }
    }
    public struct InstitutionSearch: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var query: String

        public static func == (lhs: ConnectWidgetEvent.InstitutionSearch, rhs: ConnectWidgetEvent.InstitutionSearch) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.query == rhs.query
        }
    }
    public struct SelectedInstitution: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var code: String
        public var guid: String
        public var name: String
        public var url: String

        public static func == (lhs: ConnectWidgetEvent.SelectedInstitution, rhs: ConnectWidgetEvent.SelectedInstitution) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.code == rhs.code
                && lhs.guid == rhs.guid
                && lhs.name == rhs.name
                && lhs.url == rhs.url
        }
    }
    public struct MemberConnected: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var memberGuid: String

        public static func == (lhs: ConnectWidgetEvent.MemberConnected, rhs: ConnectWidgetEvent.MemberConnected) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.memberGuid == rhs.memberGuid
        }
    }
    public struct ConnectedPrimaryAction: Event {
        public var userGuid: String
        public var sessionGuid: String

        public static func == (lhs: ConnectWidgetEvent.ConnectedPrimaryAction, rhs: ConnectWidgetEvent.ConnectedPrimaryAction) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
        }
    }
    public struct MemberDeleted: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var memberGuid: String

        public static func == (lhs: ConnectWidgetEvent.MemberDeleted, rhs: ConnectWidgetEvent.MemberDeleted) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.memberGuid == rhs.memberGuid
        }
    }
    public struct CreateMemberError: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var institutionGuid: String
        public var institutionCode: String

        public static func == (lhs: ConnectWidgetEvent.CreateMemberError, rhs: ConnectWidgetEvent.CreateMemberError) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.institutionGuid == rhs.institutionGuid
                && lhs.institutionCode == rhs.institutionCode
        }
    }
    public struct MemberStatusUpdate: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var memberGuid: String
        public var connectionStatus: Double

        public static func == (lhs: ConnectWidgetEvent.MemberStatusUpdate, rhs: ConnectWidgetEvent.MemberStatusUpdate) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.memberGuid == rhs.memberGuid
                && lhs.connectionStatus == rhs.connectionStatus
        }
    }
    public struct OAuthError: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var memberGuid: String?

        public static func == (lhs: ConnectWidgetEvent.OAuthError, rhs: ConnectWidgetEvent.OAuthError) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.memberGuid == rhs.memberGuid
        }
    }
    public struct OAuthRequested: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var url: String
        public var memberGuid: String

        public static func == (lhs: ConnectWidgetEvent.OAuthRequested, rhs: ConnectWidgetEvent.OAuthRequested) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.url == rhs.url
                && lhs.memberGuid == rhs.memberGuid
        }
    }
    public struct StepChange: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var previous: String
        public var current: String

        public static func == (lhs: ConnectWidgetEvent.StepChange, rhs: ConnectWidgetEvent.StepChange) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.previous == rhs.previous
                && lhs.current == rhs.current
        }
    }
    public struct SubmitMFA: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var memberGuid: String

        public static func == (lhs: ConnectWidgetEvent.SubmitMFA, rhs: ConnectWidgetEvent.SubmitMFA) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.memberGuid == rhs.memberGuid
        }
    }
    public struct UpdateCredentials: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var memberGuid: String
        public var institution: ConnectUpdateCredentialsInstitution

        public static func == (lhs: ConnectWidgetEvent.UpdateCredentials, rhs: ConnectWidgetEvent.UpdateCredentials) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.memberGuid == rhs.memberGuid
                && lhs.institution == rhs.institution
        }
    }
    public struct BackToSearch: Event {
        public var userGuid: String
        public var sessionGuid: String
        public var context: String?

        public static func == (lhs: ConnectWidgetEvent.BackToSearch, rhs: ConnectWidgetEvent.BackToSearch) -> Bool {
            return lhs.userGuid == rhs.userGuid
                && lhs.sessionGuid == rhs.sessionGuid
                && lhs.context == rhs.context
        }
    }
}

public enum PulseWidgetEvent {
    public struct OverdraftWarningCtaTransferFunds: Event {
        public var accountGuid: String
        public var amount: Double

        public static func == (lhs: PulseWidgetEvent.OverdraftWarningCtaTransferFunds, rhs: PulseWidgetEvent.OverdraftWarningCtaTransferFunds) -> Bool {
            return lhs.accountGuid == rhs.accountGuid
                && lhs.amount == rhs.amount
        }
    }
}

public enum AccountEvent {
    public struct Created: Event {
        public var guid: String

        public static func == (lhs: AccountEvent.Created, rhs: AccountEvent.Created) -> Bool {
            return lhs.guid == rhs.guid
        }
    }
}


public struct ConnectEnterCredentialsInstitution: Codable {
    public let code: String
    public let guid: String

    public static func == (lhs: ConnectEnterCredentialsInstitution, rhs: ConnectEnterCredentialsInstitution) -> Bool {
        return lhs.code == rhs.code
            && lhs.guid == rhs.guid
    }
}

public struct ConnectUpdateCredentialsInstitution: Codable {
    public let code: String
    public let guid: String

    public static func == (lhs: ConnectUpdateCredentialsInstitution, rhs: ConnectUpdateCredentialsInstitution) -> Bool {
        return lhs.code == rhs.code
            && lhs.guid == rhs.guid
    }
}

/** Delegates **/

public protocol WidgetEventDelegate {
    func widgetEvent(_ url: URL)
    func widgetEvent(_ error: EventError)
    func widgetEvent(_ payload: WidgetEvent.Load)
    func widgetEvent(_ payload: WidgetEvent.Ping)
    func widgetEvent(_ payload: WidgetEvent.Navigation)
    func widgetEvent(_ payload: WidgetEvent.FocusTrap)
}

public extension WidgetEventDelegate {
    func widgetEvent(_: URL) {}
    func widgetEvent(_: EventError) {}
    func widgetEvent(_: WidgetEvent.Load) {}
    func widgetEvent(_: WidgetEvent.Ping) {}
    func widgetEvent(_: WidgetEvent.Navigation) {}
    func widgetEvent(_: WidgetEvent.FocusTrap) {}
}

public protocol ConnectWidgetEventDelegate: WidgetEventDelegate {
    func widgetEvent(_ payload: ConnectWidgetEvent.Loaded)
    func widgetEvent(_ payload: ConnectWidgetEvent.EnterCredentials)
    func widgetEvent(_ payload: ConnectWidgetEvent.InstitutionSearch)
    func widgetEvent(_ payload: ConnectWidgetEvent.SelectedInstitution)
    func widgetEvent(_ payload: ConnectWidgetEvent.MemberConnected)
    func widgetEvent(_ payload: ConnectWidgetEvent.ConnectedPrimaryAction)
    func widgetEvent(_ payload: ConnectWidgetEvent.MemberDeleted)
    func widgetEvent(_ payload: ConnectWidgetEvent.CreateMemberError)
    func widgetEvent(_ payload: ConnectWidgetEvent.MemberStatusUpdate)
    func widgetEvent(_ payload: ConnectWidgetEvent.OAuthError)
    func widgetEvent(_ payload: ConnectWidgetEvent.OAuthRequested)
    func widgetEvent(_ payload: ConnectWidgetEvent.StepChange)
    func widgetEvent(_ payload: ConnectWidgetEvent.SubmitMFA)
    func widgetEvent(_ payload: ConnectWidgetEvent.UpdateCredentials)
    func widgetEvent(_ payload: ConnectWidgetEvent.BackToSearch)
}

public extension ConnectWidgetEventDelegate {
    func widgetEvent(_: ConnectWidgetEvent.Loaded) {}
    func widgetEvent(_: ConnectWidgetEvent.EnterCredentials) {}
    func widgetEvent(_: ConnectWidgetEvent.InstitutionSearch) {}
    func widgetEvent(_: ConnectWidgetEvent.SelectedInstitution) {}
    func widgetEvent(_: ConnectWidgetEvent.MemberConnected) {}
    func widgetEvent(_: ConnectWidgetEvent.ConnectedPrimaryAction) {}
    func widgetEvent(_: ConnectWidgetEvent.MemberDeleted) {}
    func widgetEvent(_: ConnectWidgetEvent.CreateMemberError) {}
    func widgetEvent(_: ConnectWidgetEvent.MemberStatusUpdate) {}
    func widgetEvent(_: ConnectWidgetEvent.OAuthError) {}
    func widgetEvent(_: ConnectWidgetEvent.OAuthRequested) {}
    func widgetEvent(_: ConnectWidgetEvent.StepChange) {}
    func widgetEvent(_: ConnectWidgetEvent.SubmitMFA) {}
    func widgetEvent(_: ConnectWidgetEvent.UpdateCredentials) {}
    func widgetEvent(_: ConnectWidgetEvent.BackToSearch) {}
}

public protocol PulseWidgetEventDelegate: WidgetEventDelegate {
    func widgetEvent(_ payload: PulseWidgetEvent.OverdraftWarningCtaTransferFunds)
}

public extension PulseWidgetEventDelegate {
    func widgetEvent(_: PulseWidgetEvent.OverdraftWarningCtaTransferFunds) {}
}

/** Dispatchers **/

protocol Dispatcher {
    func dispatch(_: URL) -> Event?
}

extension Dispatcher {
    func extractMetadata(_ url: URL) -> Data? {
        return URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?.first(where: { item in item.name == "metadata" })?
            .value?.data(using: .utf8)
    }

    func decode<T: Decodable>(_ typ: T.Type, _ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(typ, from: data)
    }
}

class WidgetEventDispatcher: Dispatcher {
    let delegate: WidgetEventDelegate

    init(_ delegate: WidgetEventDelegate) {
        self.delegate = delegate
    }

    func dispatch(_ url: URL) -> Event? {
        delegate.widgetEvent(url)

        guard let event = parse(url) else {
            delegate.widgetEvent(.invalidEventURL(url: url))
            return nil
        }

        switch event {
        case let event as WidgetEvent.Load:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.Ping:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.Navigation:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.FocusTrap:
            delegate.widgetEvent(event)
        default:
            // Unreachable
            return nil
        }

        return event
    }

    func parse(_ url: URL) -> Event? {
        guard let metadata = extractMetadata(url) else {
            return .none
        }

        switch (url.host, url.path) {
        case ("load", ""):
            return try? decode(WidgetEvent.Load.self, metadata)
        case ("ping", ""):
            return try? decode(WidgetEvent.Ping.self, metadata)
        case ("navigation", ""):
            return try? decode(WidgetEvent.Navigation.self, metadata)
        case ("focusTrap", ""):
            return try? decode(WidgetEvent.FocusTrap.self, metadata)
        default:
            return .none
        }
    }
}

class ConnectWidgetEventDispatcher: Dispatcher {
    let delegate: ConnectWidgetEventDelegate

    init(_ delegate: ConnectWidgetEventDelegate) {
        self.delegate = delegate
    }

    func dispatch(_ url: URL) -> Event? {
        delegate.widgetEvent(url)

        guard let event = parse(url) else {
            delegate.widgetEvent(.invalidEventURL(url: url))
            return nil
        }

        switch event {
        case let event as WidgetEvent.Load:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.Ping:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.Navigation:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.FocusTrap:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.Loaded:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.EnterCredentials:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.InstitutionSearch:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.SelectedInstitution:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.MemberConnected:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.ConnectedPrimaryAction:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.MemberDeleted:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.CreateMemberError:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.MemberStatusUpdate:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.OAuthError:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.OAuthRequested:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.StepChange:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.SubmitMFA:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.UpdateCredentials:
            delegate.widgetEvent(event)
        case let event as ConnectWidgetEvent.BackToSearch:
            delegate.widgetEvent(event)
        default:
            // Unreachable
            return nil
        }

        return event
    }

    func parse(_ url: URL) -> Event? {
        guard let metadata = extractMetadata(url) else {
            return .none
        }

        switch (url.host, url.path) {
        case ("load", ""):
            return try? decode(WidgetEvent.Load.self, metadata)
        case ("ping", ""):
            return try? decode(WidgetEvent.Ping.self, metadata)
        case ("navigation", ""):
            return try? decode(WidgetEvent.Navigation.self, metadata)
        case ("focusTrap", ""):
            return try? decode(WidgetEvent.FocusTrap.self, metadata)
        case ("connect", "/loaded"):
            return try? decode(ConnectWidgetEvent.Loaded.self, metadata)
        case ("connect", "/enterCredentials"):
            return try? decode(ConnectWidgetEvent.EnterCredentials.self, metadata)
        case ("connect", "/institutionSearch"):
            return try? decode(ConnectWidgetEvent.InstitutionSearch.self, metadata)
        case ("connect", "/selectedInstitution"):
            return try? decode(ConnectWidgetEvent.SelectedInstitution.self, metadata)
        case ("connect", "/memberConnected"):
            return try? decode(ConnectWidgetEvent.MemberConnected.self, metadata)
        case ("connect", "/connected/primaryAction"):
            return try? decode(ConnectWidgetEvent.ConnectedPrimaryAction.self, metadata)
        case ("connect", "/memberDeleted"):
            return try? decode(ConnectWidgetEvent.MemberDeleted.self, metadata)
        case ("connect", "/createMemberError"):
            return try? decode(ConnectWidgetEvent.CreateMemberError.self, metadata)
        case ("connect", "/memberStatusUpdate"):
            return try? decode(ConnectWidgetEvent.MemberStatusUpdate.self, metadata)
        case ("connect", "/oauthError"):
            return try? decode(ConnectWidgetEvent.OAuthError.self, metadata)
        case ("connect", "/oauthRequested"):
            return try? decode(ConnectWidgetEvent.OAuthRequested.self, metadata)
        case ("connect", "/stepChange"):
            return try? decode(ConnectWidgetEvent.StepChange.self, metadata)
        case ("connect", "/submitMFA"):
            return try? decode(ConnectWidgetEvent.SubmitMFA.self, metadata)
        case ("connect", "/updateCredentials"):
            return try? decode(ConnectWidgetEvent.UpdateCredentials.self, metadata)
        case ("connect", "/backToSearch"):
            return try? decode(ConnectWidgetEvent.BackToSearch.self, metadata)
        default:
            return .none
        }
    }
}

class PulseWidgetEventDispatcher: Dispatcher {
    let delegate: PulseWidgetEventDelegate

    init(_ delegate: PulseWidgetEventDelegate) {
        self.delegate = delegate
    }

    func dispatch(_ url: URL) -> Event? {
        delegate.widgetEvent(url)

        guard let event = parse(url) else {
            delegate.widgetEvent(.invalidEventURL(url: url))
            return nil
        }

        switch event {
        case let event as WidgetEvent.Load:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.Ping:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.Navigation:
            delegate.widgetEvent(event)
        case let event as WidgetEvent.FocusTrap:
            delegate.widgetEvent(event)
        case let event as PulseWidgetEvent.OverdraftWarningCtaTransferFunds:
            delegate.widgetEvent(event)
        default:
            // Unreachable
            return nil
        }

        return event
    }

    func parse(_ url: URL) -> Event? {
        guard let metadata = extractMetadata(url) else {
            return .none
        }

        switch (url.host, url.path) {
        case ("load", ""):
            return try? decode(WidgetEvent.Load.self, metadata)
        case ("ping", ""):
            return try? decode(WidgetEvent.Ping.self, metadata)
        case ("navigation", ""):
            return try? decode(WidgetEvent.Navigation.self, metadata)
        case ("focusTrap", ""):
            return try? decode(WidgetEvent.FocusTrap.self, metadata)
        case ("pulse", "/overdraftWarning/cta/transferFunds"):
            return try? decode(PulseWidgetEvent.OverdraftWarningCtaTransferFunds.self, metadata)
        default:
            return .none
        }
    }
}
