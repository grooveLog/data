# Question

There are the following types of posts which will contribute to a Feed - a scrollable list of recent user activity:

* Groove Completion/non-completion
* Recording Moods
* Task Completion
* Journalling Posts

* There is also the ability to post an update without a Groove/Mood/Task/Journalling (Although we need to decide if this is a worthwhile featue because we don't want this to turn into another noisy social media platform, it should be focused on...)

Feeds will also include user activity such as:
* New vision creation/adoption or update
* New goal creation/adoption or update
* New groove creation/adoption or update
* Taking a quesionnaire

Feeds may also include 'LIKE' activity
* Clicking the Groovy butonn on a feed item or a meditation for example

### How will the Feeds be consumed in the UI?
* Provide a scrollable list of user activity for a single user
* Provide a scrollable list of user activity for a group of users (e.g. everyone you are following/supporting)
* Provide a scrollable list of user activities (single or group) filtered by categorey (e.g. Grooves/Moods/Tasks/Journalling)

## Questions:
The proposal on https://github.com/grooveLog/data creates a number of different tables according to activity type with the idea that these can be joined in queries according to user requests.

* Is this the most efficient way to manage feeds or will we run into problems at scale?
* Would it be better to have one big 'Feeds' table instead
* Or keep the individual tables AND have a separate big Feeds table
* What should be done about archiving?

# Data Model of an integrated Feed:

## log
The ability to record the grooves/moods/tasks/journal items on a per day basis

| Name | Data Type | Description |
| ------------- | ------------- | ---------- |
| `id` | INT  | Unique identifier |
| `user_id` | INT  | The `user_id` who is logging the groove |
| `type` | CHAR | e.g. GROOVE, MOOD, TASK, JOURNAL |
| `groove_id` | INT  | key to `groove` table |
| `mood_id` | INT  | key to `mood` table |
| `task_id` | INT  | key to `task` table |
| `juornal_id` | INT  | key to `journal` table |
| `performed_at` | DATETIME  | date the item is performed (e.g. Grooves/Tasks only) |
| `groove_type` | CHAR or INT  | DONE or FAIL |
| `comment` | CHAR | Comment or excuse |
| `created_at` | DATETIME | Time it was logged | 
