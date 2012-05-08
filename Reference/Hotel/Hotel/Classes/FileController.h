//
//  FileController.h
//  Hotel
//
//  Created by danal on 5/12/11.
//  Copyright 2011 danal. All rights reserved.
//

#define kOrderListFile @"orderList.plist"
#import <UIKit/UIKit.h>


@interface FileController : NSObject {

}

+(NSString *)documentsPath;
+(NSString *)fullpathOfFilename:(NSString *)filename;
+(void)saveOrderList:(NSDictionary *)list;
+(NSDictionary *)loadOrderList;
+(NSUInteger)addOneToRow:(NSUInteger)row;
+(NSUInteger)deleteOneFomRow:(NSUInteger)row;
+(NSDictionary *)readRow:(NSUInteger)row;

@end
