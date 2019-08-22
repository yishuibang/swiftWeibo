//
//  UIView+frame.m
//  sc
//
//  Created by AVGD—JK on 16/5/30.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)sc_top
{
    return self.frame.origin.y;
}

- (void)setSc_top:(CGFloat)sc_top
{
    CGRect frame = self.frame;
    frame.origin.y = sc_top;
    self.frame = frame;
}

- (CGFloat)sc_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSc_right:(CGFloat)sc_right
{
    CGRect frame = self.frame;
    frame.origin.x = sc_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)sc_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSc_bottom:(CGFloat)sc_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = sc_bottom - self.frame.size.height;
    self.frame = frame;
}


- (CGFloat)sc_left
{
    return self.frame.origin.x;
}

- (void)setSc_left:(CGFloat)sc_left
{
    CGRect frame = self.frame;
    frame.origin.x = sc_left;
    self.frame = frame;
}

- (CGFloat)sc_width
{
    return self.frame.size.width;
}

- (void)setSc_width:(CGFloat)sc_width
{
    CGRect frame = self.frame;
    frame.size.width = sc_width;
    self.frame = frame;
}

- (CGFloat)sc_height
{
    return self.frame.size.height;
}

- (void)setSc_height:(CGFloat)sc_height
{
    CGRect frame = self.frame;
    frame.size.height = sc_height;
    self.frame = frame;
}

- (CGPoint)sc_origin {
    return self.frame.origin;
}

- (void)setSc_origin:(CGPoint)sc_origin
{
    CGRect frame = self.frame;
    frame.origin = sc_origin;
    self.frame = frame;
}

- (CGSize)sc_size {
    return self.frame.size;
}

- (void)setSc_size:(CGSize)sc_size
{
    CGRect frame = self.frame;
    frame.size = sc_size;
    self.frame = frame;
}

- (CGFloat)sc_centerX {
    return self.center.x;
}

- (void)setSc_centerX:(CGFloat)sc_centerX
{
    self.center = CGPointMake(sc_centerX, self.center.y);
}

- (CGFloat)sc_centerY {
    return self.center.y;
}

- (void)setSc_centerY:(CGFloat)sc_centerY
{
    self.center = CGPointMake(self.center.x, sc_centerY);
}


@end
