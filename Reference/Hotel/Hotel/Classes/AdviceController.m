//
//  AdviceController.m
//  Hotel
//
//  Created by danal on 5/10/11.
//  Copyright 2011 danal. All rights reserved.
//


#import "AdviceController.h"
#import "HotelAppDelegate.h"
#import "DialogView.h"

static const float ROWHEIGHT = 60;

@implementation AdviceController
@synthesize name,textView,webView,seg;
@synthesize postBtn,doneBtn,advList;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(IBAction) segChanged:(id)sender {
	UISegmentedControl *theSeg = (UISegmentedControl *)sender;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:( theSeg.selectedSegmentIndex == 1? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	//[UIView setAnimationTransition:( theSeg.selectedSegmentIndex == 1? UIViewAnimationTransitionCurlUp : UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
	

	switch(theSeg.selectedSegmentIndex){
		case 0://writting
			doneBtn.enabled = YES;
			postBtn.enabled = YES;
			webView.hidden = YES;
			advTable.hidden = YES;
			name.hidden =	NO;
			textView.hidden = NO;
			textBg.hidden = NO;
			//webBg.hidden = YES;
			break;
		default://view
			doneBtn.enabled = NO;
			postBtn.enabled = NO;
//			webView.hidden = NO;
			advTable.hidden = NO;
			name.hidden = YES;
			textView.hidden = YES;
			textBg.hidden =	YES;
			//webBg.hidden = NO;
			NSError *error;
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
			NSString *content = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://bula.kilu.net/read.php"] encoding:NSUTF8StringEncoding error:&error];
			NSLog(@"%@",content);
			self.advList = [content componentsSeparatedByString:@"\r\n\r\n"];
			//self.advList = [NSArray arrayWithObjects:@"a",@"b",nil];
			[advTable reloadData];
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			//[webView loadHTMLString:content baseURL:[NSURL URLWithString:@"about:home"]];
			//[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bula.kilu.net/readMsg.php?id=admin"]]];

			break;
	}
	
	[UIView commitAnimations];
	//theSeg.selectedSegmentIndex = -1;
}

-(IBAction) post:(id)sender {
	if([self.name.text length]*[self.textView.text length] == 0){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill up all fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else {
		UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Will post your words to the server,Continue?!" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
		alert2.tag = 2;
		[alert2 show];
		[alert2 release];
	}
	
}

-(IBAction) done:(id)sender {
	[name resignFirstResponder];
	[textView resignFirstResponder];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	advTable.backgroundColor = [UIColor clearColor];
	advTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	NSLog(@"%d",[[self.view.layer sublayers] count]);
	webView.backgroundColor = [UIColor clearColor];
	//webView.layer.borderWidth = 5;
	//webView.layer.borderColor = [[UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:0.8] CGColor];
	webView.layer.cornerRadius = 8;
	
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
	
//	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//	
//	NSError *error;
//	NSURLResponse *response;
//	NSData *dataReply;
//	NSString *stringReply;
//	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: [NSString stringWithFormat:@"http://bula.kilu.net/readMsg.php?id=%@",@"admin"]]];
//	[request setHTTPMethod: @"GET"];
//	dataReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//	stringReply = [[NSString alloc] initWithData:dataReply encoding:NSUTF8StringEncoding];
//	
//	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//	
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


-(void) sendMsg {
	NSString *postMsg =[NSString stringWithFormat:@"user=%@&content=%@",self.name.text,self.textView.text];
	NSData *postData = [postMsg dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
	
//	NSError *error;
//	NSURLResponse *response;
//	NSData *reply;
//	NSString *strReply;
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://bula.kilu.net/post.php"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	//the following code won't call delegate methods
	//reply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	//this calls delegate methods
	[NSURLConnection connectionWithRequest:request delegate:self];
	
	/*
	NSString *postMessage = [NSString stringWithFormat:@"option=com_easybook&task=save&controller=entry&gbname=%@&gbmail=%@&gbmailshow=%d&gbloca=%@&gbvote=%d&gbtext=%@&send=Valider+Message",
							 [self urlEncodeValue:[mGBName text]],
							 [self urlEncodeValue:[mGBMail text]],
							 ([mGBMailShow state]?1:0),
							 [self urlEncodeValue:[mGBLoca text]],
							 (int)ceil([mGBVote value]),
							 [self urlEncodeValue:[mGBText text]]];
	
	NSData *postData = [postMessage dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:kGuestBookPostURL]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[NSURLConnection connectionWithRequest:request delegate:self];
	*/
}
- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(alertView.tag == 2){
		switch (buttonIndex) {
			case 0:
				[self sendMsg];
				break;
			default:
				NSLog(@"cancel");
				break;
		}
	}
}

#pragma mark NSURLConnection

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[connection cancel];
	[self done:nil];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your words has been sent out!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	[name setText:@""];
	[textView setText:@""];
	
	//[self.receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"2");
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	//[self.receivedData appendData:data];
	NSLog(@"3");
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"4");
	/*
	 NSString *string = [[NSString alloc] initWithBytes:[self.receivedData bytes] length:[self.receivedData length] encoding:NSUTF8StringEncoding];
	 [string release];
	 
	 */
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark -
- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma make -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return ROWHEIGHT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	return [advList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"CELL";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	
		NSString *text = [self.advList objectAtIndex:[indexPath row]];
		//text = [text stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br />"];
		if(![text isEqualToString:@""]){
				
			CGRect frame = cell.frame;
			frame.origin.x = 5;
			frame.origin.y = 5;
			frame.size.height = ROWHEIGHT - 5;
			frame.size.width -= 10;
			DialogView *diaView = [[DialogView alloc] initWithFrame:frame];
			diaView.direction = [indexPath row]%2;
			diaView.labelText = text;
			[cell addSubview:diaView];
			[diaView release];
		}
	}
//	cell.textLabel.text = @"cell";
	return cell;
}
@end
