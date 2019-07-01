//
//  VSListViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrailleCharacter.h"
#import "coloredButton.h"

@interface VSListViewController : UIViewController
{
    BrailleCharacter *theCharacter;
    UILabel *SSLabel;
    coloredButton *prevButton;
    coloredButton *nextButton;
    int actualrow;
    int max;
}
-(void)getNextCharacter;
-(void)getPreviousCharacter;
@end
