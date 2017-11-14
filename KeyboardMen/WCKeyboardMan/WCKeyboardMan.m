//
//  WCKeyboardMan.m
//  KeyboardMen
//
//  Created by 王超 on 2017/11/8.
//  Copyright © 2017年 Wang Chao. All rights reserved.
//

#import "WCKeyboardMan.h"

@interface WCKeyboardMan ()

@property (nonatomic, weak) NSNotificationCenter *keyboardOberver;
@property (nonatomic, strong) WCKeyboardInfo *keyboardInfo;

@end

@implementation WCKeyboardMan

- (instancetype)initWithAnimateWhenKeyboardAppear:(AnimateWhenKeyboardAppear)animateWhenKeyboardAppear
                     animateWhenKeyboardDisappear:(AnimateWhenKeyboardDisappear)animateWhenKeyboardDisappear {
    self = [super init];
    if (self) {
        _animateWhenKeyboardAppear = animateWhenKeyboardAppear;
        _animateWhenKeyboardDisappear = animateWhenKeyboardDisappear;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)n {
    [self handleKeyboardWithNotification:n keyboardAction:WCKeyboardActionShow];
}

- (void)keyboardWillHide:(NSNotification *)n {
    [self handleKeyboardWithNotification:n keyboardAction:WCKeyboardACtionHide];
}

- (void)keyboardWillChangeFrame:(NSNotification *)n {
    if (self.keyboardInfo && self.keyboardInfo.keyboardAction == WCKeyboardActionShow) {
        [self handleKeyboardWithNotification:n keyboardAction:WCKeyboardActionShow];
    }
}

- (void)handleKeyboardWithNotification:(NSNotification *)n keyboardAction:(WCKeyboardAction)keyboardAction {
    NSDictionary *userInfo = n.userInfo;
    if (userInfo) {
        NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        NSInteger animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
        CGRect frameBegin = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        CGRect frameEnd = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat currentKeyboardHeight = frameEnd.size.height;
        CGFloat previousKeyboardHeight = self.keyboardInfo ? self.keyboardInfo.height : 0;
        CGFloat heightIncrement = currentKeyboardHeight - previousKeyboardHeight;
        WCKeyboardAction previousKeyboardAction = self.keyboardInfo ? self.keyboardInfo.keyboardAction : WCKeyboardACtionHide;
        BOOL isSameKeyboardAction = keyboardAction == previousKeyboardAction;
        self.keyboardInfo = [[WCKeyboardInfo alloc] initWithAnimationDuration:animationDuration
                                                               animationCurve:animationCurve
                                                                   frameBegin:frameBegin
                                                                     frameEnd:frameEnd
                                                                       height:currentKeyboardHeight
                                                              heightIncrement:heightIncrement
                                                               keyboardAction:keyboardAction
                                                         isSameKeyboardAction:isSameKeyboardAction];
    }
}

#pragma mark setter

- (void)setKeyboardInfo:(WCKeyboardInfo *)keyboardInfo {
    if (keyboardInfo == nil) return;
    if (_keyboardInfo != keyboardInfo) {
        _keyboardInfo = keyboardInfo;
        if (!keyboardInfo.isSameKeyboardAction || keyboardInfo.heightIncrement > 0) {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:keyboardInfo.animationduration delay:0 options:keyboardInfo.animationCurve animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                if (keyboardInfo.keyboardAction == WCKeyboardActionShow) {
                    if (weakSelf.animateWhenKeyboardAppear) {
                        weakSelf.animateWhenKeyboardAppear(keyboardInfo.height, keyboardInfo.heightIncrement);
                    }
                } else {
                    if (weakSelf.animateWhenKeyboardDisappear) {
                        weakSelf.animateWhenKeyboardDisappear(keyboardInfo.height, keyboardInfo.heightIncrement);
                    }
                }
            } completion:nil];
        }
    }
}

- (void)setKeyboardObserverEnabled:(BOOL)keyboardObserverEnabled {
    if (_keyboardObserverEnabled != keyboardObserverEnabled) {
        _keyboardObserverEnabled = keyboardObserverEnabled;
        self.keyboardOberver = _keyboardObserverEnabled ? [NSNotificationCenter defaultCenter] : nil;
    }
}

- (void)setKeyboardOberver:(NSNotificationCenter *)keyboardOberver {
    if (_keyboardOberver != keyboardOberver) {
        [_keyboardOberver removeObserver:self];
        _keyboardOberver = keyboardOberver;
        [_keyboardOberver addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [_keyboardOberver addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [_keyboardOberver addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void)setAnimateWhenKeyboardAppear:(AnimateWhenKeyboardAppear)animateWhenKeyboardAppear {
    if (_animateWhenKeyboardAppear == nil) {
        _animateWhenKeyboardAppear = animateWhenKeyboardAppear;
        self.keyboardObserverEnabled = YES;
    }
}

- (void)setAnimateWhenKeyboardDisappear:(AnimateWhenKeyboardDisappear)animateWhenKeyboardDisappear {
    if (_animateWhenKeyboardDisappear == nil) {
        _animateWhenKeyboardDisappear = animateWhenKeyboardDisappear;
        self.keyboardObserverEnabled = YES;
    }
}

@end

@implementation WCKeyboardInfo

- (instancetype)initWithAnimationDuration:(NSTimeInterval)animationduration
                           animationCurve:(NSUInteger)animationCurve
                               frameBegin:(CGRect)frameBegin
                                 frameEnd:(CGRect)frameEnd
                                   height:(CGFloat)height
                          heightIncrement:(CGFloat)heightIncrement
                           keyboardAction:(WCKeyboardAction)keyboardAction
                     isSameKeyboardAction:(BOOL)isSameKeyboardAction {
    self = [super init];
    if (self) {
        _animationduration = animationduration;
        _animationCurve = animationCurve;
        _frameBegin = frameBegin;
        _frameEnd = frameEnd;
        _height = height;
        _heightIncrement = heightIncrement;
        _keyboardAction = keyboardAction;
        _isSameKeyboardAction = isSameKeyboardAction;
    }
    return self;
}

@end
