# data
Data modelling:

Below is a list of tables required to begin sketching out a data model

# users
Users will be authenticated by Google Firebase Authenticator which provides a hash Key

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| id | type | hash from google |
| authentication_method | type  | if available from google e.g. Facebook; Email etc |
| email | type  | Content Cell |
| username | type  | Content Cell |
| firstname | type  | Content Cell |
| lastname | type  | Content Cell |
| personal_summary | type  | user submitted description of who they are and why they're using grooveLog |



# userAudits
An audit trail of logins and other important activities

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| name | type  | desc |
| name | type  | desc |


# table template
Description

| Name | Data Type | Desription |
| ------------- | ------------- | ---------- |
| name | type  | desc |
| name | type  | desc |
