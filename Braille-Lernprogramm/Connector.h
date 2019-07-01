//
//  Connector.h
//  simpleRPG
//
//  Created by edv on 29.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "KurzschriftCharacter.h"
@class BrailleCharacter;
@interface Connector : NSObject
{
    sqlite3 *contactdb;
}
//statische Varialbe des Objektes
+(Connector *)shared;
//gibt den Pfad der lokalen Datenbank wieder
+(NSString*)filePath;
-(BrailleCharacter*)getCharacterwithName:(NSString*)name andFrame:(CGRect)Frame reading:(BOOL)reading;
-(BrailleCharacter*)getCharacterwithID:(int)theID andFrame:(CGRect)Frame  reading:(BOOL)reading;
-(BrailleCharacter*)getrandomcharacterwithframe:(CGRect)Frame reading:(BOOL)reading;
-(KurzschriftCharacter*)GetRandomKuerzungWithType:(int)thetype;
-(KurzschriftCharacter*)GetKuerzungAtRow:(int)row WithType:(int)thetype;
-(NSString*)getCharacterwithBrailleCharacter:(BrailleCharacter*)theCharacter;
-(int)getIDfromBrailleCHaracter:(BrailleCharacter*)theCharacter;
-(NSString*)getkuerzungwithID1:(int)id1 andID2:(int)id2 andType:(int)type;
-(NSString*)getTypeWithID:(int)ID;
-(int)getCountFortype:(int)type;
-(void)copyDatabaseIfNeeded;
-(void)execute:(NSString*) SQL;
-(NSString*)SpacedStringWithString:(NSString*)string;
@property(nonatomic) sqlite3 *database;
@end
