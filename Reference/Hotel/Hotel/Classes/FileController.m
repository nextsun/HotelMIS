//
//  FileController.m
//  Hotel
//
//  Created by danal on 5/12/11.
//  Copyright 2011 danal. All rights reserved.
//

#ifndef kOrderListFile
#define kOrderListFile @"orderList.plist"
#endif
#import "FileController.h"


@implementation FileController

+(NSString *)documentsPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}
+(NSString *)fullpathOfFilename:(NSString *)filename {
	NSString *documentsPath = [self documentsPath];
	return [documentsPath stringByAppendingPathComponent:filename];
}
+(void)saveOrderList:(NSDictionary *)list {
	NSString *f = [self fullpathOfFilename:kOrderListFile];
	[list writeToFile:f atomically:YES];
}
+(NSDictionary *)loadOrderList {
//	NSArray *list = [NSArray arrayWithContentsOfFile:[self fullpathOfFilename:kOrderListFile]];
	NSString *f = [self fullpathOfFilename:kOrderListFile];
	NSDictionary *list = [[[NSDictionary alloc] initWithContentsOfFile:f] autorelease];
	if(list == nil){	//omg! double =
		list = [NSDictionary dictionary];
	}
	//NSDictionary *oneRow = [NSDictionary dictionaryWithObject:@"listValue" forKey:@"listKey"];
	//list = [NSDictionary dictionaryWithObject:oneRow forKey:@"0"];
	return list;
}

+(NSUInteger)addOneToRow:(NSUInteger)row {
	NSNumber *rowNum = [NSNumber numberWithInt:row];
	NSUInteger count = 1;
	
	NSMutableDictionary *listDict = [[NSMutableDictionary alloc] initWithDictionary:[self loadOrderList]];	//[NSMutableDictionary dictionaryWithContentsOfFile:[self fullpathOfFilename:kOrderListFile]];
	if(listDict == nil) listDict = [NSMutableDictionary dictionary];

	NSDictionary *d = [listDict objectForKey:[NSString stringWithFormat:@"%d",row]];
	NSLog(@"d:%@",d);
	if(d == nil){
		count  = 1;
	}else {
		count = [[d valueForKey:@"count"] intValue] + 1;
	}
	NSLog(@"count:%d",count);

	NSNumber *countNum = [NSNumber numberWithInt:count];
	NSDictionary *newRow = [[NSDictionary alloc] initWithObjectsAndKeys:rowNum,@"row",countNum,@"count",nil];
	[listDict setObject:newRow forKey:[NSString stringWithFormat:@"%d",row]];
	[newRow release];
	
	[self saveOrderList:listDict];
	return count;
}
+(NSUInteger)deleteOneFomRow:(NSUInteger)row {
	NSNumber *rowNum = [NSNumber numberWithInt:row];
	NSUInteger count = 1;
	
	NSMutableDictionary *listDict = [NSMutableDictionary dictionaryWithContentsOfFile:[self fullpathOfFilename:kOrderListFile]];
	if(listDict == nil) listDict = [NSMutableDictionary dictionary];
	
	NSDictionary *d = [listDict objectForKey:[NSString stringWithFormat:@"%d",row]];
	if(d == nil){
		count = 0;
	}else{
		count = [[d valueForKey:@"count"] intValue];
		if(count == 1){
			[listDict removeObjectForKey:[NSString stringWithFormat:@"%d",row]];
			count --;
		}else {
			count --;
			NSLog(@"count:%d",count);	
			NSNumber *countNum = [NSNumber numberWithInt:count];
			NSDictionary *newRow = [[NSDictionary alloc] initWithObjectsAndKeys:rowNum,@"row",countNum,@"count",nil];
			[listDict setObject:newRow forKey:[NSString stringWithFormat:@"%d",row]];
			[newRow release];			
		}
		[self saveOrderList:listDict];
	}
	return count;	
}
+(NSDictionary *)readRow:(NSUInteger)row {
	NSString *key = [NSString stringWithFormat:@"%d",row];
	return [[self loadOrderList] valueForKey:key];
}
- (void)dealloc {
    [super dealloc];
}


@end
