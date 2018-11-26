# data
Data modelling:

Below is a list of tables required to begin sketching out a data model

## users
Users will be authenticated by Google Firebase Authenticator which provides a hash Key

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `id` | CHAR | hash from google |
| `authentication_method` | CHAR or INT  | if available from google e.g. Facebook; Email etc |
| `email` | CHAR  |      |
| `username` | CHAR  |      |
| `firstname` | CHAR  |      |
| `lastname` | CHAR  |      |
| `personal_summary` | CHAR  | user submitted description of who they are and why they're using grooveLog |
| `signup_datetime` | DATE | UTC of Signup Time | 
| `locale` | CHAR | The user's main locale e.g. Europe/Amsterdam or use locale short codes | 
| `status` | CHAR or INT | 'ACTIVE', 'INACITVE', 'GROOVER' etc... |



## user_audits
An audit trail of logins and other important activities

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `user_id` | CHAR  |       |
| `activity` | CHAR or INT | References a range of possible activites (e.g. Login, Failed Login, Privacy Settings Change etc...) |
| `datetime` | DATETIME |       |


## meditations
A table of taggable quotes / meditations from historical and contemporary sources
* Consider creating mediations as a microservice (possibly open source) so it can be used for other apps

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `id` | INT  | unique identifer |
| `text` | CHAR  | Quote |
| `meditation_attribution_id` | INT  | key to meditation_attributes table |
| `name` | type  | desc |
| `name` | type  | desc |

## meditation_attributions
A table of meditations resources

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `id` | INT  | unique identifier |
| `name` | CHAR  | name of the person e.g.'Friedrich Nietzsche' |
| `image` | CHAR | ID of an image asset in cloud storage |

## universal_visions
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## visions
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## universal_goals
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## goals
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## universal_grooves
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## grooves
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |


