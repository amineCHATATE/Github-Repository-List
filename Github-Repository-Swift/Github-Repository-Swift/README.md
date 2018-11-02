# Github-Repository-Swift

The app use the SDWebImage Library.
To open the project choose the file "Github-Repository-Swift.xcworkspace"

## Features

The list starred Github repos that were created in the last 30 days.
The results as a list. One repository per row.
Each repo/row the following details :
+ Repository name
+ Repository description
+ Numbers of stars for the repo.
+ Username and avatar of the owner.
+ [BONUS] Continuing to scroll the screen and new results should appear (pagination).

## Geting Data - First 30 pages
Here we can use the function :
```swift
Data(contentsOf: queryUrl)
```
then we decode the received data witch is encoded on Json format with the the function :
```swift
decoder.decode(GithubResponse.self, from: data)
```
## Geting Data - Next pages
To get data from next pages we change only the URL.

## Structures :
GithubResponse contain structures of the json file :
```swift
struct GithubResponse: Codable {
    var total_count: Int32
    var incomplete_results: Bool
    var items: [Repository]
}
```
```swift
struct Repository: Codable {
    var name: String
    var owner: Owner
    var description: String
    var stargazers_count: Int
}
```
```swift
struct Owner: Codable {
    var login: String
    var avatar_url: URL
}
```

## Getting images
The scrolling becomes slow, due to the time required to download, which exceeds 16 ms, which is recommended to maintain scrolling at a normal speed. To solve this problem, we can use "SDWebImage Library", like this :
```swift
cell.avatar.sd_setImage(with: self.arrayRepository[indexPath.row].owner.avatar_url, completed: nil)
```

## Animation
We animate the display of row by modifying the transparent alpha property (value equal to 0) to opaque (value equal to 1) :
```swift
cell.alpha = 0
```
And we add a transition from the left (home position) to the right (end position) of the phone :
```swift
let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
cell.layer.transform = transform
```
Finally we animate the transition,which take 1 second:
```swift
UIView.animate(withDuration: 1.0) {
     cell.alpha = 1.0
     cell.layer.transform = CATransform3DIdentity
}
```

## Sending data to the "UITableViewController"
here we have to ways, whether we can use **delegate/extension** or **observer/publish subscribe design pattern**.
In this project I used the first solution

## Questions
For any informations, please feel free to contact me.
