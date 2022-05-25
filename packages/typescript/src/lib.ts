export type BasePostMessageCallbackProps<T> = {
  onMessage?: (message: T) => void
  onInvalidMessageError?: (message: T, error: Error) => void
}

// This is an internal error. Thrown when we are decoding a post message's
// metadata and we encourntered a missing field or an invalid value. This
// likely means there has been a change to the definition of a post message
// that we do not know about.
export class PostMessageFieldDecodeError extends Error {
  public messageType: string
  public field: string
  public expectedType: TypeDef
  public gotValue: unknown

  constructor(messageType: string, field: string, expectedType: TypeDef, gotValue: unknown) {
    super(`Unable to decode '${field}' from '${messageType}'`)

    this.messageType = messageType
    this.field = field
    this.expectedType = expectedType
    this.gotValue = gotValue

    Object.setPrototypeOf(this, PostMessageFieldDecodeError.prototype)
  }
}

// This is an internal error. Thrown when we get a post message we don't konw
// about. This likely means there is a new post message that this package needs
// to define.
export class PostMessageUnknownTypeError extends Error {
  public postMessageType: string

  constructor(postMessageType: string) {
    super(`Unknown post message: ${postMessageType}`)

    this.postMessageType = postMessageType

    Object.setPrototypeOf(this, PostMessageUnknownTypeError.prototype)
  }
}

export type MessageEventData = {
  mx?: boolean
  metadata?: Metadata
  type?: string
}

type FieldProperties = {
  optional?: boolean
}

export type Value = string | number | boolean
export type NestedValue = Record<string, Value>
export type Metadata = Record<string, Value | NestedValue>
export type TypeDef = string | Array<string> | Record<string, string>

export function assertMessageProp(
  container: Metadata,
  postMessageType: string,
  field: string,
  expectedType: TypeDef,
  properties: FieldProperties = {},
) {
  const value = container[field]

  const valueIsDefined = typeof value !== "undefined"
  const valueIsString = typeof value === "string"
  const valueIsNumber = typeof value === "number"
  const valueIsObject = typeof value === "object" && !Array.isArray(value)
  const valueIsBoolean = typeof value === "boolean"

  const typeIsString = expectedType === "string"
  const typeIsNumber = expectedType === "number"
  const typeIsArray = expectedType instanceof Array
  const typeIsObject = typeof expectedType === "object" && !Array.isArray(expectedType)
  const typeIsBoolean = expectedType === "boolean"

  if (!valueIsDefined && properties.optional) {
    return
  } else if (!valueIsDefined) {
    throw new PostMessageFieldDecodeError(postMessageType, field, expectedType, value)
  } else if (typeIsString && !valueIsString) {
    throw new PostMessageFieldDecodeError(postMessageType, field, expectedType, value)
  } else if (typeIsNumber && !valueIsNumber) {
    throw new PostMessageFieldDecodeError(postMessageType, field, expectedType, value)
  } else if (typeIsArray && !(valueIsString && expectedType.includes(value))) {
    throw new PostMessageFieldDecodeError(postMessageType, field, expectedType, value)
  } else if (typeIsObject && !valueIsObject) {
    throw new PostMessageFieldDecodeError(postMessageType, field, expectedType, value)
  } else if (typeIsBoolean && !valueIsBoolean) {
    throw new PostMessageFieldDecodeError(postMessageType, field, expectedType, value)
  } else if (typeIsObject && valueIsObject) {
    Object.keys(expectedType).forEach((field) => {
      assertMessageProp(value, postMessageType, field, expectedType[field])
    })
  }
}
