
# MovieDB iOS App

This project is for learning / experiment purposes.

## Tech Stack

So for the tech stack I’ve decided on based on project requirements and scope,

**Design pattern**: MVVM

**UI**: UIKit programmatically

**Third party pods**: 
- Moya for network layer
- SnapKit for autolayout
- SkeletonView for shimmer loading
- Kingfisher for image caching and loading
- youtube-ios-player-helper for youtube player
- swiftlint for code convention (local)

**Minimum iOS**: 13

## UI
Since the UI is pretty simple, we’ll use programatically.

## Flow
For the information flow between view and viewModel, I put closure to notify the view to update the view, mainly for updating the cell and error state. 

Since we’re using collectionView anyway, I decided to not using data-binding like Rx or combine to make it simple.

## Service Layer
I used Moya to easily create a service layer to make it easier for testing and reusability. 

## Features

- Get popular movie list
- Smooth Infinity Loading
- Support both dark mode and light mode (interchangeably).
- Business Logic unit tested.
- QA Tested personally.


## Troubleshooting

While developing I've encountered few issues.

### Main thread update warning
Apparently because the image url is not secure / not https, it triggers the XCode security warning and does something with it. After some research it's probably Apple's side bug. https://stackoverflow.com/questions/74038451/in-xcode-14-ios-16-purple-warnings-starting-with-this-method-should-not-be-ca/74311402#74311402

## Unit Testing
I made sure to cover available business logic.
