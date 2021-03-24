# Beacon - Cross Platform Location Sharing app with Flutter

## Overview
    Realtime location tracking app using azure maps and flutter. User can define for how long the location can be shared and starts the stream. Unique session ID "BCode" is generated every time app is launched which the user can share via integrated share plugin or copy to clipboard.

    Users can track others using the session ID "BCode" by using the tracking feature. 

    Users sharing the location as well as those tracking the location will see how many people are concurrently watching the location stream. Indicated by an int in the top left of the sharing/tracking page.


## Current Status:
 - Main branch - UI Prototype with functional ~~native Google maps SDK~~ Azure Maps Integration (Screenshots to be updated), Firebase Integration and Location Transmission, Location tracking as well as concurrent watching logic added.
- Issues relating to tracking page while stream is terminated yet to be addressed
- Geolocation stream doesn't work if the user sharing the location changes the active app or sleeps the screen. Background location fetching not implemented

## Release
0.1v all features functional\
Kindly email me srujanmhase5@gmail.com for an APK if you want to test it\
Known issues on tracking page while stopping location stream. 

## Beacon - Realtime Location sharing app made with Flutter and firebase.



![image info](/images/main.jpg)
The main screen made purely by flutter widgets - stack, containers. Design implemented from a self made mockup in Adobe XD

![image info](/images/share.jpg)
Screen shown after user clicks on start sharing. User is expected to share their "BCode" using the share icon so others can use it to track them.

![image info](/images/codeshare.jpg)
Share widget available to users for sending the BCode after they have clicked Start Sharing too.

![image info](/images/track.jpg)
Users can track others using their respective BCodes and join the session. 

NOTE: UI Mockup done, Functionality yet to be implemented (as of 19/03/2021)

![image info](/images/database.JPG)
Location being uploaded to the database. This is the document reference (address) the users who wish to track using BCode will be constantly getting updates from.