//
//  LeftViewController.m
//  ViewTest
//
//  Created by Sun on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor=[UIColor redColor];
    //self.view.frame=CGRectMake(100, 100, 500, 800);
    self.tableView.backgroundColor=[UIColor clearColor];
    
       
    
    
        
    NSLog(@"viewDidLoad:Center:%@",NSStringFromCGPoint(self.view.center));
    NSLog(@"viewDidLoad:Center:%@",NSStringFromCGRect(self.view.bounds));
    NSLog(@"viewDidLoad:Center:%@",NSStringFromCGRect(self.view.frame));  
}


-(void)viewWillAppear:(BOOL)animated
{
    
   
    //self.view.center=CGPointMake(200,50);
   
        
   // [UIView animateWithDuration:3
                   //  animations:^{
                         
                         
                       //  self.view.transform=CGAffineTransformMakeScale(0.1, 0.1);
//                         =CGAffineTransformRotate(CGAffineTransformMakeTranslation( 50, 50), M_PI/6);
//
//                          
   //                  } ];
 //   [UIView commitAnimations];


    NSLog(@"viewWillAppear:Center:%@",NSStringFromCGPoint(self.view.center));
    NSLog(@"viewWillAppear:Center:%@",NSStringFromCGRect(self.view.bounds));
    NSLog(@"viewWillAppear:Center:%@",NSStringFromCGRect(self.view.frame)); 
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AA"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AA"];
    }
    cell.textLabel.text=@"AAA";
    
    
    return cell;
}


@end
