//
//  AdviceController.h
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AdviceController : UIViewController <UIWebViewDelegate>{
	IBOutlet UITextField *name;
	IBOutlet UITextView *textView;
	IBOutlet UIWebView *webView;
	IBOutlet UILabel *webBg;
	IBOutlet UITextField *textBg;
	IBOutlet UISegmentedControl *seg;
	IBOutlet UIBarButtonItem *postBtn;
	IBOutlet UIBarButtonItem *doneBtn;
	IBOutlet UITableView *advTable;
	NSArray *advList;
}
@property(retain,nonatomic) IBOutlet UITextField *name;
@property(retain,nonatomic) IBOutlet UITextView *textView;
@property(retain,nonatomic) IBOutlet UIWebView *webView;
@property(retain,nonatomic) IBOutlet UISegmentedControl *seg;
@property(retain,nonatomic) IBOutlet UIBarButtonItem *postBtn;
@property(retain,nonatomic) IBOutlet UIBarButtonItem *doneBtn;
@property(retain,nonatomic) NSArray *advList;

-(IBAction) post:(id)sender;
-(IBAction) done:(id)sender;
-(IBAction) segChanged:(id)sender;

@end
