# data
Data modelling:

Below is a list of tables required to begin sketching out a data model

# users
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
| `signup_datetime` | DATE |     | 
| `locale` | CHAR | The user's main locale e.g. Europe/Amsterdam or use locale short codes | 



# user_audits
An audit trail of logins and other important activities

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `user_id` | CHAR  |       |
| `activity` | CHAR or INT | References a range of possible activites (e.g. Login, Failed Login, Privacy Settings Change etc...) |
| `datetime` | DATETIME |       |


# table_template
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |


