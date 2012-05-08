//
//  AddController.h
//  Hotel
//
//  Created by danal on 5/11/11.
//  Copyright 2011 danal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddController : UIViewController {
	IBOutlet UITextField *name;
	IBOutlet UITextField *price;
	IBOutlet UITextField *type;
	IBOutlet UITextField *image;
	IBOutlet UITextView *intro;
}
@property(retain,nonatomic) IBOutlet UITextField *name;
@property(retain,nonatomic) IBOutlet UITextField *price;
@property(retain,nonatomic) IBOutlet UITextField *type;
@property(retain,nonatomic) IBOutlet UITextField *image;
@property(retain,nonatomic) IBOutlet UITextView *intro;

-(IBAction) back:(id)sender;
-(IBAction) add:(id)sender;
-(IBAction) closeKeyboard:(id)sender;
-(IBAction) clearFields;
-(IBAction) addOneType:(id) sender;
@end
