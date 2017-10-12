//
//  NSObject+AKGesture.m
//  AKIRPManage
//
//  Created by 李亚坤 on 2017/5/27.
//  Copyright © 2017年 李亚坤. All rights reserved.
//

#import "NSObject+AKGesture.h"

CGFloat lastScale = 1.f;

CGRect oldFrame;    //保存图片原来的大小

CGRect largeFrame;  //确定图片放大最大的程度

CGFloat MaxScal = 2.5;

CGFloat MinScal = 0.5;

CGFloat TotalScal = 1.0;

@implementation NSObject (AKGesture)

//添加所有手势
- (void)addAllGestureRecognizerInToView:(UIView *)view{
    
    
    oldFrame = view.frame;
    largeFrame = CGRectMake(0 - view.bounds.size.width, 0 - view.bounds.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
    
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
   
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}




// 添加缩放的手势
- (void)addGestureRecognizerInToView:(UIView *)view{
    
    oldFrame = view.frame;
    largeFrame = CGRectMake(0 - view.bounds.size.width, 0 - view.bounds.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height);
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    
    [view addGestureRecognizer:pinchGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
    
    UIView *view = rotationGestureRecognizer.view;
    
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    
//    CGFloat scal = pinchGestureRecognizer.scale;
//    if (scal > 1.0){
//        
//        if (TotalScal > MaxScal) return;
//    }
//    
//    if (scal < 1.0){
//        
//        if (TotalScal < MinScal) return;
//    }
//    
    UIView *view = pinchGestureRecognizer.view;
    
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
//        TotalScal *= scal;
        pinchGestureRecognizer.scale = 1.0;
        
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    UIView *view = panGestureRecognizer.view;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}


@end
