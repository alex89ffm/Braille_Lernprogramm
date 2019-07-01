//
//  KSListViewController.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 09.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrailleCharacter.h"
#import "KurzschriftCharacter.h"
#import "coloredButton.h"

@interface KSListViewController : UIViewController
{
    BrailleCharacter *character1;
    BrailleCharacter *character2;
    KurzschriftCharacter *ksCharacter;
    UILabel *SSLabel;
    coloredButton *prevButton;
    coloredButton *nextButton;
    int actualrow;
    int theType;
    int max;
}
-(id)initWithType:(int)type;
-(void)getPrev;
-(void)getNext;
@end
