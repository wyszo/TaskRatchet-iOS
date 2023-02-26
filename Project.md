# Task Ratchet iOS Project

## Goal

Implement an Open Source client for Task Ratchet using modern iOS techniques (TCA, SwiftUI).

TaskRatchet (https://taskratchet.com/) is a system to assign financial (negative) consequence to missing deadlines you set to yourself. The idea is that a deadline without consequences is not binding (thus not motivating enough). In other words: this is a tool that allows you to add consequences to arbitrary deadlines, so you can take control of your projects (and by extension: your life). 

For making meeting deadlines a little bit more pleasant (and feel less like a grind), I recommend attaching a negative consequence to not fulfilling a task (that's sorted by using TaskRatchet) but also a postive one (reward) if the deadline is met. Something you wouldn't do otherwise that's pleasant for you (like: treat yourself with something nice - my example would be a cheap PlayStation1 second hand video game, I wouldn't buy otherwise).  

## Roadmap & tasks breakdown

- Researching background 
	#done Research existing Alternatives
		#done Check online if there are any alternative iOS apps being developped
				- Result: nope, no direct alternatives using TaskRatchet. There might be some for different tools (like StikK for example), but not TaskRatchet.
		#done Checked: Google, GitHub, Search GitHub: TaskRatchet, YouTube, Search Beeminder forums: TaskRatchet, Search Twitter: TaskRatchet
	#done Playing with their Python API tool to see how it works and understand it beter (create a new task and update it, execute all the other erequests)
	#task Research Task Ratchet API
		#done Write down Task Ratchet API spec (that's currently up) and brief documentation
		#done Create a Postman (or alternative tool) Collection docummenting & testing that API

- Prepping for coding
	- Put a UX mock together (using draw.io)
	- Put an API mock together (static json files; started)
	- Put the repo on GitHub
	- Wiring TCA library
	- Creating a sample SwiftUI project with a preview

- Coding: putting it all together
	- setup/intro/login screen: userID + API token
	- fetching and displaying a list of tasks
	- tapping on one navigates to task details
	- completing a task
	- filtering main tasks list: pending/complete/expired / not completed / due today 
	- editing a task
	- profile info
	- local notifications: reminders + notifications settings (on/off, minutes before)
	- (optional) Main page info screen (with app version + server info + server status)

## Functional requirements

### Login screen

#### MVP
- Title (Task Ratchet) & Subtitle (Unofficial mobile client)
- Info text underneath (no clickable elements). For copy see 'Login-MVP.png' file
- UserID & API Token fields
- Login button  
- Login button inactive until both UserID & API Token fileds contain > 1 character

#### Full version
- Info button (gear icon) showing an alert with app version, server info (URL) and server status (online/offline). GitHub page link underneath.
- 'Launch TaskRatchet website' button that opens TaskRatchet website in Safari.

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
	 #task Try out Workflowy
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

## Changelog 
- 2023.02.26: Extended wireframe mockup. Made login screen wireframes (full & MVP version).
- 2023.02.24: Added Api spec and Static mock json files. Tested the API responses. Created a hoppscotch API testing collection. Added simple UX wireframes.
- 2023.02.23: Writing down the Project.md structure with a basic tasks breakdown. Researching about the current state of the project and current landscape around it.
