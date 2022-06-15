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


/*
 How to use ?
 
 NSArray *specials = @[@"特空",@"用户授权协议"];
 NSString *full = [NSString stringWithFormat:@"app即将授权%@获取您的手机号。点击“同意授权”即表示您知晓并同意%@",specials.firstObject,specials.lastObject];
     
 //属性文本生成器
 TYTextContainer *textContainer = [[TYTextContainer alloc] init];
 textContainer.text = full;
 textContainer.textColor = [UIColor blackColor];
 textContainer.font = [UIFont systemFontOfSize:15];
//    textContainer.linesSpacing = 0.5;// 文本行间隙
//    textContainer.characterSpacing = 15;// 文字间隙
 
 //文字样式
 NSRange firstRange = [full rangeOfString:specials.lastObject];
 TYTextStorage *textStorage = [[TYTextStorage alloc]init];
 textStorage.range = firstRange;
 textStorage.font = [UIFont boldSystemFontOfSize:15];
 textStorage.textColor = [UIColor blueColor];
 [textContainer addTextStorage:textStorage];
 
 //下划线文字
 TYLinkTextStorage *linkTextStorage = [[TYLinkTextStorage alloc]init];
 linkTextStorage.range = firstRange;
 linkTextStorage.linkData = @"登录芬兰航空";
 linkTextStorage.underLineStyle = kCTUnderlineStyleNone; //取消下划线
 [textContainer addTextStorage:linkTextStorage];
 
 
 CGFloat width = [[JCAlertStyle alloc] init].alertView.width;
 JCAlertAttributedLabel *attributedLabel = [[JCAlertAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
 attributedLabel.userInteractionEnabled = YES;
 attributedLabel.lable.backgroundColor = [UIColor clearColor];
 attributedLabel.lable.textContainer = textContainer;
 attributedLabel.lable.textAlignment = kCTTextAlignmentCenter;//设置居中

 [attributedLabel setTextStorageClicked:^(TYAttributedLabel * _Nonnull attributedLabel, id<TYTextStorageProtocol>  _Nonnull textStorage, CGPoint point) {
     if ([textStorage isKindOfClass:[TYLinkTextStorage class]]){
         TYLinkTextStorage *storage = (TYLinkTextStorage *)textStorage;
         NSString *msg = [NSString stringWithFormat:@"%@",storage.linkData];
         UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
         [alertView show];
     }
 }];

 // pass the contentView
 JCAlertController *alert = [JCAlertController alertWithTitle:nil contentView:attributedLabel];
 [alert addButtonWithTitle:@"下次再说" type:JCButtonTypeNormal clicked:nil];
 [alert addCustomButtonWithTitle:@"同意" itemConfig:^(JCAlertButtonItem *item) {
     item.textColor = [UIColor blueColor];
     item.highlightTextColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
 } clicked:nil];

 [JCPresentController presentViewControllerLIFO:alert presentCompletion:nil dismissCompletion:nil];
 
 
 */
