//
//  MainMenuViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coloredButton.h"

@interface MainMenuViewController : UIViewController
{
    coloredButton *VSButton;
    coloredButton *KSButton;
    coloredButton *ListButton;
}
-(void)showKSViewController;
-(void)showVSViewController;
-(void)showListViewController;

@end
