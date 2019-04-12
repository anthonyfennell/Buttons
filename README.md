
DefaultButton Configurations
----------------------------
- buttonColor: The background color for normal state
- borderColor: The border color for normal and highlighted states. Disabled state will apply an alpha component of 0.35 to the border color
- highlightColor: The background color for highlighted state
- disabledColor: The background color for disabled state
- isShadowed: Enable a shadow layer to the button
- isBackgroundFilled: Enable the background color to be drawn. Disable to have a clear background
(Can adjust this. Show a highlight color for buttons with no background, i.e. border buttons)
- isGradientEnabled: Enable the background color to be drawn as a gradient. 
(Can adjust this. Either horizontal/vertical, add configurable colors to fade from)
- cornerRadius: The corner radius of the background
- borderWidth: The border width of the background
- isHapticEnabled: Enables haptics on button touch up inside

### Key points
- The button is redrawn if any of the above parameters are changed, also if the size changes
- Only touches inside the drawable path shape are responded to with touch events
- Three states have different images drawn: normal, highlighted, disabled
- When highlighted the button is slightly scaled down to show feedback to the user, then scaled up when touches leave the button
- Touch up inside uses a bounce animation using scale with a spring animation. Parameters may be changed.
- May override method touchUpInsideEvent() to add more animations


Subclass DefaultButton
----------------------
1. Add a class that follows the protocol `Drawable`. Inside the method getPath(:::) create a `UIBezierPath` that defines the button shape.
2. Add a subclass to `DefaultButton`. Override the method configure() and assign your class following the `Drawable` protocol to the variable `drawable`.
3. Override the method updateTitleColors() in order to assign different title text colors (Can adjust to be configurable)


Subclass LoadingButton
----------------------
Allows for adding a loading animation after touch up inside. The button is disabled during the loading animation.
1. Override method animateLoading() and add all animation layers to the parameter `animationLayers`. This parameter is used to remove these layers when the the method stopLoadingAnimation() is called.


Animations
----------
- Using `CoreAnimation` with `CALayer`
- Able to add animations that start after an animation finishes by following `CAAnimationDelegate`
