# data
Data modelling:

Below is a list of tables required to begin sketching out a data model

# 0.1.0 User Authentication

## users
Users will be authenticated by Google Firebase Authenticator which provides a hash Key

| Name | Data Type | Description |
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

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `user_id` | CHAR  |       |
| `activity` | CHAR or INT | References a range of possible activites (e.g. Login, Failed Login, Privacy Settings Change etc...) |
| `datetime` | DATETIME |       |


## meditations
A table of taggable quotes / meditations from historical and contemporary sources
* Consider creating mediations as a separate microservice (possibly open source) so it can be used for other apps

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | unique identifer |
| `text` | CHAR  | Quote |
| `meditation_attribution_id` | INT  | key to meditation_attributes table |
| `displays` | INT  | number of times a meditation has been rendered |
| `groovie` | INT  | number of Groovies recieved |

## meditation_attributions
A table of meditations resources

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | unique identifier |
| `name` | CHAR  | name of the person e.g.'Friedrich Nietzsche' |
| `image` | CHAR | ID of an image asset in cloud storage |

# 0.2.0 Know Thyself: Questionnaires

## questionnaires
List of available questionnaires.
* Note for future: We may want to limit questionnaire visibility to a Team/Group. 

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique Identifier |
| `type` | CHAR or INT | Declare questionnaire type/format, which will determine how it is read / displayed etc |
| `title` | CHAR | A name/title for the questionnaire |
| `description` | CHAR | A description |
| `instructions` | CHAR | Instructions on how to complete the questionnaire |
| `image` | CHAR | ID of an image asset in cloud storage |
| `user_id` | INT | The user who created/contributed the questionnaire | 
| `date_created` | DATETIME |      |

* NOTE: Perhaps title / descriptions /instructions should also be versionable and actually be held as meta data in the Questions JSON file in the questions table?

## questions
Version controlled questions

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `questionnaire_id` | INT  | Key to questionnaires table |
| `version` | INT  | Allows version control over questionnaires |
| `release_date` | DATETIME | Date this version was released |
| `questions` | JSON | Full Questionnaire in JSON Format |
| `status` | CHAR | Status of questionnaire ACTIVE / INACTIVE etc |
| `updated_by` | INT | User ID of who committed the questionnaire update | 

## answers
Answers submitted by a user

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | Key to users table |
| `questionnaire_id` | INT  | Key to questionnaires table |
| `questions_id` | INT  | Key to versioned questions in questions table |
| `answers` | JSON  | Answers in JSON format |
| `started_datetime` | DATETIME  | When questionnaire was started |
| `submitted_datetime` | DATETIME  | When answers were submitted |
| `status` | CHAR | Status - e.g. IN PROGRESS, COMPLETED |

# 0.3.0 Know Thyself: Vision

## universal_visions
Description

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## visions
Description

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

# 0.4.0 Know Thyself: Goals

## universal_goals
Description

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## goals
Description

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

# 0.5.0 The Groovy Release

## universal_grooves
Description

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

## grooves
Description

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `name` | type  | desc |
| `name` | type  | desc |

# 0.6.0 Feeds/Dashboard


# 0.7.0 Record Grooves


# 0.8.0 Record Moods


# 0.9.0 Record Journal Entries


# 0.10.0 User Interactions and the GROOVY button


# 0.11.0 Misogi


# 0.11.0 Groove Scheduler


# 0.12.0 Inspiration & Challenges


# 0.13.0 Mentors


# 0.14.0 Fully Social


# 1.0.0 Official LAUNCH
