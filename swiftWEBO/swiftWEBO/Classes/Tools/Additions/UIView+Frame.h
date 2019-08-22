//
//  UIView+frame.h
//  sc
//
//  Created by AVGD—JK on 16/5/30.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (Frame)

@property (nonatomic, assign) CGPoint sc_origin;
@property (nonatomic, assign) CGSize sc_size;

@property (nonatomic) CGFloat sc_centerX;
@property (nonatomic) CGFloat sc_centerY;

@property (nonatomic) CGFloat sc_top;
@property (nonatomic) CGFloat sc_bottom;
@property (nonatomic) CGFloat sc_right;
@property (nonatomic) CGFloat sc_left;

@property (nonatomic) CGFloat sc_width;
@property (nonatomic) CGFloat sc_height;

@end
