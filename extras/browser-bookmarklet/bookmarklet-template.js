/*
Source: Beeminder forums (thread name: TaskRatchet bookmarklets).
https://forum.beeminder.com/t/taskratchet-bookmarklets/10276/8

I'm not the author, but thought it's a great thing to include to increase visibility 
(as it's quite difficult to find it and dig it out at the moment).
It lets you create new TaskRatchet task by opening a Chrome/Firefox/Opera bookmark.
An alert will pop up asking for extra details.

Howto:
- put your userID and token below
- copy-paste the code to the bookmark URL field in your browser
*/

javascript:(function() {
    task = prompt('task','PUT YOUR TASK NAME HERE');
    minutes_in_future = prompt('minutes',15);
    dollars = prompt('dollars',5);
    USERID = 'ADD_USERID_HERE';
    TOKEN = 'ADD_TOKEN_HERE';

    datetime = new Date(+new Date() + 60000 * minutes_in_future).toLocaleString('en-US').replace(/:[0-9][0-9] /g, ' ');
    fetch('https://api.taskratchet.com/api1/me/tasks', {
        method: 'POST',
        headers: {
            'X-Taskratchet-Userid': USERID,
            'X-Taskratchet-Token': TOKEN,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            'task': task,
            'due': datetime,
            'cents': dollars * 100
        })
    }).then((response) => {
        if (response.ok) {
            alert('task created:\n' + task + '\n' + datetime);
        } else {
            alert('ERROR. Task NOT created:\n' + task + '\n' + datetime);
        }
    })
})();