# WCKeyboardMan

Useful keyboard manager

### Usage:

``` 
    WCKeyboardMan *keyboardObserver = [[WCKeyboardMan alloc] initWithAnimateWhenKeyboardAppear:^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        // keyboard will appear
    } animateWhenKeyboardDisappear:^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        // keyboard will disappear
    }];
    keyboardObserver.keyboardObserverEnabled = YES;
```

或者

``` 
    WCKeyboardMan *keyboardObserver = [[WCKeyboardMan alloc] init];
    keyboardObserver.animateWhenKeyboardAppear = ^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        // keyboard will appear
    };
    keyboardObserver.animateWhenKeyboardDisappear = ^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        // keyboard will disappear
    };
    keyboardObserver.keyboardObserverEnabled = YES;
```