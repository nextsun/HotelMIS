//
//  OrderController.m
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//
#define kRowHeight 60
#define kX 5
#define kY 5

#define kName 11
#define kPrice 12
#define kCount 13
#define kType 14
#define kImage 15
#define kMinusBtn 16
#define kPlusBtn 17

#import "OrderController.h"
#import "FileController.h"
#import "HotelAppDelegate.h"
#import "TableCellView.h"

@implementation OrderController
@synthesize table,list,orderDict,objectList;
@synthesize countTotal,totalCountLbl;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
-(IBAction)minusOne:(id)sender {
	UITableViewCell *theCell = (UITableViewCell *)[[sender superview] superview];
	int tag = [theCell tag];
	NSLog(@"superTag:%d",tag);
//	UIButton *btn = (UIButton *)sender;
//	NSLog(@"order pressed,tag:%d",btn.tag);
	NSUInteger row = tag -1;// btn.tag - 1;
	NSUInteger restCount = [FileController deleteOneFomRow:row];
	
	if(restCount ==0){
		NSUInteger rowIndex = theCell.contentView.tag -1;
		NSLog(@"%d",theCell.contentView.tag);
		self.orderDict = [NSMutableDictionary dictionaryWithDictionary:[FileController loadOrderList]];
		self.list = [NSMutableArray arrayWithArray:[self.orderDict allKeys]];
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];//[table indexPathForCell:theCell];	
		[self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];	
		[NSTimer scheduledTimerWithTimeInterval:0.5  target:self selector:@selector(updateTable) userInfo:nil repeats:NO];

	}else {
		[self updateTable];
	}
}
-(IBAction)plusOne:(id)sender {
	int tag = [[[sender superview] superview] tag];
	NSLog(@"superTag:%d",tag);
//	UIButton *btn = (UIButton *)sender;
//	NSLog(@"order pressed,tag:%d",btn.tag);
	NSUInteger row = tag -1;//btn.tag - 1;
	[FileController addOneToRow:row];
	[self updateTable];
}

-(void)updateTable {
	self.countTotal = 0;
	self.orderDict = [NSMutableDictionary dictionaryWithDictionary:[FileController loadOrderList]];
	self.list = [NSMutableArray arrayWithArray:[self.orderDict allKeys]];
	
	[self.table reloadData];
	if([self.list count] == 0){
		self.totalCountLbl.text =@"0.00";
	}
	//recaculate total price
	NSEnumerator *enumerator = [self.orderDict keyEnumerator];
	for(NSString *aKey in enumerator ) {
		NSLog(@"aKey:%@",aKey);
		NSDictionary *aRow = [self.orderDict objectForKey:aKey];
		
		NSManagedObject *aObj = [self.objectList objectAtIndex:[aKey intValue]];
		NSNumber *nCount = [aRow valueForKey:@"count"];
		NSNumber *nPrice = [aObj valueForKey:@"price"];
		
		self.countTotal += [nPrice intValue]*[nCount intValue];
		self.totalCountLbl.text = [NSString stringWithFormat:@"%d.00",self.countTotal];
		
	}
}

-(void)callBack {
	NSLog(@"Notification CallBack");
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	/*
	 * background image
	 */
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	UIImageView *backImage = [[UIImageView alloc] initWithFrame:frame];
	backImage.image = [UIImage imageNamed:@"2.jpg"];
	backImage.alpha = 0.3;
	backImage.contentMode = UIViewContentModeScaleAspectFill;
	
	[self.view addSubview:backImage];
	[self.view sendSubviewToBack:backImage];
	[backImage release];
	
	//Register a Notification
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(callBack) name:@"DisappearNotificationName" object:nil];
	
	
	[self.table setBackgroundColor:[UIColor clearColor]];
	
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
	//sort
	NSSortDescriptor *sortDescr = [[NSSortDescriptor alloc] initWithKey:@"typeid" ascending:YES];
	NSArray *arraySortDescr = [NSArray arrayWithObject:sortDescr];
	[request setSortDescriptors:arraySortDescr];
	
	NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];
	
	if(objects != nil){
		self.objectList = objects;
	}	
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
-(void)viewWillDisappear:(BOOL)animated {
	NSNotificationCenter *nc =  [NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"DisappearNotificationName" object:self userInfo:nil];
}
-(void)viewWillAppear:(BOOL)animated {
	self.countTotal = 0;
	self.orderDict = [NSMutableDictionary dictionaryWithDictionary:[FileController loadOrderList]];
	self.list = [NSMutableArray arrayWithArray:[self.orderDict allKeys]];

	[self.table reloadData];
	
	[self updateTable];
	[super viewWillAppear:animated];
}
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
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[table release];
	[totalCountLbl release];
	[list release];
	[orderDict release];
	[objectList release];

    [super dealloc];
}

#pragma mark Table view methods
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	NSString *rowKey = [self.list objectAtIndex:row];
	NSInteger tagInt = [rowKey intValue];
	
	
	NSDictionary *theRow =[self.orderDict objectForKey:rowKey];
	
	//NSLog(@"theRow:%@",theRow);
	//NSDictionary *obj = [self.objectList objectAtIndex:row];
	NSString *countText = [NSString stringWithFormat:@"%@",[theRow valueForKey:@"count"]];
	
	//cell.textLabel.text = rowKey;
	
	NSManagedObject *theObj = [self.objectList objectAtIndex:[rowKey intValue]];
	//NSString *name = [theObj valueForKey:@"name"];
	//cell.textLabel.text = name;
	NSNumber *id = [theObj valueForKey:@"id"]; 
	
	NSLog(@"index:%d,totalPrice:%d",[indexPath row],self.countTotal);
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	cell.backgroundView.alpha = 0.3;
	// cell.textLabel.text = [list objectAtIndex:[indexPath row]];
	
	UIColor *elemBgColor = [UIColor clearColor];
		
//	NSString *imageName = [NSString stringWithFormat:@"%d.jpg",[id intValue]];
	UIImageView *img = [[UIImageView alloc] init];//initWithImage:[UIImage imageNamed:imageName]];
	img.frame = CGRectMake(kX, kY, kRowHeight -10, kRowHeight -10);
	img.tag = kImage;
		img.backgroundColor = elemBgColor;
	[cell.contentView addSubview:img];
	[img release];
	
	UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(65, kY, 100, 25)];
	//nameLbl.text =  [theObj valueForKey:@"name"];//[list objectAtIndex:[indexPath row]];
	nameLbl.font = [UIFont systemFontOfSize:14];
	nameLbl.backgroundColor = [UIColor clearColor];
	nameLbl.tag = kName;
	[cell.contentView addSubview:nameLbl];
	[nameLbl release];
    
	UILabel *typeLbl = [[UILabel alloc] initWithFrame:CGRectMake(160, kY, 70, 25)];
//	typeLbl.text = [theObj valueForKey:@"type"];
	typeLbl.font = [UIFont systemFontOfSize:14];
	typeLbl.backgroundColor =[UIColor clearColor];
	typeLbl.tag	 = kType;
	[cell.contentView addSubview:typeLbl];
	[typeLbl release];
	
	UILabel *countLbl = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 100, 25)];
//	countLbl.text = [NSString stringWithFormat:@"数量：%@",countText];
	//countLbl.textColor = [UIColor grayColor];
	countLbl.font = [UIFont systemFontOfSize:14];
	countLbl.backgroundColor =[UIColor clearColor];
	countLbl.tag = kCount;
	[cell.contentView addSubview:countLbl];
	[countLbl release];
	
	UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(160, 30, 70, 25)];
	NSNumber *nPrice = [theObj valueForKey:@"price"];
//	self.countTotal += [nPrice intValue]*[countText intValue];
//	self.totalCountLbl.text = [NSString stringWithFormat:@"%d.00",self.countTotal];
	priceLbl.text = [NSString stringWithFormat:@"￥%d",[nPrice intValue]*[countText intValue]];
	priceLbl.font =[UIFont systemFontOfSize:14];
	priceLbl.backgroundColor = [UIColor clearColor];
	priceLbl.tag = kPrice;
	[cell.contentView addSubview:priceLbl];
	[priceLbl release];
		
	UIButton *deleteBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	deleteBtn.frame = CGRectMake(230, 5, 45, 20);
		deleteBtn.tag = kMinusBtn;//tagInt +1;	//when row is 0,tag would be nil
	[deleteBtn setTitle:@"-1" forState:UIControlStateNormal];
	[deleteBtn addTarget:self action:@selector(minusOne:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:deleteBtn];	
		
	UIButton *orderBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	orderBtn.frame = CGRectMake(230, 35, 45, 20);
	orderBtn.tag = kPlusBtn;//tagInt +1;	//when row is 0,tag would be nil
	[orderBtn setTitle:@"+1" forState:UIControlStateNormal];
	[orderBtn addTarget:self action:@selector(plusOne:) forControlEvents:UIControlEventTouchUpInside];
	[cell.contentView addSubview:orderBtn];	
	
		
    }
	NSArray *orderKeysArray = [self.orderDict allKeys];
//	NSLog(@"%@",orderKeysArray);
	NSUInteger indexOfOrder = [orderKeysArray indexOfObject:rowKey];
	
	TableCellView *cellView = [[TableCellView alloc] init];
	cellView._index = indexOfOrder;
	cellView._count = [orderKeysArray count];
	cell.backgroundView = cellView;
	[cellView release];
	
	//for speficifying the object
	cell.tag = tagInt+1;
	//for removing animation
	cell.contentView.tag = row+1;
	
	UILabel *nameLbl = (UILabel *)[cell.contentView viewWithTag:kName];
	nameLbl.text =  [theObj valueForKey:@"name"];
	
	UILabel *typeLbl = (UILabel *)[cell.contentView viewWithTag:kType];
	typeLbl.text = [theObj valueForKey:@"type"];
	
	UILabel *countLbl = (UILabel *)[cell.contentView viewWithTag:kCount];
	countLbl.text = [NSString stringWithFormat:@"数量：%@",countText];
	
	UILabel *priceLbl = (UILabel *)[cell.contentView viewWithTag:kPrice];
	NSNumber *nPrice = [theObj valueForKey:@"price"];
//	self.countTotal += [nPrice intValue]*[countText intValue];
//	self.totalCountLbl.text = [NSString stringWithFormat:@"%d.00",self.countTotal];
	priceLbl.text = [NSString stringWithFormat:@"￥%d",[nPrice intValue]*[countText intValue]];
	
	UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:kImage];
	NSString *imageName = [NSString stringWithFormat:@"%d.jpg",[id intValue]];
	img.image = [UIImage imageNamed:imageName];
	
	NSLog(@"do in cell");
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
