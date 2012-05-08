//
//  CatalogFirstController.h
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CatalogFirstController : UIViewController 
<UITableViewDataSource,UITableViewDelegate>{
	IBOutlet UITableView *table;
	NSArray *list;
	NSArray *typeList;
	NSMutableDictionary *sectionDict;
	NSDictionary *orderList;
	NSInteger cellTagInt;
}
@property(retain,nonatomic) NSArray *list;
@property(retain,nonatomic) NSDictionary *orderList;
@property(retain,nonatomic) NSArray *typeList;
@property(retain,nonatomic) IBOutlet UITableView *table;
@property(retain,nonatomic) NSMutableDictionary *sectionDict;
-(IBAction) add:(id)sender;
-(IBAction) order:(id)sender;

@end
