# Task Ratchet iOS Project

## Goal

Implement an Open Source client for Task Ratchet using modern iOS techniques (TCA, SwiftUI).

TaskRatchet (https://taskratchet.com/) is a system to assign financial (negative) consequence to missing deadlines you set to yourself. The idea is that a deadline without consequences is not binding (thus not motivating enough). In other words: this is a tool that allows you to add consequences to arbitrary deadlines, so you can take control of your projects (and by extension: your life). 

For making meeting deadlines a little bit more pleasant (and feel less like a grind), I recommend attaching a negative consequence to not fulfilling a task (that's sorted by using TaskRatchet) but also a postive one (reward) if the deadline is met. Something you wouldn't do otherwise that's pleasant for you (like: treat yourself with something nice - my example would be a cheap PlayStation1 second hand video game, I wouldn't buy otherwise).  

## Note

Official project repos are now archived on GitHub. As of now the web app is still working, but it's possible I'll need to host it myself at some point if the main site goes down. 

## Roadmap & tasks breakdown

- Researching background (done)
	- #done Research existing Alternatives
		- #done Check online if there are any alternative iOS apps being developped
				- Result: nope, no direct alternatives using TaskRatchet. There might be some for different tools (like StikK for example), but not TaskRatchet.
		- #done Checked: Google, GitHub, Search GitHub: TaskRatchet, YouTube, Search Beeminder forums: TaskRatchet, Search Twitter: TaskRatchet
	- #done Playing with their Python API tool to see how it works and understand it beter (create a new task and update it, execute all the other erequests)
	- #done Research Task Ratchet API
		- #done Write down Task Ratchet API spec (that's currently up) and brief documentation
		- #done Create a Postman (or alternative tool) Collection documenting & testing that API

- Prepping for coding (done)
	- #done Put a UX mock together (using draw.io)
	- #done Put an API mock together (static json files; started)
	- #done Put the repo on GitHub
	- #done Wiring TCA library
	- #done Creating a sample SwiftUI project with a preview

- Coding: putting it all together
	- #done setup/intro/login screen: userID + API token
	- (in progress) fetching and displaying a list of tasks
	- (in progress) tapping on one navigates to task details
	- completing a task
	- filtering main tasks list: pending/complete/expired / not completed / due today 
	- editing a task
	- adding a new task
	- profile info
	- local notifications: reminders + notifications settings (on/off, minutes before)
	- safely persisting login information between app launches (keychain?)
	- (optional) analytics
	- (optional) Main page info screen (with app version + server info + server status)
	- (optional) logout
	- (optional) wire linter

## Functional requirements

### Login screen

#### MVP

- Title (Task Ratchet) & Subtitle (Unofficial mobile client)
- Info text underneath (no clickable elements). For copy see 'Login-MVP.png' file
- UserID & API Token fields
- Login button  
- (stretch) Login button inactive until both UserID & API Token fileds contain > 1 character

#### Full version

- Info button (gear icon) showing an alert with app version, server info (URL) and server status (online/offline). GitHub page link underneath.
- 'Launch TaskRatchet website' button that opens TaskRatchet website in Safari.

### Task list 

#### MVP 

- Task list including:
	- Checkmark (completes task when pressed)
	- Task name
	- Task charge amount
	- Task due date
	- Task due time (if task in the past, it should say Xh Xm ago)
- Fetch all tasks list:
	- First time the screen appears
	- When app comes back from background
	- When one of the task timers expires (+2 sec)
	- When a new task created (on mobile)
- Basic task list filtering:
	- Show due (all pending)
	- Show due today (pending with due date today)
	- Show all
	- (technical detail) action sheet
 - Create new task button

#### Full version

- (MVP?) Loading state indicator
	- When no data and request in flight
	- When there's data but refreshing 
	- Top-left corner icon that shows/hides
- (MVP?) Tapping on a task opens a screen to edit it
- Fetch all tasks list: 
	- On pull-to-refresh
	- When one of the tasks complted
 - Tasks grouped by due date and section titles by date
-  Help button
	- TBD: pressing probably redirects to web help?
- Filter the tasks like on web
	- TODO: rethink that
	- Pending on/off
	- Complete on/off
	- Expired on/off
	- Today's tasks only

#### Improvement ideas

- Implement reachability warning bar (when internet connection drops)

### Task Detail

#### MVP

- New task screen mode
	- Navbar with 'Cancel' and 'Save'
	- 'Save' button inactive until all fields filled in
	- Date and time picker component on pressing 'pick date/time'
	- Stakes field defaulting to $5

#### Full

- Edit task screen mode
	- Task name not editable
	- 'Discard changes' instead of 'Cancel' in the navbar
	- If no changes (or changes equivalent to currently saved task data), 'Save' button inactive
	 - Date & time validation (can't be in the past)
 - New task screen mode
	 - Due date prepopulated with now + 7 days
	 - Due time prepopulated with current time
	 - Stakes +1, -1 buttons
	 - Date & time validation (can't be in the past)
	 - 'Change timezone' button
- ? (timezone help) button
	- Linking to a website with explanation, just like on web

## Landscape

- A wiki-style webpage for TaskRatched linking useful resources
	- https://docs.taskratchet.com/
- Development updates
	- https://forum.beeminder.com/t/taskratchet-development-updates/5037
- A simple Python script to work with the API, play with it easier
	- https://github.com/TaskRatchet/taskratchet-python/blob/main/taskratchet.py
- A 3rd party unofficial CLI tool 
	- https://github.com/quantified-self-tools/taskratchet
- Souce code for the TraskRatchet website
	- https://github.com/TaskRatchet/taskratchet-web
- TaskRatchet repos GitHub
	- https://github.com/TaskRatchet
 - Commitment contracts tools 
	 - https://docs.taskratchet.com/friends.html (list)
	 - Complice: an automated tool that lets you clarify what is it that you would like to work on, take steps towards it and celebrate wins. Basically it seems like the system that allows to do what I was thinking about about me guiding A.
		 - Complice costs $12 pcm (but it has a free trial).
		 - It's got a Chrome NewTab extension that shows you your next action right there.
		 - It makes you write out why each goal is important for you. 
		 - It colour-codes different goals (which I love).
		 - It makes you break down your goals into actionable items and assign deadlines to them. Also: specify conditions to complete. And to think about what could be omited from that action.
		- It encourages to set intentions to do some of those actions today.
		- There are also rooms where people can see your goals you're working on and work using pomodoros.
		- In a way that's similar to Beeminder (but more user-friendly).
		- It also makes you review your previous day against the intentions that have been set. Which is great!
		- It allows you to assign pomodoros to tasks to check/visualise how long they took.
		- I really like that the system shows you achieved project milestones and also makes you come up with the next milestone to reach (and reminds you about it).
	  #done Try Complice out
	   - StickK: Allows to create commitment contracts and put money on the line to ensure completion. 
		#task Try StickK
	   - Commits.to is a Beeminder spinoff that helps to maintain and track commitments. All the data is public for others to read and see, which makes it especially interesting.
		#task Try commits.to
	- Work Or Pay: another website that does commitment contracts with financial consequences. This one seems a bit weird with their message (a bit insensitive).
	 - Beeminder (obviously): for ongoing commitments that require some recurring time investment.
		#task Get back to using Beeminder (together with Complice)
- Todo tools
	- Amazin Marvin: recommended todo tool that's focused around productivity, workflows and making things happen.
 - Breaking down projects
	 - Workflowy: allows you to capture everything, so you can analyze and get a better picture of it.
     - Dynalist: more powerful Workflowy clone
     - Logseq: alternative to the above
- Distraction blocking apps
	- minus.app: works on a system-level. Also: displays current task to focus on (in a floating window).
	#task Try minus.app 
- Other
	- Arc (arc.net) from The Browser Company is actually recommended for people who try to focus (but IDK why just yet).
	 - It's heavily focused on keyboard shortcuts, doesn't require further UI.

## Simple UX wireframing tools

- Mockplus 
	- https://www.mockplus.com/free-wireframing-tool/
	- not just for mobile mockups, but for rapid wireframing/prototyping in general
	- free (has a paid version)
	- has great mobile compontents template
	- has a RP (rapid prototyping) or cloud (dev/designers collab) modes 
- Draw.io
	- web-based
	- not focused on mobile prototyping, but rather overall diagraming
	- easy to put together something rudimentary
	- free
- Balsamiq Wireframes
	- https://balsamiq.com/wireframes/
	- paid, 30 day trial (I think I have a paid version?)
	- flash :/
- wireframe.cc
	- made for quick wireframing without being bogged down with too much details
	- easy to use
	- free and paid version. Free makes your work public.
- Freeform
	- Built in in Mac OS 
	- Simple to use, but not focused on Mockups, might be more hassle than added value

## Wireframe tool used

Currently using Wireframe.cc for generic overview and Mockplus for screen details.

## Process and tooling ideas

- Tools/processes to help with programming
	- Using GitHub copilot
	- Pair-programming 
    
## Next tasks (todo)

See the 'roadmap and tasks breakdown' section for more high-level view

1. Break remaining work down into trackable tasks
2. Finish AddTask screen UI work: 
    2.1. Add labels around stakes (as per wireframes)
    2.2. Use a due date picker for date selection
    2.3. Add a due time picker selection
    2.4. Check what needs to be done for timzone support to work correctly

## Changelog 

- 2023.08.17: Project.md file updates.
- 2023.03.03: Error handling standardised and shared between network requests. Autologin. UI improvements.
- 2023.02.29: Very basic implementation of add task screen and network request.
- 2023.02.28: Main task list, add task, edit wireframes (MVP and full). Functional requirements breakdown extended. Started implementing 'Add Task' screen.
- 2023.02.27: Making GET me network request, login alerts handling and credentials persistence. Prepopulating login fields when previous login successful. Fetching list of all tasks and listing their titles.
- 2023.02.26: Extended wireframe mockup. Made login screen wireframes (full & MVP version). Exteded `.gitignore` file. Xcode project template added.
- 2023.02.24: Added Api spec and Static mock json files. Tested the API responses. Created a hoppscotch API testing collection. Added simple UX wireframes.
- 2023.02.23: Writing down the Project.md structure with a basic tasks breakdown. Researching about the current state of the project and current landscape around it.
