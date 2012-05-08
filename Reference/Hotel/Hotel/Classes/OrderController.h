//
//  OrderController.h
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrderController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
	IBOutlet UITableView *table;
	IBOutlet UILabel *totalCountLbl;
	NSMutableDictionary *orderDict;
	NSMutableArray *list;
	NSArray *objectList;
	NSUInteger countTotal;
	int lastTagInt;
}
@property(retain,nonatomic) IBOutlet UITableView *table;
@property(retain,nonatomic) IBOutlet UILabel *totalCountLbl;
@property(retain,nonatomic) NSMutableArray *list;
@property(retain,nonatomic) NSMutableDictionary *orderDict;
@property(retain,nonatomic) NSArray *objectList;
@property(nonatomic) NSUInteger countTotal;

-(IBAction)minusOne:(id)sender;
-(IBAction)plusOne:(id)sender;
-(void)updateTable;
-(void)callBack;

@end
