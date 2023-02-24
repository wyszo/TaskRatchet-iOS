
# Task Ratchet iOS Project

## Goal

Implement an Open Source client for Task Ratchet using modern iOS techniques (TCA, SwiftUI).

TaskRatchet is a system to assign financial (negative) consequence to missing deadlines you set to yourself. The idea is that a deadline without consequences is not binding (thus not motivating enough). In other words: this is a tool that allows you to add consequences to arbitrary deadlines, so you can take control of your projects (and by extension: your life). 

For making meeting deadlines a little bit more pleasant (and feel less like a grind), I recommend attaching a negative consequence to not fulfilling a task (that's sorted by using TaskRatchet) but also a postive one (reward) if the deadline is met. Something you wouldn't do otherwise that's pleasant for you (like: treat yourself with something nice - my example would be a cheap PlayStation1 second hand video game, I wouldn't buy otherwise).  

## Roadmap & tasks breakdown

- Researching background 
	- Research existing Alternatives
		- Check online if there are any alternative iOS apps being developped
			- #done Google 
			- #done GitHub
			- #done Search GitHub: TaskRatchet
			- #done YouTube
			- #done Search the Beeminder forums: TaskRatchet
			- #done Search Twitter: TaskRatchet
	- Playing with the tool a bit more to understand it a bit better 
	- Playing with their Python API tool to see how it works better
	- Research Task Ratchet API
		- Write down Task Ratchet API spec (that's currently up) and brief documentation
		- Create a Postman Collection docummenting & testing that API
		- I could most likely use their Python API tool to do it

- Prepping for coding
	- Putting the UX mock together (using draw.io)
	- Putting the API mock together (static json files)
	- Wiring TCA library
	- Creating a sample SwiftUI project with a preview

- Coding: putting it all together

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

## Process and tooling ideas
- Tools/processes to help with programming
	- Using GitHub copilot
	- Pair-programming 

## Changelog 
- 2023.02.23: Writing down the Project.md structure with a basic tasks breakdown. Researching about the current state of the project and current landscape around it.
