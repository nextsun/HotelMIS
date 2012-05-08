//
//  CatalogSecondController.h
//  Hotel
//
//  Created by danal on 5/11/11.
//  Copyright 2011 danal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelAppDelegate.h"

@interface CatalogSecondController : UIViewController {
	IBOutlet NSManagedObject *theObj;
	IBOutlet NSArray *managedObjects;
	IBOutlet NSUInteger rowIndex;
	
	IBOutlet UILabel *nameLbl;
	IBOutlet UILabel *priceLbl;
	IBOutlet UILabel *typeLbl;
	IBOutlet UIImageView *imageView;
	IBOutlet UITextView *introText;
	IBOutlet UILabel *countLbl;
	CGPoint lastLoction;
	CGRect viewFrame;
	NSUInteger currentRowIndex;
	BOOL moveChanged;

}

@property(retain,nonatomic) IBOutlet NSManagedObject *theObj;
@property(retain,nonatomic) IBOutlet NSArray *managedObjects;
@property(retain,nonatomic) IBOutlet UILabel *nameLbl;
@property(retain,nonatomic) IBOutlet UILabel *typeLbl;
@property(retain,nonatomic) IBOutlet UILabel *priceLbl;
@property(retain,nonatomic) IBOutlet UIImageView *imageView;
@property(retain,nonatomic) IBOutlet UITextView *introText;
@property(retain,nonatomic) IBOutlet UILabel *countLbl;
@property(nonatomic) CGPoint lastLoction;
@property(nonatomic) NSUInteger rowIndex;
@property(nonatomic) NSUInteger currentRowIndex;

-(IBAction) orderOne:(id)sender;
-(IBAction) deleteOne:(id)sender;
-(IBAction) back:(id)sender;
-(void) updateCountLbl:(NSUInteger)count;
@end
