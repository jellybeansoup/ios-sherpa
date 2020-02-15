![Sherpa](https://raw.githubusercontent.com/jellybeansoup/ios-sherpa/master/example/SherpaExample/Images.xcassets/logo.dataset/logo.svg?sanitize=true)

A drop-in solution for displaying a user guide in an iOS app, based on a JSON template.

[![Build Status](https://travis-ci.org/jellybeansoup/ios-sherpa.svg?branch=master)](https://travis-ci.org/jellybeansoup/ios-sherpa)
[![Code Coverage](https://codecov.io/gh/jellybeansoup/ios-sherpa/branch/master/graph/badge.svg)](https://codecov.io/gh/jellybeansoup/ios-sherpa)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Sherpa.svg)](https://cocoapods.org/pods/Sherpa)

## Features

- Compatible with iOS 8.4 and above.
- Provide a plain JSON file for content.
- Deep-link to articles for contextual help.
- User search with query highlighting.
- Built in feedback mechanisms for email and Twitter.
- Customize colors, and optionally provide a `UITableViewCell` subclass to use.

## Installation

### [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) (for Apple platforms only)

In Xcode, select _File_ > _Swift Packages_ > _Add Package Dependency_ and enter the repository URL:

```
https://github.com/jellybeansoup/ios-sherpa
```

### [CocoaPods](http://cocoapods.org/)

Add the following line to your `Podfile`:

```
pod 'Sherpa'
```

### [Carthage](https://github.com/Carthage/Carthage)

Add the following line to your `Podfile`:

```
github "jellybeansoup/ios-sherpa"
```

## How to Use

Sherpa uses a JSON file as the source of its content, which allows you to provide a file in your app bundle, download a file from a server, or both! It handles parsing of the JSON for you, all you need to do is give it the local URL to the document, and it will handle the rest. You don't even need to wrap the view controller in a `UINavigationController`, as this is done automatically; just present the `SherpaViewController` directly and you're good to go.

```swift
let viewController = SherpaViewController(fileAtURL: fileURL)
self.presentViewController(viewController, animated: true, completion: nil)
```

To deep link to a specific article for contextual help, you can optionally provide an `articleKey` that matches the key on the article you would like to link to. Sherpa will present with the selected article open, and allow users to navigate back to the full list of articles to find additional help if they want to.

```swift
let viewController = SherpaViewController(fileAtURL: fileURL)
viewController.articleKey = "related-articles"
self.presentViewController(viewController, animated: true, completion: nil)
```

If you'd like to push Sherpa into an existing `UINavigationController` stack, this is handled gracefully without any additional configuration required. Simply push the `SherpaViewController` directly.

```swift
let viewController = SherpaViewController(fileAtURL: fileURL)
viewController.articleKey = "related-articles"
self.navigationController?.pushViewController(viewController, animated: true)
```

More information about setting up the JSON document can be found within [the example application's UserGuide.json file](https://raw.githubusercontent.com/jellybeansoup/ios-sherpa/master/example/SherpaExample/UserGuide.json). You can read this user guide and see the examples in action by taking the example application itself for a spin. CocoaPods makes this easy with the `pod try Sherpa` command, which can be run from Terminal if you have CocoaPods installed.

## Documentation

You can [find documentation for this project here](https://jellybeansoup.github.io/ios-sherpa/). This documentation is automatically generated with [jazzy](https://github.com/realm/jazzy) from a [GitHub Action](https://jellybeansoup.github.io/ios-sherpa/blob/master/.github/workflows/documentation.yml) and hosted with [GitHub Pages](https://pages.github.com/).

To generate documentation locally, run `make documentation` or `sh ./scripts/documentation.sh` from the repo's root directory. The output will be generated in the docs folder, and should _not_ be included with commits (as the online documentation is automatically generated and updated).

## Get in Touch

If you have questions, I can be found on [Twitter](https://twitter.com/jellybeansoup), or you can get in touch via [email](https://jellystyle.com/contact).

## Released under the BSD License

Copyright © 2019 Daniel Farrelly

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

*	Redistributions of source code must retain the above copyright notice, this list
	of conditions and the following disclaimer.
*	Redistributions in binary form must reproduce the above copyright notice, this
	list of conditions and the following disclaimer in the documentation and/or
	other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
