# Watercooler Group Selector

An over-engineered solution to picking randoms of people.

## Motivation

As an organisation who moved predominantly remote working during COVID-19,
we feel we lost the value impromptu socialisation that previous go from being co-located.
Our solution was to randomly select groups of 4 people and schedule a short meeting with them.
The topic for the meeting is not set, the attendess would just talk about whatever came naturally.
 
## Implementation 

I was politely asked to generate some random groups of people.
I could easily have used one of the infinite number of random list generators that already exist,
or I could have scraped something together very quickly in a scripting language.
Instead, I chose to over engineer the solution in Haskell,
for the simple reason that it had been a few months since I'd writting any Haskell.
This also met one of my goals of getting some Haskell _into production_ at Armakuni :-)

## To Configure...

Configuration can be entered in the [config.json](./config.json) file.

## To Run...

The easiest way to run this project is to...
 
1. Install [stack](https://docs.haskellstack.org/en/stable/README/)

   `brew install stack`

2.  Moved to the project root:

    `cd watercooler-selection-tool`
    
3. Run the project using stack:

    `stack run` 