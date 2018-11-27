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
| `birthday` | DATE | Use this to get the age of the user (non-mandatory) |
| `gender` | INT or CHAR | e.g. MALE, FEMALE - OTHER? (non-mandatory) |
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
| `meditation_attribution_id` | INT  | key to `meditation_attributes` table |
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
| `user_id` | INT | The `user` who created/contributed the questionnaire | 
| `date_created` | DATETIME |      |

* NOTE: Perhaps title / descriptions /instructions should also be versionable and actually be held as meta data in the Questions JSON file in the questions table?

## questions
Version controlled questions

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `questionnaire_id` | INT  | Key to `questionnaires` table |
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
| `questionnaire_id` | INT  | Key to `questionnaires` table |
| `questions_id` | INT  | Key to versioned `questions` in questions table |
| `answers` | JSON  | Answers in JSON format |
| `started_datetime` | DATETIME  | When questionnaire was started |
| `submitted_datetime` | DATETIME  | When answers were submitted |
| `status` | CHAR | Status - e.g. IN PROGRESS, COMPLETED |

## questionnaire_ratings
Provide the ability to rate a questionnaire to provide aggregated user review data

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | Key to users table |
| `questionnaire_id` | INT  | Key to `questionnaires` table |
| `questions_id` | INT  | Key to versioned `questions` in questions table |
| `rating` | INT  | e.g. rating on a scale of 1 to 5 (e.g. stars) |
| `comment` | CHAR | User comment |
| `datetime` | DATETIME  | When rating was submitted |

* NOTE: Possibly have a universal ratings table for all kinds of resources instead? 

# 0.3.0 Know Thyself: Vision

## universal_visions
A list of all user contributed visions which may be reusable by others
* Note: In the future, some visions may be restricted to Team/Group usage only

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | ID of `user` who submitted the vision |
| `name` | CHAR  | Name of Vision (e.g. 'Be my own boss' ) |
| `privacy` | CHAR or INT | PUBLIC or PRIVATE (or TEAM in Future) |
| `endorsed` | BOOL | Whether endorsd by GrooveLog |
| `status` | CHAR | ACTIVE / INACTIVE etc. |
| `date_added` | DATETIME  | When vision was added |
| `total_assignments` | INT | Counter for the number of times this vision has been used |
| `average_passion_rating` | FLOAT | Average of all passion ratings |

* NOTE: universal visions should also be taggable for future searches

## visions
The personal implementation of a universal vision

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | The ID of `user` who assigning the universal vision |
| `universal_vision_id` | INT | key to `universal_visions` |
| `personal_description` | CHAR | The personal implementation of the universal vision, how I will do it |
| `probability` | INT  | probability of achieving the vision e.g. 75% |
| `passion` | INT  | personal passion for the vision (stars) e.g. 05 10 15 20 25 30 35 40 45 50 |
| `vision_timescales_id` | INT | key to `vision_timescales` table |
| `status` | CHAR or INT | e.g. COMPLETED, ABANDONED, POSTPONED etc |
| `completed_date` | DATE | When completed |

* Note: Need to link this to a table of universal whys?

## vision_timescales
A list of possible timeframes for achieving the vision

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `text` | CHAR  | E.g. "When I reach old age" |
| `numeric` |  INT  |  numeric representation of the text, e.g. how far in the future is the vision |

# 0.4.0 Know Thyself: Goals

## universal_goals
A list of all user contributed goals which may be reusable by others
* Note: In the future, some goals may be restricted to Team/Group usage only

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | ID of `user` who submitted the vision |
| `name` | CHAR  | Name of Goal (e.g. 'Run a 5k race' ) |
| `privacy` | CHAR or INT | PUBLIC or PRIVATE (or TEAM in Future) |
| `endorsed` | BOOL | Whether endorsd by GrooveLog |
| `status` | CHAR | ACTIVE / INACTIVE etc. |
| `date_added` | DATETIME  | When vision was added |
| `total_assignments` | INT | Counter for the number of times this vision has been used |
| `average_passion_rating` | FLOAT | Average of all passion ratings |

* NOTE: universal goals should also be taggable for future searches

## goals
The personal implementation of a universal goal

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | The ID of `user` who assigning the universal vision |
| `universal_goal_id` | INT | key to `universal_goals` |
| `personal_description` | CHAR | The personal implementation of the universal goal, how I will do it |
| `progress` | INT  | goal progress, how close to achievement e.g. 50% |
| `reward` | INT  | personal reward for completing the for the goal (stars) e.g. 05 10 15 20 25 30 35 40 45 50 |
| `goal_date_from` | DATE | from date (optional, for between dates) |
| `goal_date_to` | DATE | to date, the final cut-off target date |
| `status` | CHAR or INT | e.g. COMPLETED, FAILED, POSTPONED etc |
| `completed_date` | DATE | When completed |

* Note: Need to link this to a table of universal whys?

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
