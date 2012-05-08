//
//  CatalogSecondController.m
//  Hotel
//
//  Created by danal on 5/11/11.
//  Copyright 2011 danal. All rights reserved.
//

#import "CatalogSecondController.h"
#import "FileController.h"

@implementation CatalogSecondController
@synthesize theObj,managedObjects,rowIndex,currentRowIndex;
@synthesize nameLbl,priceLbl,typeLbl,imageView,introText,countLbl;
@synthesize lastLoction;

-(IBAction) orderOne:(id)sender {
	//NSUInteger row = self.rowIndex == self.currentRowIndex ?
	NSUInteger count = [FileController addOneToRow:self.currentRowIndex];
	[self updateCountLbl:count];
}
-(IBAction) deleteOne:(id)sender {
	NSUInteger count = [FileController deleteOneFomRow:self.currentRowIndex];
	[self updateCountLbl:count];
	
}
-(IBAction) back:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) updateCountLbl:(NSUInteger)count {
	self.countLbl.text = [NSString stringWithFormat:@"%d",count];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
-(void)viewWillAppear:(BOOL)animated {
	//NSLog(@"%@",managedObjects);
	
	//NSLog(@"%d",[managedObjects count]);
	
	//theObj = [managedObjects objectAtIndex:rowIndex];
		
	NSNumber *id = [theObj valueForKey:@"id"];

	NSString *imageName = [NSString stringWithFormat:@"%d.jpg",[id intValue]];
	self.imageView.image = [UIImage imageNamed:imageName];
	
	NSMutableString *title = [[NSMutableString alloc] init];
	[title appendString: [theObj valueForKey:@"name"]];
	[title appendString:@"  "];
	[title appendString:[theObj valueForKey:@"type"]];
	NSNumber *price = [theObj valueForKey:@"price"];
	[title appendString:[NSString stringWithFormat:@"￥%d",[price intValue]]];
	self.nameLbl.text = title;
	//	self.priceLbl.text
	self.introText.text = [theObj valueForKey:@"intro"];
	[title release];
	
	NSDictionary *theRow = [FileController readRow:rowIndex];
	NSNumber *countNum = [theRow valueForKey:@"count"];
	self.countLbl.text = [NSString stringWithFormat:@"%d",[countNum intValue]];
	
		[super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
//	[theObj release];
//	theObj = nil;
//	[managedObjects release];
//	managedObjects = nil;
	
	[super viewWillDisappear:animated];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.introText.font = [UIFont systemFontOfSize:14];
	currentRowIndex = rowIndex;
	
	[self.view viewWithTag:10].layer.cornerRadius = 3;
	[self.view viewWithTag:11].layer.cornerRadius = 3;
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameLbl release];
	[priceLbl release];
	[typeLbl release];
	[introText release];
	[imageView release];
	[countLbl release];
	[theObj release];
	[managedObjects release];
	
    [super dealloc];
}

#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//int count = [touches count];
	//NSLog(@"count=%d",count);
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
	self.lastLoction = location;
	moveChanged = NO;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint location = [[touches anyObject] locationInView:self.view];
	lastLoction = location;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self.view];
	if(!moveChanged && fabs(location.x - lastLoction.x) > 60 && fabs(location.y - lastLoction.y) < 25){
		moveChanged = YES;
		[UIView beginAnimations:nil context:imageView];
		[UIView setAnimationDuration:1.0];
		[UIView setAnimationTransition:( location.x - lastLoction.x > 0? UIViewAnimationTransitionCurlUp : UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
//		CGRect frame = self.view.frame;
//		viewFrame = self.view.frame;
//		self.view.frame = CGRectMake(0, 0, 0, viewFrame.size.height);
		//[imageView setAlpha:0.0];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(onAnimationStop:finished:context:)];
		[UIView commitAnimations];
		
		NSUInteger count = [self.managedObjects count];
		
		if(location.x - lastLoction.x >0){//right
			if(currentRowIndex < count-1){
				currentRowIndex = currentRowIndex +1;
			}
		}else{//left
			if(currentRowIndex > 0){
				currentRowIndex = currentRowIndex -1;
			}
		}
		
		self.theObj = [self.managedObjects objectAtIndex:currentRowIndex];
		NSNumber *id = [self.theObj valueForKey:@"id"];
		NSLog(@"%d",[id intValue]);
		NSLog(@"distance:%f",location.x - lastLoction.x);
		
		self.imageView.image =	[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",[id intValue]]];
		
		NSMutableString *title = [[NSMutableString alloc] init];
		[title appendString: [theObj valueForKey:@"name"]];
		[title appendString:@"  "];
		[title appendString:[theObj valueForKey:@"type"]];
		NSNumber *price = [theObj valueForKey:@"price"];
		[title appendString:[NSString stringWithFormat:@"￥%d",[price intValue]]];
		self.nameLbl.text = title;
		self.introText.text = [theObj valueForKey:@"intro"];		
		[title release];
		
		NSDictionary *theRow = [FileController readRow:currentRowIndex];
		NSUInteger orderCount = 0;
		if(theRow != nil){
			orderCount = [[theRow valueForKey:@"count"] intValue];
		}
		
		self.countLbl.text = [NSString stringWithFormat:@"%d",orderCount];
		
	//	[UIView beginAnimations:nil context:imageView];
//		[UIView setAnimationDuration:1.0];
//		[imageView setAlpha:1.0];
//		[UIView setAnimationDelegate:self];
//		[UIView setAnimationDidStopSelector:@selector(onAnimationStop:finished:context:)];
//		[UIView commitAnimations];

		lastLoction = location;
	}
    
}

-(void)onAnimationStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	//[imageView setAlpha:1.0];
	//self.view.frame = viewFrame;
}
@end
