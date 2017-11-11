//
//  WCKeyboardMan.h
//  KeyboardMen
//
//  Created by 王超 on 2017/11/8.
//  Copyright © 2017年 Wang Chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AnimateWhenKeyboardAppear)(CGFloat keyboardHeight, CGFloat keyboardInrement);
typedef void (^AnimateWhenKeyboardDisappear)(CGFloat keyboardHeight, CGFloat keyboardInrement);

@interface WCKeyboardMan : NSObject

@property (nonatomic, assign) BOOL keyboardObserverEnabled;
@property (nonatomic, copy) AnimateWhenKeyboardAppear animateWhenKeyboardAppear;
@property (nonatomic, copy) AnimateWhenKeyboardDisappear animateWhenKeyboardDisappear;

- (instancetype)initWithAnimateWhenKeyboardAppear:(AnimateWhenKeyboardAppear)animateWhenKeyboardAppear
                    animateWhenKeyboardDisappear:(AnimateWhenKeyboardDisappear)animateWhenKeyboardDisappear;
@end

typedef NS_ENUM(NSInteger, WCKeyboardAction) {
    WCKeyboardActionShow = 1,
    WCKeyboardACtionHide
};

@interface WCKeyboardInfo : NSObject

@property (nonatomic, assign) NSTimeInterval animationduration;
@property (nonatomic, assign) NSUInteger animationCurve;
@property (nonatomic, assign) CGRect frameBegin;
@property (nonatomic, assign) CGRect frameEnd;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat heightIncrement;
@property (nonatomic, assign) WCKeyboardAction keyboardAction;
@property (nonatomic, assign) BOOL isSameKeyboardAction;

- (instancetype)initWithAnimationDuration:(NSTimeInterval)animationduration
                           animationCurve:(NSUInteger)animationCurve
                               frameBegin:(CGRect)frameBegin
                                 frameEnd:(CGRect)frameEnd
                                   height:(CGFloat)height
                          heightIncrement:(CGFloat)heightIncrement
                           keyboardAction:(WCKeyboardAction)keyboardAction
                     isSameKeyboardAction:(BOOL)isSameKeyboardAction;

@end
