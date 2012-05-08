//
//  AddController.m
//  Hotel
//
//  Created by danal on 5/11/11.
//  Copyright 2011 danal. All rights reserved.
//
#import "AddController.h"
#import "HotelAppDelegate.h"

@implementation AddController
@synthesize name;
@synthesize price;
@synthesize type;
@synthesize image;
@synthesize intro;

-(IBAction) addOneType:(id)sender {
	if([type.text length] > 0){
	
		HotelAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		//connection
		NSManagedObjectContext *context = [appDelegate managedObjectContext];
		//table 
		NSEntityDescription *entityDescr =[NSEntityDescription entityForName:@"Type" inManagedObjectContext:context];
		//query
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entityDescr];
		//pred
		//NSPredicate *pred = [NSPredicate predicateWithString:@"id=1"];
		
		NSError *error;
		NSManagedObject *aType = nil;
		NSNumber *id = [NSNumber numberWithInt:1];
		NSArray *objects = [context executeFetchRequest:request error:&error];
		if(objects != nil){
			aType = [objects lastObject];
			id = [aType valueForKey:@"id"];
			id = [NSNumber numberWithInt:[id intValue]+1];
			
		}
		
		aType = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:context];
		[aType setValue:id forKey:@"id"];
		[aType setValue:type.text forKey:@"value"];

		[request release];
		[context save:&error];
	
	}
}
-(IBAction) back:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) add:(id)sender {
	if([name.text length]*[price.text length]*[type.text length]*[image.text length]*[intro.text length] == 0){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"All fields needed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else{
		
		HotelAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
		//connection
		NSManagedObjectContext *context = [appDelegate managedObjectContext];
		//table 
		NSEntityDescription *entityDescr =[NSEntityDescription entityForName:@"Dishes" inManagedObjectContext:context];
		//query
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:entityDescr];
		//pred
		//NSPredicate *pred = [NSPredicate predicateWithString:@"id=1"];
		
		NSError *error;
		NSManagedObject *aDish = nil;
		NSNumber *id = [NSNumber numberWithInt:1];
		NSArray *objects = [context executeFetchRequest:request error:&error];
		if(objects != nil){
			aDish = [objects lastObject];
			id = [aDish valueForKey:@"id"];
			id = [NSNumber numberWithInt:[id intValue]+1];

		}
		
		aDish = [NSEntityDescription insertNewObjectForEntityForName:@"Dishes" inManagedObjectContext:context];
		[aDish setValue:id forKey:@"id"];
		[aDish setValue:name.text forKey:@"name"];
		[aDish setValue:[NSNumber numberWithInt:[price.text intValue]] forKey:@"price"];
		[aDish setValue:type.text forKey:@"type"];
		[aDish setValue:image.text forKey:@"image"];
		[aDish setValue:intro.text forKey:@"intro"];
		[request release];
		[context save:&error];
		[self clearFields];
	}
}

-(IBAction) closeKeyboard:(id)sender {
	NSLog(@"sender");
	[intro resignFirstResponder];
	[name resignFirstResponder];
	[type resignFirstResponder];
	[price resignFirstResponder];
	[image resignFirstResponder];
//	[sender resignFirstResponder];
}

-(IBAction) clearFields {
	name.text = @"";
	type.text = @"";
	price.text = @"";
	image.text = @"";
	intro.text = @"";
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	[name release];
	[price release];
	[type release];
	[image release];
	[intro release];
    [super dealloc];
}


@end
