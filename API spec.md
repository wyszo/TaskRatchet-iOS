# API 
- API spec: https://taskratchet.com/help/api.html
	- Current version of the API (1) is stable and any breaking changes will be released as a new API version.
	- I included the following short summary here in case the main page goes down/changes. 

 ### Authentication Headers
 - `X-Taskratchet-Userid` (found in account settings)
 - `X-Taskratchet-Token` (found in account settings)
 - also worth sending: `Content-Type`:  `application/json`

### endpoints

- Base URL: `https://api.taskratchet.com/api1/`

#### GET me
- Fetches your profile data.
- `cards` in response lists your banking cards used for payments
- Example json response: 
```
{
    "id": "Zu0qDVncIgSuUbQfr261",
    "name": "Jon Doe",
    "email": "jon@doe.com",
    "timezone": "America/New_York",
    "cards": [],
    "integrations":
    {
        "beeminder":
        {
            "user": "jondoe",
            "goal_new_tasks": "tr_tasks"
        }
    }
}
```

#### PUT me 
- Updates your profile
- Input fields: `name`, `email`, `timezone` (has to be a valid timezone returned from `GET timezones`, `new_password`, `integrations` (object))
- json response is an updated user object

#### GET me/tasks
- Returns all tasks ever created for the user 
- No pagination, all resuts returned always
- `due` is timezone agnostic
- `due_timestamp` is taking the user timezone into account
- `status`: `complete`/`expired`/`pending`
- Example response:
```
[
    {
        "id": "tdDPzh1GpZHAGZURVBf6",
        "task": "Take out the trash",
        "due": "2/21/2022, 11:59 PM",
        "due_timestamp": 1645505940,
        "cents": 500,
        "complete": false,
        "status": "pending",
        "timezone": "America/Cancun"
    }
]
```

#### POST me/tasks 
- Allows to create a new task
- Fields: `task`, `due`, `cents`
- `due` example: `3/25/2020, 11:59 PM`
- Response is created task on success

#### GET me/tasks/{task_id}
- Returns a single task details (as an object, not in an array)
- Example response: 
```
{
    "id": "tdDPzh1GpZHAGZURVBf6",
    "task": "Take out the trash",
    "due": "2/21/2022, 11:59 PM",
    "due_timestamp": 1645505940,
    "cents": 500,
    "complete": false,
    "status": "pending",
    "timezone": "America/Cancun"
}
```

#### GET status
- Returns server status, currently just the API internal time
- Example response:
```
{ "utc_now": "2022-07-12T18:52:41.647995+00:00" }
```

#### GET timezones
- Returns an array of valid time zones
- Non authenticated endpoint
- For an example response see the mock json file