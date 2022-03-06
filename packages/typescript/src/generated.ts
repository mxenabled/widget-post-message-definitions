/**
 * This file is auto-generated by widget-post-message-definitions,
 * DO NOT EDIT.
 *
 * If you need to make changes to the code in this file, you can do so by
 * modifying the definitions found in the widget-post-message-definitions
 * project.
 */

import { parse as parseUrl } from "url"

import {
  BaseCallbackProps,
  Metadata,
  PostMessageCallbackDispatchError,
  PostMessageFieldDecodeError,
  PostMessageUnknownTypeError,
  assertMessageProp,
  safeCall,
} from "./lib"

export enum Type {
  Load = "mx/load",
  Ping = "mx/ping",
  FocusTrap = "mx/focusTrap",
  ConnectLoaded = "mx/connect/loaded",
  ConnectEnterCredentials = "mx/connect/enterCredentials",
  ConnectInstitutionSearch = "mx/connect/institutionSearch",
  ConnectSelectedInstitution = "mx/connect/selectedInstitution",
  ConnectMemberConnected = "mx/connect/memberConnected",
  ConnectConnectedPrimaryAction = "mx/connect/connected/primaryAction",
  ConnectMemberDeleted = "mx/connect/memberDeleted",
  ConnectCreateMemberError = "mx/connect/createMemberError",
  ConnectMemberStatusUpdate = "mx/connect/memberStatusUpdate",
  ConnectOauthError = "mx/connect/oauthError",
  ConnectOauthRequested = "mx/connect/oauthRequested",
  ConnectStepChange = "mx/connect/stepChange",
  ConnectSubmitMFA = "mx/connect/submitMFA",
  ConnectUpdateCredentials = "mx/connect/updateCredentials",
  PulseOverdraftWarningCtaTransferFunds = "mx/pulse/overdraftWarning/cta/transferFunds",
  AccountCreated = "mx/account/created",
}

export const typeLookup: Record<string, Type> = {
  [Type.Load]: Type.Load,
  [Type.Ping]: Type.Ping,
  [Type.FocusTrap]: Type.FocusTrap,
  "mx/focustrap": Type.FocusTrap,
  [Type.ConnectLoaded]: Type.ConnectLoaded,
  [Type.ConnectEnterCredentials]: Type.ConnectEnterCredentials,
  "mx/connect/entercredentials": Type.ConnectEnterCredentials,
  [Type.ConnectInstitutionSearch]: Type.ConnectInstitutionSearch,
  "mx/connect/institutionsearch": Type.ConnectInstitutionSearch,
  [Type.ConnectSelectedInstitution]: Type.ConnectSelectedInstitution,
  "mx/connect/selectedinstitution": Type.ConnectSelectedInstitution,
  [Type.ConnectMemberConnected]: Type.ConnectMemberConnected,
  "mx/connect/memberconnected": Type.ConnectMemberConnected,
  [Type.ConnectConnectedPrimaryAction]: Type.ConnectConnectedPrimaryAction,
  "mx/connect/connected/primaryaction": Type.ConnectConnectedPrimaryAction,
  [Type.ConnectMemberDeleted]: Type.ConnectMemberDeleted,
  "mx/connect/memberdeleted": Type.ConnectMemberDeleted,
  [Type.ConnectCreateMemberError]: Type.ConnectCreateMemberError,
  "mx/connect/createmembererror": Type.ConnectCreateMemberError,
  [Type.ConnectMemberStatusUpdate]: Type.ConnectMemberStatusUpdate,
  "mx/connect/memberstatusupdate": Type.ConnectMemberStatusUpdate,
  [Type.ConnectOauthError]: Type.ConnectOauthError,
  "mx/connect/oautherror": Type.ConnectOauthError,
  [Type.ConnectOauthRequested]: Type.ConnectOauthRequested,
  "mx/connect/oauthrequested": Type.ConnectOauthRequested,
  [Type.ConnectStepChange]: Type.ConnectStepChange,
  "mx/connect/stepchange": Type.ConnectStepChange,
  [Type.ConnectSubmitMFA]: Type.ConnectSubmitMFA,
  "mx/connect/submitmfa": Type.ConnectSubmitMFA,
  [Type.ConnectUpdateCredentials]: Type.ConnectUpdateCredentials,
  "mx/connect/updatecredentials": Type.ConnectUpdateCredentials,
  [Type.PulseOverdraftWarningCtaTransferFunds]: Type.PulseOverdraftWarningCtaTransferFunds,
  "mx/pulse/overdraftwarning/cta/transferfunds": Type.PulseOverdraftWarningCtaTransferFunds,
  [Type.AccountCreated]: Type.AccountCreated,
}


export type LoadPayload = {
  type: Type.Load,
}

export type PingPayload = {
  type: Type.Ping,
  user_guid: string,
  session_guid: string,
}

export type FocusTrapPayload = {
  type: Type.FocusTrap,
  user_guid: string,
  session_guid: string,
}

export type ConnectLoadedPayload = {
  type: Type.ConnectLoaded,
  user_guid: string,
  session_guid: string,
  initial_step: "search" | "selectMember" | "enterCreds" | "mfa" | "connected" | "loginError" | "disclosure",
}

export type ConnectEnterCredentialsPayload = {
  type: Type.ConnectEnterCredentials,
  user_guid: string,
  session_guid: string,
  institution: { code: string, guid: string },
}

export type ConnectInstitutionSearchPayload = {
  type: Type.ConnectInstitutionSearch,
  user_guid: string,
  session_guid: string,
  query: string,
}

export type ConnectSelectedInstitutionPayload = {
  type: Type.ConnectSelectedInstitution,
  user_guid: string,
  session_guid: string,
  code: string,
  guid: string,
  name: string,
  url: string,
}

export type ConnectMemberConnectedPayload = {
  type: Type.ConnectMemberConnected,
  user_guid: string,
  session_guid: string,
  member_guid: string,
}

export type ConnectConnectedPrimaryActionPayload = {
  type: Type.ConnectConnectedPrimaryAction,
  user_guid: string,
  session_guid: string,
}

export type ConnectMemberDeletedPayload = {
  type: Type.ConnectMemberDeleted,
  user_guid: string,
  session_guid: string,
  member_guid: string,
}

export type ConnectCreateMemberErrorPayload = {
  type: Type.ConnectCreateMemberError,
  user_guid: string,
  session_guid: string,
  institution_guid: string,
  institution_code: string,
}

export type ConnectMemberStatusUpdatePayload = {
  type: Type.ConnectMemberStatusUpdate,
  user_guid: string,
  session_guid: string,
  member_guid: string,
  connection_status: number,
}

export type ConnectOauthErrorPayload = {
  type: Type.ConnectOauthError,
  user_guid: string,
  session_guid: string,
  member_guid: string,
}

export type ConnectOauthRequestedPayload = {
  type: Type.ConnectOauthRequested,
  user_guid: string,
  session_guid: string,
  url: string,
  member_guid: string,
}

export type ConnectStepChangePayload = {
  type: Type.ConnectStepChange,
  user_guid: string,
  session_guid: string,
  previous: string,
  current: string,
}

export type ConnectSubmitMFAPayload = {
  type: Type.ConnectSubmitMFA,
  user_guid: string,
  session_guid: string,
  member_guid: string,
}

export type ConnectUpdateCredentialsPayload = {
  type: Type.ConnectUpdateCredentials,
  user_guid: string,
  session_guid: string,
  member_guid: string,
  institution: { code: string, guid: string },
}

export type PulseOverdraftWarningCtaTransferFundsPayload = {
  type: Type.PulseOverdraftWarningCtaTransferFunds,
  account_guid: string,
  amount: number,
}

export type AccountCreatedPayload = {
  type: Type.AccountCreated,
  guid: string,
}


export type WidgetPayload =
  | LoadPayload
  | PingPayload
  | FocusTrapPayload
  | ConnectLoadedPayload
  | ConnectEnterCredentialsPayload
  | ConnectInstitutionSearchPayload
  | ConnectSelectedInstitutionPayload
  | ConnectMemberConnectedPayload
  | ConnectConnectedPrimaryActionPayload
  | ConnectMemberDeletedPayload
  | ConnectCreateMemberErrorPayload
  | ConnectMemberStatusUpdatePayload
  | ConnectOauthErrorPayload
  | ConnectOauthRequestedPayload
  | ConnectStepChangePayload
  | ConnectSubmitMFAPayload
  | ConnectUpdateCredentialsPayload
  | PulseOverdraftWarningCtaTransferFundsPayload

export type EntityPayload =
  | AccountCreatedPayload

export type Payload =
  | WidgetPayload
  | EntityPayload

/**
 * Given a post message type (eg, "mx/load", "mx/connect/memberConnected") and
 * the payload for that message, this function parses the payload object and
 * returns a validated and typed object.
 *
 * @param {Type} type
 * @param {Metadata, Object} metadata
 * @return {Payload}
 * @throws {PostMessageUnknownTypeError}
 * @throws {PostMessageFieldDecodeError}
 */
function buildPayload(type: Type, metadata: Metadata): Payload {
  switch (type) {
    case Type.Load:

      return {
        type,
      }

    case Type.Ping:
      assertMessageProp(metadata, "mx/ping", "user_guid", "string")
      assertMessageProp(metadata, "mx/ping", "session_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
      }

    case Type.FocusTrap:
      assertMessageProp(metadata, "mx/focusTrap", "user_guid", "string")
      assertMessageProp(metadata, "mx/focusTrap", "session_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
      }

    case Type.ConnectLoaded:
      assertMessageProp(metadata, "mx/connect/loaded", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/loaded", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/loaded", "initial_step", ["search", "selectMember", "enterCreds", "mfa", "connected", "loginError", "disclosure"])

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        initial_step: metadata.initial_step as "search" | "selectMember" | "enterCreds" | "mfa" | "connected" | "loginError" | "disclosure",
      }

    case Type.ConnectEnterCredentials:
      assertMessageProp(metadata, "mx/connect/enterCredentials", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/enterCredentials", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/enterCredentials", "institution", { code: "string", guid: "string" })

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        institution: metadata.institution as { code: string, guid: string },
      }

    case Type.ConnectInstitutionSearch:
      assertMessageProp(metadata, "mx/connect/institutionSearch", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/institutionSearch", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/institutionSearch", "query", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        query: metadata.query as string,
      }

    case Type.ConnectSelectedInstitution:
      assertMessageProp(metadata, "mx/connect/selectedInstitution", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/selectedInstitution", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/selectedInstitution", "code", "string")
      assertMessageProp(metadata, "mx/connect/selectedInstitution", "guid", "string")
      assertMessageProp(metadata, "mx/connect/selectedInstitution", "name", "string")
      assertMessageProp(metadata, "mx/connect/selectedInstitution", "url", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        code: metadata.code as string,
        guid: metadata.guid as string,
        name: metadata.name as string,
        url: metadata.url as string,
      }

    case Type.ConnectMemberConnected:
      assertMessageProp(metadata, "mx/connect/memberConnected", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberConnected", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberConnected", "member_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        member_guid: metadata.member_guid as string,
      }

    case Type.ConnectConnectedPrimaryAction:
      assertMessageProp(metadata, "mx/connect/connected/primaryAction", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/connected/primaryAction", "session_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
      }

    case Type.ConnectMemberDeleted:
      assertMessageProp(metadata, "mx/connect/memberDeleted", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberDeleted", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberDeleted", "member_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        member_guid: metadata.member_guid as string,
      }

    case Type.ConnectCreateMemberError:
      assertMessageProp(metadata, "mx/connect/createMemberError", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/createMemberError", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/createMemberError", "institution_guid", "string")
      assertMessageProp(metadata, "mx/connect/createMemberError", "institution_code", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        institution_guid: metadata.institution_guid as string,
        institution_code: metadata.institution_code as string,
      }

    case Type.ConnectMemberStatusUpdate:
      assertMessageProp(metadata, "mx/connect/memberStatusUpdate", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberStatusUpdate", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberStatusUpdate", "member_guid", "string")
      assertMessageProp(metadata, "mx/connect/memberStatusUpdate", "connection_status", "number")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        member_guid: metadata.member_guid as string,
        connection_status: metadata.connection_status as number,
      }

    case Type.ConnectOauthError:
      assertMessageProp(metadata, "mx/connect/oauthError", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/oauthError", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/oauthError", "member_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        member_guid: metadata.member_guid as string,
      }

    case Type.ConnectOauthRequested:
      assertMessageProp(metadata, "mx/connect/oauthRequested", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/oauthRequested", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/oauthRequested", "url", "string")
      assertMessageProp(metadata, "mx/connect/oauthRequested", "member_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        url: metadata.url as string,
        member_guid: metadata.member_guid as string,
      }

    case Type.ConnectStepChange:
      assertMessageProp(metadata, "mx/connect/stepChange", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/stepChange", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/stepChange", "previous", "string")
      assertMessageProp(metadata, "mx/connect/stepChange", "current", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        previous: metadata.previous as string,
        current: metadata.current as string,
      }

    case Type.ConnectSubmitMFA:
      assertMessageProp(metadata, "mx/connect/submitMFA", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/submitMFA", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/submitMFA", "member_guid", "string")

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        member_guid: metadata.member_guid as string,
      }

    case Type.ConnectUpdateCredentials:
      assertMessageProp(metadata, "mx/connect/updateCredentials", "user_guid", "string")
      assertMessageProp(metadata, "mx/connect/updateCredentials", "session_guid", "string")
      assertMessageProp(metadata, "mx/connect/updateCredentials", "member_guid", "string")
      assertMessageProp(metadata, "mx/connect/updateCredentials", "institution", { code: "string", guid: "string" })

      return {
        type,
        user_guid: metadata.user_guid as string,
        session_guid: metadata.session_guid as string,
        member_guid: metadata.member_guid as string,
        institution: metadata.institution as { code: string, guid: string },
      }

    case Type.PulseOverdraftWarningCtaTransferFunds:
      assertMessageProp(metadata, "mx/pulse/overdraftWarning/cta/transferFunds", "account_guid", "string")
      assertMessageProp(metadata, "mx/pulse/overdraftWarning/cta/transferFunds", "amount", "number")

      return {
        type,
        account_guid: metadata.account_guid as string,
        amount: metadata.amount as number,
      }

    case Type.AccountCreated:
      assertMessageProp(metadata, "mx/account/created", "guid", "string")

      return {
        type,
        guid: metadata.guid as string,
      }

    default:
      throw new PostMessageUnknownTypeError(type)
  }
}

export type WidgetCallbackProps =
  & BaseCallbackProps
  & EntityCallbackProps
  & GenericCallbackProps

export type EntityCallbackProps = {
  onAccountCreated?: (payload: AccountCreatedPayload) => void
}

export type GenericCallbackProps = {
  onLoad?: (payload: LoadPayload) => void
  onPing?: (payload: PingPayload) => void
  onFocusTrap?: (payload: FocusTrapPayload) => void
}


export type ConnectCallbackProps = WidgetCallbackProps & {
  onLoaded?: (payload: ConnectLoadedPayload) => void
  onEnterCredentials?: (payload: ConnectEnterCredentialsPayload) => void
  onInstitutionSearch?: (payload: ConnectInstitutionSearchPayload) => void
  onSelectedInstitution?: (payload: ConnectSelectedInstitutionPayload) => void
  onMemberConnected?: (payload: ConnectMemberConnectedPayload) => void
  onConnectedPrimaryAction?: (payload: ConnectConnectedPrimaryActionPayload) => void
  onMemberDeleted?: (payload: ConnectMemberDeletedPayload) => void
  onCreateMemberError?: (payload: ConnectCreateMemberErrorPayload) => void
  onMemberStatusUpdate?: (payload: ConnectMemberStatusUpdatePayload) => void
  onOauthError?: (payload: ConnectOauthErrorPayload) => void
  onOauthRequested?: (payload: ConnectOauthRequestedPayload) => void
  onStepChange?: (payload: ConnectStepChangePayload) => void
  onSubmitMFA?: (payload: ConnectSubmitMFAPayload) => void
  onUpdateCredentials?: (payload: ConnectUpdateCredentialsPayload) => void
}

export type PulseCallbackProps = WidgetCallbackProps & {
  onOverdraftWarningCtaTransferFunds?: (payload: PulseOverdraftWarningCtaTransferFundsPayload) => void
}

type Message = {
  type: Type
  payload: Payload
}

/**
 * @param {String} url
 * @return {Message}
 * @throws {PostMessageUnknownTypeError}
 * @throws {PostMessageFieldDecodeError}
 */
function buildMessage(urlString: string): Message {
  const url = parseUrl(urlString, true)

  const namespace = url.host || ""
  const action = (url.pathname || "").substring(1)
  const rawType = action ? `mx/${namespace}/${action}` : `mx/${namespace}`
  let type: Type
  if (rawType in typeLookup) {
    type = typeLookup[rawType]
  } else {
    throw new PostMessageUnknownTypeError(rawType)
  }

  const rawMetadataParam = url.query?.["metadata"] || "{}"
  const rawMetadataString = Array.isArray(rawMetadataParam) ?
    rawMetadataParam.join("") :
    rawMetadataParam
  const metadata = JSON.parse(rawMetadataString)
  const payload = buildPayload(type, metadata)

  return { type, payload }
}

/**
 * @param {WidgetCallbackProps} callbacks
 * @param {String} url
 * @param {unknown} error
 * @throws {Error}
 * @throws {unknown}
 */
function dispatchError(callbacks: WidgetCallbackProps, url: string, error: unknown) {
  if (error instanceof PostMessageFieldDecodeError) {
    safeCall([url, error], callbacks.onMessageUnknownError)
  } else if (error instanceof PostMessageCallbackDispatchError) {
    safeCall([url, error], callbacks.onMessageDispatchError)
  } else {
    throw error
  }
}

/**
 * Dispatch a post message from any widget. Does not handle widget
 * specific post messages. See other dispatch methods for widget
 * specific dispatching.
 *
 * @param {WidgetCallbackProps} callbacks
 * @param {String} url
 * @throws {Error}
 * @throws {unknown}
 */
export function dispatchWidgetPostMessage(callbacks: WidgetCallbackProps, url: string) {
  safeCall([url], callbacks.onMessage)

  let message: Message
  try {
    message = buildMessage(url)
    switch (message.payload.type) {
      case Type.Load:
        safeCall([message.payload], callbacks.onLoad)
        break

      case Type.Ping:
        safeCall([message.payload], callbacks.onPing)
        break

      case Type.FocusTrap:
        safeCall([message.payload], callbacks.onFocusTrap)
        break

      case Type.AccountCreated:
        safeCall([message.payload], callbacks.onAccountCreated)
        break

      default:
        throw new PostMessageUnknownTypeError(message.payload.type)
    }
  } catch (error) {
    dispatchError(callbacks, url, error)
  }
}


/**
 * Dispatch a post message from the Connect Widget.
 *
 * @param {ConnectCallbackProps} callbacks
 * @param {String} url
 * @throws {Error}
 * @throws {unknown}
 */
export function dispatchConnectPostMessage(callbacks: ConnectCallbackProps, url: string) {
  safeCall([url], callbacks.onMessage)

  let message: Message
  try {
    message = buildMessage(url)
    switch (message.payload.type) {
      case Type.Load:
        safeCall([message.payload], callbacks.onLoad)
        break

      case Type.Ping:
        safeCall([message.payload], callbacks.onPing)
        break

      case Type.FocusTrap:
        safeCall([message.payload], callbacks.onFocusTrap)
        break

      case Type.AccountCreated:
        safeCall([message.payload], callbacks.onAccountCreated)
        break

      case Type.ConnectLoaded:
        safeCall([message.payload], callbacks.onLoaded)
        break

      case Type.ConnectEnterCredentials:
        safeCall([message.payload], callbacks.onEnterCredentials)
        break

      case Type.ConnectInstitutionSearch:
        safeCall([message.payload], callbacks.onInstitutionSearch)
        break

      case Type.ConnectSelectedInstitution:
        safeCall([message.payload], callbacks.onSelectedInstitution)
        break

      case Type.ConnectMemberConnected:
        safeCall([message.payload], callbacks.onMemberConnected)
        break

      case Type.ConnectConnectedPrimaryAction:
        safeCall([message.payload], callbacks.onConnectedPrimaryAction)
        break

      case Type.ConnectMemberDeleted:
        safeCall([message.payload], callbacks.onMemberDeleted)
        break

      case Type.ConnectCreateMemberError:
        safeCall([message.payload], callbacks.onCreateMemberError)
        break

      case Type.ConnectMemberStatusUpdate:
        safeCall([message.payload], callbacks.onMemberStatusUpdate)
        break

      case Type.ConnectOauthError:
        safeCall([message.payload], callbacks.onOauthError)
        break

      case Type.ConnectOauthRequested:
        safeCall([message.payload], callbacks.onOauthRequested)
        break

      case Type.ConnectStepChange:
        safeCall([message.payload], callbacks.onStepChange)
        break

      case Type.ConnectSubmitMFA:
        safeCall([message.payload], callbacks.onSubmitMFA)
        break

      case Type.ConnectUpdateCredentials:
        safeCall([message.payload], callbacks.onUpdateCredentials)
        break

      default:
        throw new PostMessageUnknownTypeError(message.payload.type)
    }
  } catch (error) {
    dispatchError(callbacks, url, error)
  }
}

/**
 * Dispatch a post message from the Pulse Widget.
 *
 * @param {PulseCallbackProps} callbacks
 * @param {String} url
 * @throws {Error}
 * @throws {unknown}
 */
export function dispatchPulsePostMessage(callbacks: PulseCallbackProps, url: string) {
  safeCall([url], callbacks.onMessage)

  let message: Message
  try {
    message = buildMessage(url)
    switch (message.payload.type) {
      case Type.Load:
        safeCall([message.payload], callbacks.onLoad)
        break

      case Type.Ping:
        safeCall([message.payload], callbacks.onPing)
        break

      case Type.FocusTrap:
        safeCall([message.payload], callbacks.onFocusTrap)
        break

      case Type.AccountCreated:
        safeCall([message.payload], callbacks.onAccountCreated)
        break

      case Type.PulseOverdraftWarningCtaTransferFunds:
        safeCall([message.payload], callbacks.onOverdraftWarningCtaTransferFunds)
        break

      default:
        throw new PostMessageUnknownTypeError(message.payload.type)
    }
  } catch (error) {
    dispatchError(callbacks, url, error)
  }
}
