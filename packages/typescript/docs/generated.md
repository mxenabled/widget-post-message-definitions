

## Connect Widget Post Messages

### Loaded (`mx/connect/loaded`)

- Widget callback prop name: `onLoaded`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `initial_step` (`string`)
        - One of:
            - `"search"`
            - `"selectMember"`
            - `"enterCreds"`
            - `"mfa"`
            - `"connected"`
            - `"loginError"`
            - `"disclosure"`

### Enter credentials (`mx/connect/enterCredentials`)

- Widget callback prop name: `onEnterCredentials`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `institution` (`object`)
        - `code` (`string`)
        - `guid` (`string`)

### Institution search (`mx/connect/institutionSearch`)

- Widget callback prop name: `onInstitutionSearch`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `query` (`string`)

### Selected institution (`mx/connect/selectedInstitution`)

- Widget callback prop name: `onSelectedInstitution`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `code` (`string`)
    - `guid` (`string`)
    - `name` (`string`)
    - `url` (`string`)

### Member connected (`mx/connect/memberConnected`)

- Widget callback prop name: `onMemberConnected`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

### Connected primary action (`mx/connect/connected/primaryAction`)

- Widget callback prop name: `onConnectedPrimaryAction`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)

### Member deleted (`mx/connect/memberDeleted`)

- Widget callback prop name: `onMemberDeleted`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

### Create member error (`mx/connect/createMemberError`)

- Widget callback prop name: `onCreateMemberError`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `institution_guid` (`string`)
    - `institution_code` (`string`)

### Member status update (`mx/connect/memberStatusUpdate`)

- Widget callback prop name: `onMemberStatusUpdate`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `connection_status` (`number`)

### OAuth error (`mx/connect/oauthError`)

- Widget callback prop name: `onOAuthError`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

### OAuth requested (`mx/connect/oauthRequested`)

- Widget callback prop name: `onOAuthRequested`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `url` (`string`)
    - `member_guid` (`string`)

### Step change (`mx/connect/stepChange`)

- Widget callback prop name: `onStepChange`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `previous` (`string`)
    - `current` (`string`)

### Submit MFA (`mx/connect/submitMFA`)

- Widget callback prop name: `onSubmitMFA`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)

### Update credentials (`mx/connect/updateCredentials`)

- Widget callback prop name: `onUpdateCredentials`
- Payload fields:
    - `user_guid` (`string`)
    - `session_guid` (`string`)
    - `member_guid` (`string`)
    - `institution` (`object`)
        - `code` (`string`)
        - `guid` (`string`)


### Example

```jsx
import { ConnectWidget } from "@mxenabled/react-native-widget-sdk"

<ConnectWidget
  url="https://widgets.moneydesktop.com/md/connect/..."

  onLoaded={(payload) => console.log(payload)}
  onEnterCredentials={(payload) => console.log(payload)}
  onInstitutionSearch={(payload) => console.log(payload)}
  onSelectedInstitution={(payload) => console.log(payload)}
  onMemberConnected={(payload) => console.log(payload)}
  onConnectedPrimaryAction={(payload) => console.log(payload)}
  onMemberDeleted={(payload) => console.log(payload)}
  onCreateMemberError={(payload) => console.log(payload)}
  onMemberStatusUpdate={(payload) => console.log(payload)}
  onOAuthError={(payload) => console.log(payload)}
  onOAuthRequested={(payload) => console.log(payload)}
  onStepChange={(payload) => console.log(payload)}
  onSubmitMFA={(payload) => console.log(payload)}
  onUpdateCredentials={(payload) => console.log(payload)}
/>
```

