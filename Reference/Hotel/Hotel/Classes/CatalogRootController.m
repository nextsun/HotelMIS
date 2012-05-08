//
//  CatalogRootController.m
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//

#import "CatalogRootController.h"
#import "CatalogFirstController.h"

@implementation CatalogRootController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	CatalogFirstController *aController = [[CatalogFirstController alloc] initWithNibName:@"CatalogFirstController" bundle:nil];
	
	NSArray *viewControllers = [[NSArray alloc] initWithObjects:aController,nil];
	self.viewControllers =viewControllers;
	self.navigationBarHidden = YES;
	[aController release];
	[viewControllers release];
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
    [super dealloc];
}


@end
