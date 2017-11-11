//
//  ViewController.m
//  KeyboardMen
//
//  Created by 王超 on 2017/11/8.
//  Copyright © 2017年 Wang Chao. All rights reserved.
//

#import "ViewController.h"
#import "WCKeyboardMan.h"

@interface ViewController ()
@property (nonatomic, strong) WCKeyboardMan *keyboardManager;

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UITextField *testField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseViewBottomConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%f", self.baseViewBottomConstraint.constant);
    __weak typeof(self) weakSelf = self;
    self.keyboardManager = [[WCKeyboardMan alloc] initWithAnimateWhenKeyboardAppear:^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        NSLog(@"keyboardHeight:%f, keyboardIncrement:%f", keyboardHeight, keyboardInrement);
        weakSelf.baseViewBottomConstraint.constant = keyboardHeight;
        weakSelf.coverView.hidden = NO;
        [weakSelf.view layoutIfNeeded];
    } animateWhenKeyboardDisappear:^(CGFloat keyboardHeight, CGFloat keyboardInrement) {
        NSLog(@"keyboardHeight:%f, keyboardIncrement:%f", keyboardHeight, keyboardInrement);
        weakSelf.baseViewBottomConstraint.constant = 0.0;
        weakSelf.coverView.hidden = YES;
        [weakSelf.view layoutIfNeeded];
    }];
    self.keyboardManager.keyboardObserverEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction

- (IBAction)coverViewDidTapped:(UITapGestureRecognizer *)sender {
    if ([self.testField respondsToSelector:@selector(resignFirstResponder)]) {
        [self.testField resignFirstResponder];
    }
}

@end
