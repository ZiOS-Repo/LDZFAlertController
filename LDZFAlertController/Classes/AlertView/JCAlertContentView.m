//
//  JCAlertContentView.m
//  LDZFAlertController
//
//  Created by zhuyuhui on 2022/6/15.
//

#import "JCAlertContentView.h"

@implementation JCAlertContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentInset = UIEdgeInsetsMake(28, 15, 28, 15);
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark -
- (CGFloat)calculateContentViewHWithAlertViewWidth:(CGFloat)alertViewWidth {
    CGFloat h = self.frame.size.height;
    return h + self.contentInset.top + self.contentInset.bottom;
}
@end
