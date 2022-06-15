//
//  JCAlertController.m
//  JCAlertController
//
//  Created by HJaycee on 2017/4/1.
//  Copyright © 2017年 HJaycee. All rights reserved.
//

#import "JCAlertView.h"
#import "NSAttributedString+JCCalculateSize.h"
#import "JCAlertButtonItem.h"
#import "UIImage+JCColor2Image.h"
#import <Masonry/Masonry.h>

NSInteger kButtonTag = 74637;

@interface JCAlertButtonsView : UIView

@property (nonatomic, strong) NSArray <JCAlertButtonItem *>*buttonsArray;

@property (nonatomic, strong) JCAlertStyle *style;

@property (nonatomic, copy) void(^ButtonClickAction)(JCAlertButtonItem *item);


- (instancetype)initWithButtonsArray:(NSArray *)buttonsArray style:(JCAlertStyle *)style;

@end

@implementation JCAlertButtonsView

- (instancetype)initWithButtonsArray:(NSArray *)buttonsArray style:(JCAlertStyle *)style {
    if (self = [super initWithFrame:CGRectZero]) {
        _buttonsArray = buttonsArray;
        _style = style;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    UIView *topLineView = [[UIView alloc] init];
    topLineView.backgroundColor = self.style.separator.color;
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self);
        make.height.mas_equalTo(self.style.separator.width);
    }];
    
    for (NSInteger i = 0; i < self.buttonsArray.count; i++) {
        JCAlertButtonItem *item = self.buttonsArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = kButtonTag+i;
        [button setTitle:item.title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (item.type == JCButtonTypeNormal) {
            button.titleLabel.font = self.style.buttonNormal.font;
            [button setTitleColor:self.style.buttonNormal.textColor forState:UIControlStateNormal];
            [button setTitleColor:self.style.buttonNormal.highlightTextColor forState:UIControlStateHighlighted];
            [button setBackgroundImage:[UIImage createImageWithColor:self.style.buttonNormal.backgroundColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:self.style.buttonNormal.highlightBackgroundColor] forState:UIControlStateHighlighted];

        } else if (item.type == JCButtonTypeCancel) {
            button.titleLabel.font = self.style.buttonCancel.font;
            [button setTitleColor:self.style.buttonCancel.textColor forState:UIControlStateNormal];
            [button setTitleColor:self.style.buttonCancel.highlightTextColor forState:UIControlStateHighlighted];
            [button setBackgroundImage:[UIImage createImageWithColor:self.style.buttonCancel.backgroundColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:self.style.buttonCancel.highlightBackgroundColor] forState:UIControlStateHighlighted];

        } else if (item.type == JCButtonTypeWarning) {
            button.titleLabel.font = self.style.buttonWarning.font;
            [button setTitleColor:self.style.buttonWarning.textColor forState:UIControlStateNormal];
            [button setTitleColor:self.style.buttonWarning.highlightTextColor forState:UIControlStateHighlighted];
            [button setBackgroundImage:[UIImage createImageWithColor:self.style.buttonWarning.backgroundColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:self.style.buttonWarning.highlightBackgroundColor] forState:UIControlStateHighlighted];

        } else if (item.type == JCButtonTypeCustom) {
            button.titleLabel.font = item.font ? item.font:self.style.buttonNormal.font;
            [button setTitleColor:item.textColor ? item.textColor:self.style.buttonNormal.textColor forState:UIControlStateNormal];
            [button setTitleColor:item.highlightTextColor ? item.highlightTextColor:self.style.buttonNormal.highlightTextColor forState:UIControlStateHighlighted];
            [button setBackgroundImage:[UIImage createImageWithColor:item.backgroundColor ? item.backgroundColor:self.style.buttonNormal.backgroundColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage createImageWithColor:item.highlightBackgroundColor ? item.highlightBackgroundColor:self.style.buttonNormal.highlightBackgroundColor] forState:UIControlStateHighlighted];
        }
        
        [self addSubview:button];
        if (self.buttonsArray.count == 2) {
            CGFloat width = self.style.alertView.width/2.f;
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(self.style.buttonNormal.height);
                make.top.equalTo(self);
                make.leading.equalTo(self).mas_equalTo(i*width);
            }];
        } else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(self);
                make.height.mas_equalTo(self.style.buttonNormal.height);
                make.width.mas_equalTo(self.style.alertView.width);
                make.top.equalTo(self).mas_equalTo(self.style.buttonNormal.height*i);
            }];
        }
    }
    
    //添加分割线
    if (self.buttonsArray.count == 2) {
        CGFloat width = self.style.alertView.width/2.f;
        UIView *middleLine = [[UIView alloc] init];
        middleLine.backgroundColor = self.style.separator.color;
        [self addSubview:middleLine];
        [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.leading.equalTo(self).mas_equalTo(width);
            make.width.mas_equalTo(self.style.separator.width);
        }];
    } else if (self.buttonsArray.count > 2) {
        for (NSInteger i = 1; i < self.buttonsArray.count; i++) {
            UIView *bottomLineView = [[UIView alloc] init];
            bottomLineView.backgroundColor = self.style.separator.color;
            [self addSubview:bottomLineView];
            [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(self);
                make.height.mas_equalTo(self.style.separator.width);
                make.top.mas_equalTo(self.style.buttonNormal.height*(i));
            }];
        }
    }
    
    
    
}

- (void)emphasizeButton:(UIButton *)button {
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.f];
}

- (void)buttonAction:(UIButton *)button {
    if (self.ButtonClickAction) {
        self.ButtonClickAction(self.buttonsArray[button.tag-kButtonTag]);
    }
}


@end




@interface JCAlertView ()

@property (nonatomic) CGFloat buttonHeight;

@end

@implementation JCAlertView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    self.backgroundColor = [UIColor clearColor];
    
    JCAlertStyle *style = self.style;
    
    UIEdgeInsets titleInsets = style.title.insets;
    if (self.title && self.title.length > 0 && (!self.message || self.message.length == 0) && !self.contentView) {
        titleInsets = style.title.onlyTitleInsets;
    }
    
    UIEdgeInsets messageInsets = style.content.insets;
    if (self.message && self.message.length > 0 && (!self.title || self.title.length == 0)) {
        messageInsets = style.content.onlyMessageInsets;
    }
    
    // button height
    self.buttonHeight = 0;
    if (self.buttonItems.count > 0) {
        BOOL moreAction = self.buttonItems.count > 2 ? YES:NO;
        self.buttonHeight = moreAction ? self.buttonItems.count * self.style.buttonNormal.height : self.style.buttonNormal.height;
    }

    // cal title height
    CGFloat titleHeight = 0;
    CGSize titleSize = CGSizeZero;
    if (self.title.length > 0) {
        NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:self.title attributes:@{NSFontAttributeName:style.title.font}];
        titleSize = [titleStr sizeWithMaxWidth:style.alertView.width - titleInsets.left - titleInsets.right];
        titleHeight = titleSize.height + titleInsets.top + titleInsets.bottom;
    }
    
    // title one line height
    NSAttributedString *titleChar = [[NSAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName:style.title.font}];
    CGFloat titleCharHeight = [titleChar sizeWithMaxWidth:self.frame.size.width].height;
    
    // if has contentView
    if (self.contentView) {
        CGFloat contentViewH = [self.contentView calculateContentViewHWithAlertViewWidth:self.style.alertView.width];
        
        CGFloat totalHeight = titleHeight + contentViewH + self.buttonHeight;
        CGFloat alertHeight = totalHeight > self.style.alertView.maxHeight ? self.style.alertView.maxHeight : totalHeight;
        self.frame = CGRectMake(0, 0, style.alertView.width, alertHeight);
        
        if (titleHeight > 0) {
            if (titleSize.height <= titleCharHeight) { // show in center
                UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(titleInsets.left, titleInsets.top, style.alertView.width - titleInsets.left - titleInsets.right, titleCharHeight))];
                titleView.text = self.title;
                titleView.font = style.title.font;
                titleView.textColor = style.title.textColor;
                titleView.backgroundColor = [UIColor clearColor];
                titleView.textAlignment = style.title.textAlignment;
                
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, titleHeight)];
                bgView.backgroundColor = style.title.backgroundColor;
                [bgView addSubview:titleView];
                
                [self addSubview:bgView];
            } else { // break line use textview
                UITextView *titleView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, titleHeight)];
                titleView.textContainerInset = titleInsets;
                titleView.text = self.title;
                titleView.font = style.title.font;
                titleView.textColor = style.title.textColor;
                titleView.backgroundColor = style.title.backgroundColor;
                titleView.editable = NO;
                titleView.selectable = NO;
                titleView.scrollEnabled = YES;
                titleView.textAlignment = style.title.textAlignment;
                // because contentsize.height < frame.size.height
                if (titleView.frame.size.height < titleView.contentSize.height) {
                    CGRect newF = titleView.frame;
                    newF.size.height = titleView.contentSize.height;
                    titleView.frame = newF;
                }
                titleView.scrollEnabled = NO;
                [self addSubview:titleView];
            }
        }
        
        CGRect contentFrame = CGRectMake(0, titleHeight, self.style.alertView.width, contentViewH);
        
        CGFloat maxContentHeight = self.style.alertView.maxHeight - titleHeight - self.buttonHeight;
        if (CGRectGetHeight(contentFrame) > maxContentHeight) {
            CGRect scrollFrame = contentFrame;
            scrollFrame.size.height = maxContentHeight;
            UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
            contentScrollView.contentSize = contentFrame.size;
            contentScrollView.backgroundColor = self.style.alertView.backgroundColor;
            [self addSubview:contentScrollView];
            
            self.contentView.frame = CGRectMake(0, 0, self.style.alertView.width, contentViewH);;
            [contentScrollView addSubview:self.contentView];
        } else {
            self.contentView.frame = contentFrame;
            [self addSubview:self.contentView];
        }
        
        [self setupButton];
        
        if (titleHeight + self.buttonHeight > 0) {
            self.layer.cornerRadius = style.alertView.cornerRadius;
            if (self.layer.cornerRadius > 0) {
                self.clipsToBounds = YES;
            }
        }
        
        self.center = newSuperview.center;
        return;
    }
    
    // title height than max
    CGFloat maxUnstretchTitleHeight = style.alertView.maxHeight - self.buttonHeight;
    
    // cal content height
    CGFloat contentHeight = 0;
    CGSize contentSize = CGSizeZero;
    if (self.message.length > 0) {
        NSAttributedString *contentStr = [[NSAttributedString alloc] initWithString:self.message attributes:@{NSFontAttributeName:style.content.font}];
        contentSize = [contentStr sizeWithMaxWidth:style.alertView.width - messageInsets.left - messageInsets.right];
        contentHeight = contentSize.height + messageInsets.top + messageInsets.bottom;
    }
    
    // content one line height
    NSAttributedString *contentChar = [[NSAttributedString alloc] initWithString:@" " attributes:@{NSFontAttributeName:style.content.font}];
    CGFloat contentCharHeight = [contentChar sizeWithMaxWidth:self.frame.size.width].height;
    
    // give alert frame
    if (titleHeight + contentHeight + self.buttonHeight > style.alertView.maxHeight) {
        self.frame = CGRectMake(0, 0, style.alertView.width, style.alertView.maxHeight);
    } else {
        self.frame = CGRectMake(0, 0, style.alertView.width, titleHeight + contentHeight + self.buttonHeight);
    }
    
    // layout
    if (titleHeight + contentHeight + self.buttonHeight < style.alertView.maxHeight) { // in max height
        if (titleHeight > 0) {
            if (titleSize.height <= titleCharHeight) { // show in center
                UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(titleInsets.left, titleInsets.top, style.alertView.width - titleInsets.left - titleInsets.right, titleCharHeight))];
                titleView.text = self.title;
                titleView.font = style.title.font;
                titleView.textColor = style.title.textColor;
                titleView.backgroundColor = [UIColor clearColor];
                titleView.textAlignment = style.title.textAlignment;
                
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, titleHeight)];
                bgView.backgroundColor = style.title.backgroundColor;
                [bgView addSubview:titleView];
                
                [self addSubview:bgView];
            } else {
                UITextView *titleView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, titleHeight)];
                titleView.text = self.title;
                titleView.font = style.title.font;
                titleView.textContainerInset = titleInsets;
                titleView.textColor = style.title.textColor;
                titleView.backgroundColor = style.title.backgroundColor;
                titleView.editable = NO;
                titleView.selectable = NO;
                titleView.scrollEnabled = YES;
                titleView.textAlignment = style.title.textAlignment;
                // because contentsize.height < frame.size.height
                if (titleView.frame.size.height < titleView.contentSize.height) {
                    CGRect newF = titleView.frame;
                    newF.size.height = titleView.contentSize.height;
                    titleView.frame = newF;
                }
                titleView.scrollEnabled = NO;
                [self addSubview:titleView];
            }
        }
        
        if (contentHeight > 0) {
            if (contentSize.height <= contentCharHeight) {
                UILabel *contentView = [[UILabel alloc] initWithFrame:CGRectMake(messageInsets.left, messageInsets.top, style.alertView.width - messageInsets.left - messageInsets.right, contentCharHeight)];
                contentView.text = self.message;
                contentView.font = style.content.font;
                contentView.textColor = style.content.textColor;
                contentView.backgroundColor = [UIColor clearColor];
                contentView.textAlignment = style.content.textAlignment;
                
                UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, titleHeight, style.alertView.width, contentHeight)];
                bgView.backgroundColor = style.content.backgroundColor;
                [bgView addSubview:contentView];
                
                [self addSubview:bgView];
            } else {
                UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, titleHeight, style.alertView.width, contentHeight)];
                contentView.textContainerInset = messageInsets;
                contentView.text = self.message;
                contentView.font = style.content.font;
                contentView.textColor = style.content.textColor;
                contentView.backgroundColor = style.content.backgroundColor;
                contentView.editable = NO;
                contentView.selectable = NO;
                contentView.scrollEnabled = YES;
                contentView.textAlignment = style.content.textAlignment;
                // because contentsize.height < frame.size.height
                if (contentView.frame.size.height < contentView.contentSize.height) {
                    CGRect newF = contentView.frame;
                    newF.size.height = contentView.contentSize.height;
                    contentView.frame = newF;
                }
                contentView.scrollEnabled = NO;
                [self addSubview:contentView];
            }
        }

        [self setupButton];
    } else {
        if (titleHeight > maxUnstretchTitleHeight) { // title scrollable
            UITextView *titleView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, maxUnstretchTitleHeight)];
            titleView.textContainerInset = titleInsets;
            titleView.text = self.title;
            titleView.font = style.title.font;
            titleView.textColor = style.title.textColor;
            titleView.backgroundColor = style.title.backgroundColor;
            titleView.editable = NO;
            titleView.selectable = NO;
            titleView.textAlignment = style.title.textAlignment;
            [self addSubview:titleView];

            [self setupButton];
        } else { // content scrollable
            if (titleHeight > 0) {
                if (titleSize.height <= titleCharHeight) { // show in center
                    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(titleInsets.left, titleInsets.top, style.alertView.width - titleInsets.left - titleInsets.right, titleCharHeight))];
                    titleView.text = self.title;
                    titleView.font = style.title.font;
                    titleView.textColor = style.title.textColor;
                    titleView.backgroundColor = [UIColor clearColor];
                    titleView.textAlignment = style.title.textAlignment;
                    
                    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, titleHeight)];
                    bgView.backgroundColor = style.title.backgroundColor;
                    [bgView addSubview:titleView];
                    
                    [self addSubview:bgView];
                } else { 
                    UITextView *titleView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, style.alertView.width, titleHeight)];
                    titleView.textContainerInset = titleInsets;
                    titleView.text = self.title;
                    titleView.font = style.title.font;
                    titleView.textColor = style.title.textColor;
                    titleView.backgroundColor = style.title.backgroundColor;
                    titleView.editable = NO;
                    titleView.selectable = NO;
                    titleView.scrollEnabled = YES;
                    titleView.textAlignment = style.title.textAlignment;
                    // because contentsize.height < frame.size.height
                    if (titleView.frame.size.height < titleView.contentSize.height) {
                        CGRect newF = titleView.frame;
                        newF.size.height = titleView.contentSize.height;
                        titleView.frame = newF;
                    }
                    titleView.scrollEnabled = NO;
                    [self addSubview:titleView];
                }
            }
            
            UITextView *contentView = [[UITextView alloc] initWithFrame:CGRectMake(0, titleHeight, style.alertView.width, maxUnstretchTitleHeight - titleHeight)];
            contentView.textContainerInset = messageInsets;
            contentView.text = self.message;
            contentView.font = style.content.font;
            contentView.textColor = style.content.textColor;
            contentView.backgroundColor = style.content.backgroundColor;
            contentView.editable = NO;
            contentView.selectable = NO;
            contentView.scrollEnabled = YES;
            contentView.textAlignment = style.content.textAlignment;
            [self addSubview:contentView];
            
            [self setupButton];
        }
    }
    
    self.layer.cornerRadius = style.alertView.cornerRadius;
    if (self.layer.cornerRadius > 0) {
        self.clipsToBounds = YES;
    }
    
    self.center = newSuperview.center;
    
    //重新布局
    [self layoutIfNeeded];
}

- (void)setupButton {
    JCAlertButtonsView *buttonsView = [[JCAlertButtonsView alloc] initWithButtonsArray:self.buttonItems style:self.style];
    [self addSubview:buttonsView];
    [buttonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(self.buttonHeight);
    }];
    __weak __typeof(self)weakSelf = self;
    buttonsView.ButtonClickAction = ^(JCAlertButtonItem *item) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(alertButtonClicked:)]) {
            [strongSelf.delegate alertButtonClicked:item.clicked];
        }
    };
}

- (void)notifyDelegateWithClicked:(void(^)(void))clicked {
    if ([self.delegate respondsToSelector:@selector(alertButtonClicked:)]) {
        [self.delegate alertButtonClicked:clicked];
    }
}

@end
