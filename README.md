# Gradient Navigation Bar

This package lets you create a bottom navigation bar with the selected item overlayed on a gradient apart from the selected color provided.

<image src="gradient-select.gif" height="100em"/>

## Getting Started

You will need to add the following dependency in your `pubspec.yaml` file to download the depedency.

```dart
dependencies:
  flutter:
    sdk: flutter
  gradient_nav_bar: 1.0.0
```
Note: This was built on the following tools.

* Flutter - v1.7.8+hotfix.4
* Dart - vDart 2.4.0

### Usage

When you add a bottom navigation bar to your application, use the `GradientNavigationBar` you will receive with this package. Following are the parameters that the constructor takes:

#### Mandatory
* `items` - This is mandatory and needs to have atleast 2 items. This is a list of `TabInfo` items which will create the tab items. The `TabInfo` takes 2 parameters - `icon` and `label`. The `icon` is mandatory.

#### Optional
* `labelColor` - The unselected label color. Default is grey.
* `iconColor` - The unselected icon color. Default is grey.
* `selectedLabelColor` - The selected label color. Default is white.
* `selectedIconColor` - The selected icon color. Default is white.
* `backgroundColor` - The background color of the navigation bar. Default is the theme's background color.
* `currentIndex` - This is the current selected item's index.
* `onTap` - A call back function to determine the value changed
* `showLabel` - A bool value to show the label on the bar. It is false by default.
* `selectedFontSize` - The font size of the label of the selected item. The default value is 14.0
* `unselectedFontSize` - The font size of the label of the unselected item. The default value is 12.0

[Example](https://github.com/rejish4gt/gradient-nav-bar/blob/master/example/example.dart)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Authors

* **Rejish Radhakrishnan**

## License

Copyright 2019 Rejish Radhakrishnan

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
