

### Connect Widget Post Messages

#### Loaded

- Post message event type: `mx/connect/loaded`
- Widget callback prop name: `onLoaded`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `initial_step` (`"search" | "selectMember" | "enterCreds" | "mfa" | "connected" | "loginError" | "disclosure"`)

#### Enter credentials

- Post message event type: `mx/connect/enterCredentials`
- Widget callback prop name: `onEnterCredentials`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `institution` (`{ code: string, guid: string }`)

#### Institution search

- Post message event type: `mx/connect/institutionSearch`
- Widget callback prop name: `onInstitutionSearch`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `query` (`string`)

#### Selected institution

- Post message event type: `mx/connect/selectedInstitution`
- Widget callback prop name: `onSelectedInstitution`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `code` (`string`)
    - `guid` (`string`)
    - `name` (`string`)
    - `url` (`string`)

#### Member connected

- Post message event type: `mx/connect/memberConnected`
- Widget callback prop name: `onMemberConnected`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

#### Connected primary action

- Post message event type: `mx/connect/connected/primaryAction`
- Widget callback prop name: `onConnectedPrimaryAction`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)

#### Member deleted

- Post message event type: `mx/connect/memberDeleted`
- Widget callback prop name: `onMemberDeleted`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

#### Create member error

- Post message event type: `mx/connect/createMemberError`
- Widget callback prop name: `onCreateMemberError`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `institution_guid` (`string`)
    - `institution_code` (`string`)

#### Member status update

- Post message event type: `mx/connect/memberStatusUpdate`
- Widget callback prop name: `onMemberStatusUpdate`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `connection_status` (`number`)

#### OAuth error

- Post message event type: `mx/connect/oauthError`
- Widget callback prop name: `onOAuthError`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

#### OAuth requested

- Post message event type: `mx/connect/oauthRequested`
- Widget callback prop name: `onOAuthRequested`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `url` (`string`)
    - `member_guid` (`string`)

#### Step change

- Post message event type: `mx/connect/stepChange`
- Widget callback prop name: `onStepChange`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `previous` (`string`)
    - `current` (`string`)

#### Submit MFA

- Post message event type: `mx/connect/submitMFA`
- Widget callback prop name: `onSubmitMFA`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

#### Update credentials

- Post message event type: `mx/connect/updateCredentials`
- Widget callback prop name: `onUpdateCredentials`
- Payload:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `institution` (`{ code: string, guid: string }`)

### Pulse Widget Post Messages

#### Overdraft warning cta transfer funds

- Post message event type: `mx/pulse/overdraftWarning/cta/transferFunds`
- Widget callback prop name: `onOverdraftWarningCtaTransferFunds`
- Payload:
    - `account_guid` (`string`)
    - `amount` (`number`)

