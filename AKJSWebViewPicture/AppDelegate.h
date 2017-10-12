//
//  AppDelegate.h
//  AKJSWebViewPicture
//
//  Created by 李亚坤 on 2017/10/12.
//  Copyright © 2017年 TFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

