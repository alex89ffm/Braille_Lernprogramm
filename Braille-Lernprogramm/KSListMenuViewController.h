//
//  KSListMenuViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coloredButton.h"

@interface KSListMenuViewController : UIViewController
{
    coloredButton *lautgruppeButton;
    coloredButton *einformigeButton;
    coloredButton *zweiformigeButton;
    coloredButton *KommaBUtton;
    coloredButton *vorsilbeButton;
    coloredButton *nachsilbeButton;
}
-(void)showKsViewController:(UIButton*)theButton;
@end
