//
//  AppDelegate.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainMenuViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) MainMenuViewController *viewController;
@end
