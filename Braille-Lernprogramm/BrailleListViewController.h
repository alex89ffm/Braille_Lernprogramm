//
//  BrailleListViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coloredButton.h"

@interface BrailleListViewController : UIViewController
{
    coloredButton *KSButton;
    coloredButton *VsButton;
}
-(void)showVsListViewController;
-(void)showKSListViewController;
@end
