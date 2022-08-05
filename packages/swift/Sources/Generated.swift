/**
 * This file is auto-generated by widget-post-message-definitions,
 * DO NOT EDIT.
 *
 * If you need to make changes to the code in this file, you can do so by
 * modifying the definitions found in the widget-post-message-definitions
 * project.
 */

public protocol Event {}

public enum WidgetEvent {
    public struct Load: Event {
    }
    public struct Ping: Event {
        public let userGuid: String
        public let sessionGuid: String
    }
    public struct Navigation: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let didGoBack: Bool
    }
    public struct FocusTrap: Event {
        public let userGuid: String
        public let sessionGuid: String
    }
}

public enum ClientEvent {
    public struct OAuthComplete: Event {
        public let url: String
    }
}

public enum ConnectWidgetEvent {
    public struct Loaded: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let initialStep: ConnectLoadedInitialStep
    }
    public struct EnterCredentials: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let institution: ConnectEnterCredentialsInstitution
    }
    public struct InstitutionSearch: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let query: String
    }
    public struct SelectedInstitution: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let code: String
        public let guid: String
        public let name: String
        public let url: String
    }
    public struct MemberConnected: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let memberGuid: String
    }
    public struct ConnectedPrimaryAction: Event {
        public let userGuid: String
        public let sessionGuid: String
    }
    public struct MemberDeleted: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let memberGuid: String
    }
    public struct CreateMemberError: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let institutionGuid: String
        public let institutionCode: String
    }
    public struct MemberStatusUpdate: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let memberGuid: String
        public let connectionStatus: Double
    }
    public struct OAuthError: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let memberGuid: String?
    }
    public struct OAuthRequested: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let url: String
        public let memberGuid: String
    }
    public struct StepChange: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let previous: String
        public let current: String
    }
    public struct SubmitMFA: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let memberGuid: String
    }
    public struct UpdateCredentials: Event {
        public let userGuid: String
        public let sessionGuid: String
        public let memberGuid: String
        public let institution: ConnectUpdateCredentialsInstitution
    }
}

public enum PulseWidgetEvent {
    public struct OverdraftWarningCtaTransferFunds: Event {
        public let accountGuid: String
        public let amount: Double
    }
}

public enum AccountEvent {
    public struct Created: Event {
        public let guid: String
    }
}

public enum ConnectLoadedInitialStep {
    case search
    case selectMember
    case enterCreds
    case mfa
    case connected
    case loginError
    case disclosure
}

public struct ConnectEnterCredentialsInstitution {
    public let code: String
    public let guid: String
}

public struct ConnectUpdateCredentialsInstitution {
    public let code: String
    public let guid: String
}
