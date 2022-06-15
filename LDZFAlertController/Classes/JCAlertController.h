//
//  JCAlertController.h
//  JCAlertController
//
//  Created by HJaycee on 2017/3/31.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCPresentController.h"
#import "JCAlertStyle.h"
#import "JCAlertAttributedLabel.h"
#import "JCAlertContentView.h"
#import "JCAlertButtonItem.h"

/**
 Same level with UIAlertController.
 Use method 'jc_presentViewController...' in 'UIViewController+JCPresentQueue.h'，It accouts with FIFO or LIFO.
 Use +[JCAlertStyle styleWithType:JCAlertType] to change the style of alertView.
 */
@interface JCAlertController : UIViewController

/**
 Class method to create 'JCAlertController' instance
 The alertView is composed of title, message and buttons
 */
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message;

/**
 The alertView is composed of title, contentView and buttons
 */
+ (instancetype)alertWithTitle:(NSString *)title
                   contentView:(JCAlertContentView *)contentView;

/**
 添加操作按钮
 */
- (void)addButtonWithTitle:(NSString *)title type:(JCButtonType)type clicked:(void (^)(void))clicked;

/**
 Add a button on alertView with title and action
 */
- (void)addCustomButtonWithTitle:(NSString *)title itemConfig:(void (^)(JCAlertButtonItem *item))itemConfig clicked:(void (^)(void))clicked;


@end

@interface JCAlertController (keyboardHandle)

/**
 Monitor keyboard showed state
 
 @param showed callback after keyboard showed
 */
- (void)monitorKeyboardShowed:(void(^)(CGFloat alertHeight, CGFloat keyboardHeight))showed;

/**
 Monitor keyboard hided state
 
 @param hided callback after keyboard hided
 */
- (void)monitorKeyboardHided:(void(^)(void))hided;

/**
 Move alertView to new centerY to avoid the keyboard
 
 @param centerY centerY
 @param animated is animated
 */
- (void)moveAlertViewToCenterY:(CGFloat)centerY animated:(BOOL)animated;

/**
 Move alertView to center of screen
 
 @param animated is animated
 */
- (void)moveAlertViewToScreenCenterAnimated:(BOOL)animated;

@end
