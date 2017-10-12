//
//  NSObject+AKGesture.h
//  AKIRPManage
//
//  Created by 李亚坤 on 2017/5/27.
//  Copyright © 2017年 李亚坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (AKGesture)

/**
 * 添加缩放与旋转手势手势
 */
- (void)addGestureRecognizerInToView:(UIView *)view;


/**
 * 添加所有手势
 */

- (void)addAllGestureRecognizerInToView:(UIView *)view;

@end
