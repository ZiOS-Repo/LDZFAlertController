//
//  JCAlertButtonItem.h
//  JCAlertController
//
//  Created by HJaycee on 2017/4/5.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCAlertStyle.h"

@interface JCAlertButtonItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) void (^clicked)(void);
@property (nonatomic) JCButtonType type;

@end
