//
//  CatalogFirstController.m
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//

#import "CatalogFirstController.h"
#import "AddController.h"
#import "HotelAppDelegate.h"
#import "CatalogSecondController.h"
#import "FileController.h"
#import "TableCellView.h"

#define	kRowHeight 60
#define kX 5
#define kY 5

#define kName 11
#define kPrice 12
#define kIntro 13
#define kType 14
#define kImage 15
#define kMinusBtn 16
#define kPlusBtn 17


@implementation CatalogFirstController
@synthesize list,orderList,sectionDict;
@synthesize table;
@synthesize typeList;

-(IBAction) add:(id)sender {
	AddController *addC = [[AddController alloc] initWithNibName:@"AddController" bundle:nil];
	[self.navigationController pushViewController:addC animated:YES];
	//self.navigationController.navigationBarHidden = NO;
	[addC release];
}
-(IBAction) order:(id)sender {	
	int tag = [[[sender superview] superview] tag];
//	UIButton *btn = (UIButton *)sender;
//	NSLog(@"order pressed,tag:%d",btn.tag);
	NSUInteger row = tag - 1; //btn.tag - 1;
	NSLog(@"row:%d",row);
	[FileController addOneToRow:row];

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
-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//[self.table reloadData];
}
*/
-(void) viewWillDisappear:(BOOL)animated {
	//[FileController saveOrderList:self.orderList];
	[super viewWillDisappear:animated];
	//[self.table reloadData];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	cellTagInt = 0;
	
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	UIImageView *backImage = [[UIImageView alloc] initWithFrame:frame];
	backImage.image = [UIImage imageNamed:@"2.jpg"];
	backImage.alpha = 0.3;
	backImage.contentMode = UIViewContentModeScaleAspectFill;

	[self.view addSubview:backImage];
	[self.view sendSubviewToBack:backImage];
	[backImage release];
	
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
	
	NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"typeid" ascending:YES];
	NSArray *arraySortDescriptor = [[NSArray alloc] initWithObjects:nameDescriptor, nil];
	[request setSortDescriptors:arraySortDescriptor];
	[arraySortDescriptor release];
	
	NSError *error;
//	NSManagedObject *aDish = nil;
//	NSNumber *id = [NSNumber numberWithInt:1];
	NSArray *objects = [context executeFetchRequest:request error:&error];
	
	if(objects != nil){
		self.list = objects;
	}	
	//[request release];
	
	[self.table setBackgroundColor:[UIColor clearColor]];
	
	entityDescr = [NSEntityDescription entityForName:@"Type" inManagedObjectContext:context];
	[request setEntity:entityDescr];
	nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
	NSArray *sortDescrArray = [NSArray arrayWithObjects:nameDescriptor,nil];
	[request setSortDescriptors:sortDescrArray];
	
	NSArray *typeObjects = [context executeFetchRequest:request error:&error];
	//type list
	self.typeList = typeObjects;//[NSArray arrayWithObjects:@"A",@"B",nil]; 
	NSAutoreleasePool *pool	 = [[NSAutoreleasePool alloc] init];
	//section index
	self.sectionDict = [NSMutableDictionary dictionary];
	for (int i = 0; i< [self.typeList count]; i++){
		NSManagedObject *aManagedObj = [self.typeList objectAtIndex:i];
		NSString *aKey = [aManagedObj valueForKey:@"id"];
		NSMutableArray *tObjects = [NSMutableArray array];		
		//NSMutableDictionary *sectionObjects = [NSMutableDictionary dictionaryWithObjectsAndKeys:tObjects,aKey,nil];
		[sectionDict setObject:tObjects forKey:aKey];
	}

	
	//section data
	for (int i =0; i < [self.list count]; i++) {
		NSManagedObject *aObj = [self.list objectAtIndex:i];
		NSString *typeid = [aObj valueForKey:@"typeid"];
		NSMutableArray *theKeyArray = [sectionDict objectForKey:typeid];
		[theKeyArray addObject:aObj];
		[sectionDict setObject:theKeyArray forKey:typeid];
	}
	
//	NSLog(@"sectionDict:%@",sectionDict);
	[pool release];
	[request release];
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
	[table release];
	[list release];
	[orderList release];
    [super dealloc];
}

#pragma mark Table view methods
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	return [self.typeList count];
	return 1;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//	return [self.typeList objectAtIndex:section];
//}

// it's hard to set a suitable tag to a cell with sections
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 25.0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSManagedObject *theTypeObj = [self.typeList objectAtIndex:section];
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 50)] autorelease];
	label.text = [NSString stringWithFormat:@"%@",[theTypeObj valueForKey:@"value"]];
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor clearColor];
	return label;
}
*/
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	NSManagedObject *theTypeObj = [self.typeList objectAtIndex:section];
//	NSInteger tid = [[theTypeObj valueForKey:@"id"] intValue];
//	int num = 0;
//	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//	for (int i=0; i<[self.list count];i++) {
//		NSManagedObject *aObj = [self.list objectAtIndex:i];
//		NSInteger typeid = [[aObj valueForKey:@"typeid"] intValue];
//		if(typeid == tid){
//			num++;
//		}
//	}
//	[pool release];
//    return num;
	return	[self.list count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger row = [indexPath row];
	NSManagedObject *theObj = [self.list objectAtIndex:row];
	
//	NSManagedObject *aManagedObj = [self.typeList objectAtIndex:[indexPath section]];
//	NSString *aKey = [aManagedObj valueForKey:@"id"];	
//	NSMutableArray *theObjList = [self.sectionDict objectForKey:aKey];	
//	NSManagedObject *theObj = [theObjList objectAtIndex:row];
	
	NSNumber *id = [theObj valueForKey:@"id"];
	NSInteger typeid = [[theObj valueForKey:@"typeid"] intValue];
	NSLog(@"tpyeid:%d",typeid);
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	//cell.selectionStyle	= UITableViewCellSelectionStyleNone;
	
//	cell.backgroundColor = [UIColor whiteColor];
		UIColor *elemBgColor = [UIColor clearColor];
		
	//NSString *imageName = [NSString stringWithFormat:@"%d.jpg",[id intValue]];
	UIImageView *img = [[UIImageView alloc] init];
	img.frame = CGRectMake(kX, kY, kRowHeight -10, kRowHeight -10);
	img.tag = kImage;
	[cell.contentView addSubview:img];
	[img release];
	
	UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 100, 25)];
//	nameLbl.text =  [theObj valueForKey:@"name"];//[list objectAtIndex:[indexPath row]];
	nameLbl.font = [UIFont systemFontOfSize:14];
	nameLbl.tag = kName;
		nameLbl.backgroundColor = elemBgColor;
	[cell.contentView addSubview:nameLbl];
	[nameLbl release];
    
	UILabel *typeLbl = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 70, 25)];
//	typeLbl.text = [theObj valueForKey:@"type"];
	typeLbl.font = [UIFont systemFontOfSize:14];
	typeLbl.tag = kType;
		typeLbl.backgroundColor = elemBgColor;
	[cell.contentView addSubview:typeLbl];
	[typeLbl release];
	
	UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 50, 25)];
//	NSNumber *nPrice = [theObj valueForKey:@"price"];
//	priceLbl.text = [NSString stringWithFormat:@"￥%d",[nPrice intValue]];
	priceLbl.font =[UIFont systemFontOfSize:14];
	priceLbl.tag = kPrice;
		priceLbl.backgroundColor = elemBgColor;
	[cell.contentView addSubview:priceLbl];
	[priceLbl release];
	
	UILabel *introLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 160, 30)];
//	NSString *introText = [theObj valueForKey:@"intro"];
//	if([introText length] > 70){
//		introText = [introText substringToIndex:70];
//		introText = [introText stringByAppendingString:@"..."];
//	}
//	introLbl.text = introText;//[theObj valueForKey:@"intro"];	
	introLbl.tag = kIntro;
		introLbl.backgroundColor = elemBgColor;
	introLbl.numberOfLines = 2;
	introLbl.textColor = [UIColor grayColor];
	introLbl.font = [UIFont systemFontOfSize:12];
	[cell.contentView addSubview:introLbl];
	[introLbl release];
	
	UILabel *btnBgLbl = [[UILabel alloc] initWithFrame:CGRectMake(230, 25, 60, 30)];
		btnBgLbl.backgroundColor = elemBgColor;
	[cell.contentView addSubview:btnBgLbl];
	[btnBgLbl release];
		
	UIButton *orderBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	orderBtn.frame = CGRectMake(230, 32, 60, 20);
//	orderBtn.tag = [indexPath row]+1;	//when row is 0,tag would be nil
	[orderBtn setTitle:@"order" forState:UIControlStateNormal];
	[orderBtn addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
	
	[cell.contentView addSubview:orderBtn];
		
    }
	cell.tag = 1 + [indexPath row];
	
	TableCellView *cellView = [[TableCellView alloc] init];
	cellView._count = [self.list count];
	cellView._index = [indexPath row];
	cell.backgroundView = cellView;
	[cellView release];
	
	
	NSString *imageName = [NSString stringWithFormat:@"%d.jpg",[id intValue]];
	UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:kImage];
	img.image = [UIImage imageNamed:imageName];
	
	UILabel *nameLbl = (UILabel *)[cell.contentView viewWithTag:kName];
	nameLbl.text =  [theObj valueForKey:@"name"];//[list objectAtIndex:[indexPath row]];
	
	UILabel *typeLbl = (UILabel *)[cell.contentView viewWithTag:kType];
	typeLbl.text = [theObj valueForKey:@"type"];
	
	UILabel *priceLbl = (UILabel *)[cell.contentView viewWithTag:kPrice];
	NSNumber *nPrice = [theObj valueForKey:@"price"];
	priceLbl.text = [NSString stringWithFormat:@"￥%d",[nPrice intValue]];
	
	UILabel *introLbl = (UILabel *)[cell.contentView viewWithTag:kIntro];
	NSString *introText = [theObj valueForKey:@"intro"];
	if([introText length] > 70){
		introText = [introText substringToIndex:70];
		introText = [introText stringByAppendingString:@"..."];
	}
	introLbl.text = introText;

	
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	CatalogSecondController *secondController = [[CatalogSecondController alloc] initWithNibName:@"CatalogSecondController" bundle:nil];
	
	secondController.theObj = [self.list objectAtIndex:[indexPath row]];
	secondController.managedObjects = self.list;
	secondController.rowIndex = [indexPath row];
	
	[self.navigationController pushViewController:secondController animated:YES];
	[secondController release];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


@end
