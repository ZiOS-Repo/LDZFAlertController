//
//  JCAlertStyle.m
//  JCAlertController
//
//  Created by HJaycee on 2017/4/5.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import "JCAlertStyle.h"

#define JCColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define JCDefaultTextColor JCColor(0,0,0)

@interface JCAlertStyleCache : NSObject

@property (nonatomic, strong) JCAlertStyle *styleNormal;
@property (nonatomic, strong) JCAlertStyle *styleTitleOnly;
@property (nonatomic, strong) JCAlertStyle *styleContentOnly;

@end

@implementation JCAlertStyleCache
@end

@implementation JCAlertStyleAlertView @end
@implementation JCAlertStyleBackground @end
@implementation JCAlertStyleTitle @end
@implementation JCAlertStyleContent @end
@implementation JCAlertStyleButton @end
@implementation JCAlertStyleButtonNormal @end
@implementation JCAlertStyleButtonCancel @end
@implementation JCAlertStyleButtonWarning @end
@implementation JCAlertStyleSeparator @end

@implementation JCAlertStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self useDefaultStyle];
    }
    return self;
}

- (void)useDefaultStyle {
    JCAlertStyleBackground *background = [JCAlertStyleBackground new];
    background.blur = NO;
    background.canDismiss = NO;
    background.alpha = 0.3;
    
    JCAlertStyleAlertView *alertView = [JCAlertStyleAlertView new];
    alertView.width = [UIScreen mainScreen].bounds.size.width == 320 ? 260 : 280;
    alertView.maxHeight = [UIScreen mainScreen].bounds.size.height - 120;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.cornerRadius = 8;
    //UIEdgeInsetsMake(20, 16, 20, 16);
    JCAlertStyleTitle *title = [JCAlertStyleTitle new];
    title.insets = UIEdgeInsetsMake(20, 16, 0, 16);
    title.onlyTitleInsets = UIEdgeInsetsMake(20, 16, 20, 16);
    title.font = [UIFont boldSystemFontOfSize:17];
    title.textColor = JCDefaultTextColor;
    title.backgroundColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    
    JCAlertStyleContent *content = [JCAlertStyleContent new];
    content.insets = UIEdgeInsetsMake(5, 16, 20, 16);
    content.onlyMessageInsets = UIEdgeInsetsMake(20, 16, 20, 16);
    content.font = [UIFont systemFontOfSize:15];
    content.textColor = JCDefaultTextColor;
    content.backgroundColor = [UIColor whiteColor];
    content.textAlignment = NSTextAlignmentCenter;
    
    JCAlertStyleButtonNormal *buttonNormal = [JCAlertStyleButtonNormal new];
    buttonNormal.height = 44;
    buttonNormal.font = [UIFont systemFontOfSize:17];
    buttonNormal.textColor = JCDefaultTextColor;
    buttonNormal.backgroundColor = [UIColor whiteColor];
    buttonNormal.highlightTextColor = JCDefaultTextColor;
    buttonNormal.highlightBackgroundColor = JCColor(224, 224, 224);
    
    JCAlertStyleButtonCancel *buttonCancel = [JCAlertStyleButtonCancel new];
    buttonCancel.height = 44;
    buttonCancel.font = [UIFont systemFontOfSize:17];
    buttonCancel.textColor = JCDefaultTextColor;
    buttonCancel.backgroundColor = [UIColor whiteColor];
    buttonCancel.highlightTextColor = JCDefaultTextColor;
    buttonCancel.highlightBackgroundColor = JCColor(224, 224, 224);
    
    JCAlertStyleButtonWarning *buttonWarning = [JCAlertStyleButtonWarning new];
    buttonWarning.height = 44;
    buttonWarning.font = [UIFont systemFontOfSize:17];
    buttonWarning.textColor = JCColor(248, 59, 50);
    buttonWarning.backgroundColor = [UIColor whiteColor];
    buttonWarning.highlightTextColor = JCColor(248, 59, 50);
    buttonWarning.highlightBackgroundColor = JCColor(224, 224, 224);
    
    JCAlertStyleSeparator *separator = [JCAlertStyleSeparator new];
    separator.width = 0.5;
    separator.color = JCColor(232, 232, 232);

    self.background = background;
    self.alertView = alertView;
    self.title = title;
    self.content = content;
    self.buttonNormal = buttonNormal;
    self.buttonCancel = buttonCancel;
    self.buttonWarning = buttonWarning;
    self.separator = separator;
}

- (void)useTitleOnlyStyle {
    self.title.insets = UIEdgeInsetsMake(28, 20, 28, 20);
}

- (void)useContentOnlyStyle {
    self.content.insets = UIEdgeInsetsMake(28, 20, 28, 20);
}

@end
