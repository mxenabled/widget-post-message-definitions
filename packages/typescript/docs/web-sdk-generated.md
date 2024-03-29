<!--
This file is auto-generated by widget-post-message-definitions,
DO NOT EDIT.

If you need to make changes to the code in this file, you can do so by
modifying the definitions found in the widget-post-message-definitions[1]
project.

[1] https://github.com/mxenabled/widget-post-message-definitions
-->

## Connect Widget Post Messages

---
### Loaded (`mx/connect/loaded`)

- Widget callback prop name: `onLoaded`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `initial_step` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onLoaded</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onLoaded: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Initial step: ${payload.initial_step}`)
  }
})
```

</details>

---
### Enter credentials (`mx/connect/enterCredentials`)

- Widget callback prop name: `onEnterCredentials`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `institution` (`object`)
        - `code` (`string`)
        - `guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onEnterCredentials</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onEnterCredentials: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Institution: ${payload.institution}`)
  }
})
```

</details>

---
### Institution search (`mx/connect/institutionSearch`)

- Widget callback prop name: `onInstitutionSearch`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `query` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onInstitutionSearch</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onInstitutionSearch: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Query: ${payload.query}`)
  }
})
```

</details>

---
### Selected institution (`mx/connect/selectedInstitution`)

- Widget callback prop name: `onSelectedInstitution`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `code` (`string`)
    - `guid` (`string`)
    - `name` (`string`)
    - `url` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onSelectedInstitution</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onSelectedInstitution: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Code: ${payload.code}`)
    console.log(`Guid: ${payload.guid}`)
    console.log(`Name: ${payload.name}`)
    console.log(`Url: ${payload.url}`)
  }
})
```

</details>

---
### Member connected (`mx/connect/memberConnected`)

- Widget callback prop name: `onMemberConnected`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onMemberConnected</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onMemberConnected: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
  }
})
```

</details>

---
### Connected primary action (`mx/connect/connected/primaryAction`)

- Widget callback prop name: `onConnectedPrimaryAction`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onConnectedPrimaryAction</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onConnectedPrimaryAction: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
  }
})
```

</details>

---
### Member deleted (`mx/connect/memberDeleted`)

- Widget callback prop name: `onMemberDeleted`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onMemberDeleted</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onMemberDeleted: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
  }
})
```

</details>

---
### Create member error (`mx/connect/createMemberError`)

- Widget callback prop name: `onCreateMemberError`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `institution_guid` (`string`)
    - `institution_code` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onCreateMemberError</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onCreateMemberError: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Institution guid: ${payload.institution_guid}`)
    console.log(`Institution code: ${payload.institution_code}`)
  }
})
```

</details>

---
### Member status update (`mx/connect/memberStatusUpdate`)

- Widget callback prop name: `onMemberStatusUpdate`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `connection_status` (`number`)

<details>
<summary>Click here to view a sample usage of <code>onMemberStatusUpdate</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onMemberStatusUpdate: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
    console.log(`Connection status: ${payload.connection_status}`)
  }
})
```

</details>

---
### OAuth error (`mx/connect/oauthError`)

- Widget callback prop name: `onOAuthError`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (optional) (`string`)

<details>
<summary>Click here to view a sample usage of <code>onOAuthError</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onOAuthError: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
  }
})
```

</details>

---
### OAuth requested (`mx/connect/oauthRequested`)

**Warning**: By passing your own method to this prop, you are overriding the
default behavior of the SDK which is to load the OAuth URL in a new
browser tab.

If you override this functionality, you must use the device's browser
to authenticate the user with OAuth. You cannot use WebViews or
iframes. Not only does this approach result in better security, it
also can leverage saved passwords and password managers that the user
has installed. It is also worth noting that many OAuth providers
explicitly block loading their webapps in an iframe or WebView.

- Widget callback prop name: `onOAuthRequested`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `url` (`string`)
    - `member_guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onOAuthRequested</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onOAuthRequested: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Url: ${payload.url}`)
    console.log(`Member guid: ${payload.member_guid}`)
  }
})
```

</details>

---
### Step change (`mx/connect/stepChange`)

**Warning**: This message is intended for analytics tracking purposes and not
controlling or altering user experience. The contents of this
message's payload is subject to change.

- Widget callback prop name: `onStepChange`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `previous` (`string`)
    - `current` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onStepChange</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onStepChange: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Previous: ${payload.previous}`)
    console.log(`Current: ${payload.current}`)
  }
})
```

</details>

---
### Submit MFA (`mx/connect/submitMFA`)

- Widget callback prop name: `onSubmitMFA`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onSubmitMFA</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onSubmitMFA: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
  }
})
```

</details>

---
### Update credentials (`mx/connect/updateCredentials`)

- Widget callback prop name: `onUpdateCredentials`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `institution` (`object`)
        - `code` (`string`)
        - `guid` (`string`)

<details>
<summary>Click here to view a sample usage of <code>onUpdateCredentials</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onUpdateCredentials: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
    console.log(`Institution: ${payload.institution}`)
  }
})
```

</details>

---
### Back to search (`mx/connect/backToSearch`)

- Widget callback prop name: `onBackToSearch`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `context` (optional) (`string`)

<details>
<summary>Click here to view a sample usage of <code>onBackToSearch</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onBackToSearch: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Context: ${payload.context}`)
  }
})
```

</details>

---
### Invalid data (`mx/connect/invalidData`)

- Widget callback prop name: `onInvalidData`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `code` (`number`)

<details>
<summary>Click here to view a sample usage of <code>onInvalidData</code>.</summary>

```javascript
const widget = widgetSdk.ConnectWidget({
  url: "https://widgets.moneydesktop.com/md/connect/...",

  onInvalidData: (payload) => {
    console.log(`User guid: ${payload.user_guid}`)
    console.log(`Session guid: ${payload.session_guid}`)
    console.log(`Member guid: ${payload.member_guid}`)
    console.log(`Code: ${payload.code}`)
  }
})
```

</details>

