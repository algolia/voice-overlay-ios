# Voice Overlay iOS

A beautiful customizable voice overlay widget that records the user's voice input.

# Demo

![Voice Overlay demo](https://raw.githubusercontent.com/algolia/voice-overlay-ios/master/Resources/voiceoverlay_speech_happy_path.gif)

# Installation

VoiceOverlay is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

Swift 4:

```ruby
pod 'InstantSearchVoiceOverlay'
```

# Usage

1- In info.plist, add these 2 string properties along with the description

- `Privacy - Microphone Usage Description` `some description like Need the mic for audio to text`
- `Privacy - Speech Recognition Usage Description` `some description like Need the speech recognition capabilities`

2- Start the Voice Overlay and listen to the text output

```swift
class ViewController: UIViewController {
    
    let voiceOverlayController = VoiceOverlayController()
    
    @objc func voiceButtonTapped() {
        
        voiceOverlayController.start(on: self, textHandler: { (text, final) in
            print("voice output: \(String(describing: text))")
            print("voice output: is it final? \(String(describing: final))")
        }) { (error) in
            print("voice output: error \(String(describing: error))")
        }
    }
```

## Customization

You can customize your voice overlay by modifying the `settings` property of the voiceOverlayController:

```swift
  /// Specifies whether the overlay directly starts recording (true), or if it requires the user to click the mic (false).
  voiceOverlayController.settings.autoStart = true
  
  /// Specifies whether the overlay stops recording after the user stops talking for `autoStopTimeout` seconds (true), or if it requires the user to click the mic (false).
  voiceOverlayController.settings.autoStop = true
  
  /// when autoStop is set to true, autoStopTimeout determines the amount of silence time before the user stops talking.
  voiceOverlayController.settings.autoStopTimeout = 2
  
  /// Whether or not to show a result screen after the recording is finished.
  voiceOverlayController.settings.showResultScreen = false
  
  /// Timeout for showing the result screen in case no resultScreenText is provided on time.
  voiceOverlayController.settings.showResultScreenTimeout = 2
  
  /// Time for showing the result screen with the provided resultScreenText.
  voiceOverlayController.settings.showResultScreenTime = 4
  
  /// The processed result screen text that should be appear in the result screen.
  voiceOverlayController.settings.resultScreenText = NSAttributedString(string: myString, attributes: myAttributes)
  
  /// The layout and style of all screens of the voice overlay.
  voiceOverlayController.settings.layout
  // Change the title of the recording screen when the recording is ongoing.
  voiceOverlayController.settings.layout.recordingScreen.titleListening = "my custom title"
  // Change the background color of the permission screen
  voiceOverlayController.settings.layout.permissionScreen.backgroundColor = UIColor.red
```

<img src="https://raw.githubusercontent.com/taglia3/CircularSlider/master/Images/storyboardRender.png" width="300">
<img src="https://raw.githubusercontent.com/taglia3/CircularSlider/master/Images/attributeInspector.png" width="300">


## Delegate
Optionally you can conforms to the methods of the CircularSliderDelegate protocol.

If you want to admit only certain values you can implement this methods:
```swift
optional func circularSlider(circularSlider: CircularSlider, valueForValue value: Float) -> Float
```
With this method you override the actual slider value before the slider is updated.
Example: you want only rounded values:

```swift
func circularSlider(circularSlider: CircularSlider, valueForValue value: Float) -> Float {
return floorf(value)
}
```

The other methods you can implement are:

```swift
optional func circularSlider(circularSlider: CircularSlider, didBeginEditing textfield: UITextField)
optional func circularSlider(circularSlider: CircularSlider, didEndEditing textfield: UITextField)
```


## Author

taglia3, matteo.tagliafico@gmail.com

[LinkedIn](https://www.linkedin.com/in/matteo-tagliafico-ba6985a3), Matteo Tagliafico

## License

CircularSpinner is available under the MIT license. See the LICENSE file for more info.


# voice-overlay-ios

Getting started:

In info.plist, add these 2 string properties along with the description

- `Privacy - Microphone Usage Description` `some description like Need the mic for audio to text`
- `Privacy - Speech Recognition Usage Description` `some description like Need the speech recognition capabilities`

Customise with `VoiceUIConstants`