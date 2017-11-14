# WCKeyboardMan

Useful keyboard manager

``` 
    WCKeyboardMan * keyboardObserver = [[WCKeyboardMan alloc] initWithAnimateWhenKeyboardAppear:^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        // keyboard will appear
    } animateWhenKeyboardDisappear:^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        // keyboard will disappear
    }];
```