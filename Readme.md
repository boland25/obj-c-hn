###Hacker News RSS Feeder App

This is an app for iOS that displays the rss feeds from a site called hacker news. https://news.ycombinator.com/rss

There are two main screens, one displays the list of articles to read, and when an artile is chosen, it shows the details of that article.  On the detail page there is a link to the article as well as comments about it.

###Build

This projects uses Cocoapods.  In order to build the project, you will need to have the latest version of cocoapods installed. www.cocoapods.org for more information.

Once Cocoapods is successfully installed, cd to the root file where you see the Podfile, and type 

`pod install`

that will install the missing frameworks and allow the project to be built.  

*Note: once cocoapods is used, the project will need to be run from `GBHackerNew.xcworkspace`

Open .xcworkspace and hit build, and watch the magic happen.  Will need XCode 5 and run on an OS running 7.0 or later



###List of still need to do
- implement the pull to refresh
- implement the label tap out to outside link

