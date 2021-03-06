# data
Data modelling:

Below is a list of tables required to begin sketching out a data model

# 0.1.0 User Authentication

## users
Users will be authenticated by Google Firebase Authenticator which provides a hash Key

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT | Unique ID |
| `uid` | CHAR | hash from google |
| `authentication_method` | CHAR or INT  | if available from google e.g. Facebook; Email etc |
| `email` | CHAR  |      |
| `display_name` | CHAR  |      |
| `firstname` | CHAR  |      |
| `lastname` | CHAR  |      |
| `birthday` | DATE | Use this to get the age of the user (non-mandatory) |
| `gender` | INT or CHAR | e.g. MALE, FEMALE - OTHER? (non-mandatory) |
| `personal_summary` | TEXT  | user submitted description of who they are and why they're using grooveLog |
| `created_at` | DATE | UTC of Signup Time | 
| `updated_at` | DATE | Date of last update | 
| `locale` | CHAR | The user's main locale e.g. Europe/Amsterdam or use locale short codes | 
| `image` | CHAR | Profile Image URL |
| `status` | CHAR or INT | 'ACTIVE', 'INACITVE', 'GROOVER' etc... |

## user_terms
| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT | uniqueID |
| `type` | CHAR | type |
| `text` | TEXT | text |
| `created_at` | DATE | date | 

* Terms Accepted table needed to relate to a versioned list of terms, organised by term types...

## user_audits
An audit trail of logins and other important activities

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `user_id` | CHAR  |       |
| `activity` | CHAR or INT | References a range of possible activities (e.g. Login, Failed Login, Privacy Settings Change etc...) |
| `created_at` | DATETIME | When the activity happened |


## meditations
A table of taggable quotes / meditations from historical and contemporary sources
* Consider creating mediations as a separate microservice (possibly open source) so it can be used for other apps

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | unique identifer |
| `text` | TEXT  | Quote |
| `meditation_attribution_id` | INT  | key to `meditation_attributes` table |
| `shown_count` | INT  | number of times a meditation has been rendered |
| `groovies` | INT  | number of Groovies recieved |
| `created_at` | DATETIME | When the meditation was created |
| `updated_at` | DATETIME | When the questionnaire was last updated |

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
| `description` | TEXT | A description |
| `instructions` | TEXT | Instructions on how to complete the questionnaire |
| `image` | CHAR | ID of an image asset in cloud storage |
| `user_id` | INT | The `user` who created/contributed the questionnaire | 
| `created_at` | DATETIME | When the questionnaire was created |

* NOTE: Perhaps title / descriptions /instructions should also be versionable and actually be held as meta data in the Questions JSON file in the questions table?

## questions
Version controlled questions

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `questionnaire_id` | INT  | Key to `questionnaires` table |
| `version` | INT  | Allows version control over questionnaires |
| `created_at` | DATETIME | Date this version was released |
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
| `started_at` | DATETIME  | When questionnaire was started |
| `submitted_at` | DATETIME  | When answers were submitted |
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
| `comment` | TEXT | User comment |
| `created_at` | DATETIME  | When rating was submitted |

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
| `created_at` | DATETIME  | When vision was added |
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
| `created_at` | DATE | When added to my personal visions list |
| `completed_at` | DATE | When completed |

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
| `user_id` | INT | ID of `user` who submitted the goal |
| `name` | CHAR  | Name of Goal (e.g. 'Run a 5k race' ) |
| `privacy` | CHAR or INT | PUBLIC or PRIVATE (or TEAM in Future) |
| `endorsed` | BOOL | Whether endorsed by GrooveLog |
| `status` | CHAR | ACTIVE / INACTIVE etc. |
| `created_at` | DATETIME  | When goal was added |
| `total_assignments` | INT | Counter for the number of times this goal has been used |
| `average_reward_rating` | FLOAT | Average of all reward ratings |

* NOTE: universal goals should also be taggable for future searches

## goals
The personal implementation of a universal goal

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | The ID of `user` who assigning the universal goal |
| `universal_goal_id` | INT | key to `universal_goals` |
| `personal_description` | CHAR | The personal implementation of the universal goal, how I will do it |
| `progress` | INT  | goal progress, how close to achievement e.g. 50% |
| `reward` | INT  | personal reward for completing the for the goal (stars) e.g. 05 10 15 20 25 30 35 40 45 50 |
| `goal_date_from` | DATE | from date (optional, for between dates) |
| `goal_date_to` | DATE | to date, the final cut-off target date |
| `status` | CHAR or INT | e.g. COMPLETED, FAILED, POSTPONED etc |
| `created_at` | DATE | When added to my personal goals list |
| `completed_at` | DATE | When completed |

* Note: Need to link this to a table of universal whys?

## goals__visions
A pivot table to link multple visions to a single goal - one-to-many relationship

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `goal_id` | INT  | key to `goals` table |
| `vision_id` | INT  | key to `visions` table |

* Ugh, is this correct?  Crikey I've forgotten how to do this...


# 0.5.0 The Groovy Release

## universal_grooves
A list of all user contributed grooves which may be reusable by others
* Note: In the future, some grooves may be restricted to Team/Group usage only

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | ID of `user` who submitted the groove |
| `name` | CHAR  | Name of Groove (e.g. 'Running' or 'Practice Scales' or 'Fasting') |
| `privacy` | CHAR or INT | PUBLIC or PRIVATE (or TEAM in Future) |
| `endorsed` | BOOL | Whether endorsd by GrooveLog |
| `status` | CHAR | ACTIVE / INACTIVE etc. |
| `created_at` | DATETIME  | When groove was added |
| `total_assignments` | INT | Counter for the number of times this groove has been used |
| `average_commitment_rating` | INT | Average of all commitment ratings |

* NOTE: universal grooves should also be taggable for future searches

## grooves
The personal implementation of a universal groove

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT | The ID of `user` who assigning the universal groove |
| `universal_groove_id` | INT | key to `universal_grooves` |
| `personal_description` | CHAR | The personal implementation of the universal groove, how I will do it |
| `commitment` | INT  | personal commitment - e.g. 75% |
| `volume_amount` | INT | Optional, relates to `volume_measurement` e.g. 20 mins or 10 reps |
| `volume_measurement` | CHAR | Optional, relates to `volume_amounnt` - mins or reps |
| `frequency_prefix` | CHAR or INT | Optional prefix like 'at least', or 'up to' |
| `frequency_number` | INT | number of times performed (e.g. 'once' per week / 'twice' per week') |
| `frequency_period` | CHAR or INT| e.g. 'per week', 'per day', or 'per month' |
| `status` | CHAR or INT | e.g. ACTIVE / PAUSED etc |
| `created_at` | DATE | When added to my personal groove list |


## grooves__goals
A pivot table to link multple goals to a single groove - one-to-many relationship

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `groove_id` | INT  | key to `grooves` table |
| `goal_id` | INT  | key to `goals` table |

# 0.6.0 Feeds/Dashboard
* This won't include any new tables, but will require websockets to produce a dynamic feed of Feeds for the front-end to consume.
* Things included would be initial sign-up datetime, questionnaire completion, visions/goals/grooves added and this info would come from the various tables.
* So to get the historical feed there would be a query from multiple tables which would be pre-loaded to the front end, any new feeds would come in via websockets

# 0.7.0 Record Grooves

## grooves_log
The ability to record the grooves achieved on a per day basis

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who is logging the groove |
| `groove_id` | INT  | key to `groove_id` table |
| `performed_at` | DATETIME  | date the groove is performed |
| `type` | CHAR or INT  | DONE or FAIL |
| `comment` | CHAR | Comment or excuse |
| `created_at` | DATETIME | Time it was logged | 

# 0.8.0 Record Moods

## moods_quick_log
This is the quick moods logger with the happy or smiley face 'HappyOmeter'

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who is logging the mood |
| `mood_score` | INT  | 0 to 100 |
| `comment` | CHAR  | comment to accompany the mood rating |
| `created_at` | DATETIME | Datetime the mood was logged |

## moods_introspection_log
A log for the introspection survey results...
* Note: The survey will be held in the `questionnaires` table

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who is logging the mood |
| `answer_id` | INT  | ID from the `answers` table (note this table also relates to the question version and questionnaire id) |
| `comment` | CHAR  | comment to accompany the mood rating |
| `created_at` | DATETIME | Datetime the mood was logged |

# 0.9.0 Record Journal Entries

## journal_questions
A curated list of user submitted (and GrooveLog submiitted) journalling questions

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who has submitted the question |
| `question` | CHAR | The journalling question |
| `type` | CHAR or INT |e.g. Morning, Evening, General, PRIVATE (e.g. private to the user) |
| `endorsed` | BOOL | Whether endorsed by GrooveLog |
| `status` | CHAR | ACTIVE / INACTIVE etc. |
| `created_at` | DATETIME  | When journal question was added |
| `number_of_appearances` | INT | How many times this question has appeared |
| `number_of_answers` | INT | How many times this question has been answered |

## journal_log
Log Journalling thoughts

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who is logging the journal entry |
| `journal_question_id` | INT  | Key to `journal_questions` table |
| `entry` | CHAR  | The journal entry |
| `created_at` | DATETIME | Datetime the entry was originally logged |
| `updated_at` | DATETIME | Datetime the entry was last edited |

* Decision: should we journal entries be versioned and editable etc?

# 0.10.0 Add and Record Tasks

## tasks
Create Tasks and be able to log actions against them...

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique task identifier |
| `user_id` | INT  | The `user_id` who has created the task |
| `description` | CHAR  | The task text / description |
| `status` | CHAR or INT | 'PENDING', 'DONE' etc.| 
| `time_remaining` | INT | Estimated minutes required to complete - convert to HH MM in UI |
| `created_at` | DATETIME | Datetime the entry was originally logged |
| `updated_at` | DATETIME | Datetime the entry was last edited |

## task_log
Log Task

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who is logging the journal entry |
| `task_id` | INT  | Key to `tasks` table |
| `comment` | CHAR  | Comment |
| `created_at` | DATETIME | Datetime the task performance was originally logged |
| `updated_at` | DATETIME | Datetime the task performance was last edited |

## tasks__goals
A pivot table to link multple goals to a single task - one-to-many relationship

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `task_id` | INT  | key to `tasks` table |
| `goal_id` | INT  | key to `goals` table |


# 0.11.0 User Interactions and the GROOVY button

## supporter_relationships
Tracking the 'freind' relationships

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `support_from_user_id` | INT | The `user_id` of the supporter / mentor |
| `support_to_user_id` | INT | The `user_id` of the person being supported / mentored |
| `level` | INT  | e.g. Support level 1 = supporter; support level 2 = mentor; |
| `created_at` | DATETIME | Datetime the support relationship was registered |

* In this release, search is supported to find users etc. Do we need to consider something like Elastic Search?
* We will also provide a global feed of the people you are supporting. Is this doable efficiantly by querying multiple tables or so we need an aggregated feed table, or something else?

## direct_messages
DMs between users

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `sender_id` | INT  | Key to `users` table |
| `recipient_id` | INT  | Key to `users` table |
| `body` | TEXT  | Message |
| `created_at` | DATETIME | Datetime the message was sent |
| `seen_at` | DATETIME | Datetime the message was seen by recipient |
| `deleted_at` | DATETIME | Datetime the message was seen by recipient |
| `recipient_status` | CHAR or INT | PENDING, SEEN, DELETED |
| `sender_status` | CHAR or INT | e.g. Recalled / Deleted |


## groovy_buttons
| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `liker_id` | INT  | Key to `users` table |
| `groove_log_id` | INT  | Key to `grooves_log` table |
| `moods_log_id` | INT  | Key to `moods_log` table |
| `journal_log_id` | INT  | Key to `journal_log` table |
| `tasks_log_id` | INT  | Key to `tasks_log` table |
| `type` | INT OR CHAR | Type of Button - e.g. Groovy or Other types |
| `created_at` | DATETIME | Datetime the like button was pressed |


# 0.12.0 Misogi


# 0.13.0 Groove Scheduler


# 0.14.0 Inspiration & Challenges


# 0.15.0 Mentors


# 0.16.0 Fully Social


# 1.0.0 Official LAUNCH

# 2.0.0 TEAMS
With the launch of the TEAMS functionality we will need to facilitate the following:

* A user can create a TEAM/GROUP
* All Content is private to the TEAM (Perhaps cryptographically hashed for security)
* Admins can be appointed in the TEAM with special priveleges
* Admins may invite other people to the TEAM, or Team members may invite others which would require admin approval
* There will be TEAM visions/goals/grooves which apply to all, mixed with perosnal vision/goals/groves
* Some questionnaires will be TEAM questionnaires, and may be anonymous. E.g. Memmbers will have to complete the questionnaire in a given timeframe and results are aggregated. A use case may be an anonymous Team Dynamics quesionnaire.
* There will be TEAM only Feeds.  A user may log in and out of the TEAM and easily switch between Team Feeds and Personal Feeds.
