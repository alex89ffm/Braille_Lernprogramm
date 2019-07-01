//
//  KurzschriftCharacter.h
//  Braille-Lernprogramm
//
//  Created by Alexander Eiselt on 08.05.13.
//  Copyright (c) 2013 Alexander Eiselt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrailleCharacter.h"

@interface KurzschriftCharacter : UIView
{
    
}
@property int firstID;
@property int secondID;
@property(nonatomic, retain)NSString *Name;
@property(nonatomic, retain)UIView *theSuperView;
@end
