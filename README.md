# Pre-work - Tip With Friends!

Tip With Friends! is a tip calculator application for iOS.

Submitted by: Thomas Grundy

Time spent: 10 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Views are made using auto-layout constraints, so the app should display correctly at all phone sizes, from iPhone SE to 7 plus.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/fUGcgzX.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

*NOTE:* The above gif is also included in the Assets.xcassets folder, as Imgur may autodelete my gif (they seemed to have gotten aggressive with pruning images that don't get accessed). 

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** I think Swift is a really beautiful language, though I definitely do not have a firm grasp on how to safely unwrap optionals. Auto layout seems pretty straight-forward, and making builds, both for the simulator and for an actual device, seem pretty straight forward to get going. I would describe outlets and actions as a way to make explicit references, either for variables or functions, from elements defined in iOS's UI building file format, to actual Swift/Objective C code. It looks like they are implemented under the hood by applying id's to the XML elements that the Swift code then uses.

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** A strong reference closure would occur when you have a closure that has strong references to other variables in the class instance it is a part of. For example, if your class has variables that the closure then accesses with `self.nameOfClassInstanceVariable`, if you then redefine that closure, that reference to the variable will still be valid, so it won't get cleaned up.'


## License

Copyright 2017 Thomas Grundy

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
