//
//  Detail1.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/5/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Detail1.h"


@implementation Detail1

@synthesize myImageView;
@synthesize myTableView;
@synthesize myAlertView;

@synthesize text;
@synthesize textarray;

@synthesize text_p;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)init:(NSString *)myName NavTitle:(NSString *)myTitle{
	UIImageView *myImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:myName]];
	self.navigationItem.title = myTitle;
	
	myImageView2.frame = CGRectMake(100, 50, 120, 165);
	
	[self.view addSubview:myImageView2];
	[myImageView2 release];
	
	
//	myImageView.image = [UIImage imageNamed:myName];
//	self.navigationItem.title = myTitle;
	
	
	
	
	//text from file test 0719
	NSString *fPath = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"txt"];
	text = [[NSString alloc] initWithContentsOfFile:fPath
									usedEncoding:nil
									  error:nil];
	//textarray = [[NSArray alloc]init];
	
	//text from plist test 0720
	//NSString *fPath = [[NSBundle mainBundle] pathForResource:@"TestPT" ofType:@"plist"];
	//NSDictionary *temp = [NSDictionary dictionaryWithContentsOfFile:fPath];
	//text_p = [NSMutableArray arrayWithArray:[temp objectForKey:@"asdf"]];
	
	
	//textarray = [text componentsSeparatedByString:@"\t"];

	//NSLog(@"%@", [textarray objectAtIndex:0]);

	return self;
}
#pragma mark -
#pragma mark actionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	printf("Button %d\n", buttonIndex + 1);
	[actionSheet release];
}

- (void) presentSheet
{
	UIActionSheet *menu = [[UIActionSheet alloc]
						   initWithTitle:@"test menu"
						   delegate:self
						   cancelButtonTitle:@"Cancel"
						   destructiveButtonTitle:nil 
						   otherButtonTitles:@"Auto Localization", @"Manuel Localization", nil];
	[menu showInView:self.view];
	[menu release];
}

#pragma mark -
#pragma mark AlertView
- (void) presentAlertView
{
	myAlertView = [[UIAlertView alloc] initWithTitle:@"Search Test"
											 message:@"Plz Select the Distance"
											delegate:self
								   cancelButtonTitle:@"Cancel" 
								   otherButtonTitles:@"OK", nil];
	//[myAlertView initWithFrame:CGRectMake(0, 0, 200, 300)];
	
	//[myAlertView setNumberOfRows:5];
	
	
	
	//Slider 0727
	UISlider *alertSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 20, 60, 20)];
	alertSlider.backgroundColor = [UIColor clearColor];
	alertSlider.minimumValue = 0.0f;
	alertSlider.maximumValue = 100.0f;
	alertSlider.continuous = YES;
	alertSlider.value = 50.0f;
	[myAlertView addSubview:alertSlider];
	
	[alertSlider release];
	
	
	[myAlertView show];
}

//tableview 0716
#pragma mark -
#pragma mark Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Only one section.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// As many rows as there are obects in the events array.
    //return [eventsArray count];
	
	//textarray = [text componentsSeparatedByString:@"\t"];
	
	
	return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// A date formatter for the creation date.
/*
    static NSDateFormatter *dateFormatter = nil;
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	}
*/	
	NSLog(@"tableview");
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
	
	
	textarray = [text componentsSeparatedByString:@"\t"];

	//cell.textLabel.text = @"test";
	//if(indexPath.row == 0)
	{
		//NSLog(@"%d", indexPath.row);
		//cell.textLabel.text = self.navigationItem.title;
		//NSLog(@"%@", [textarray objectAtIndex:0]);
		cell.textLabel.text = (NSString *)[textarray objectAtIndex:indexPath.row];
		//cell.textLabel.text = text;
	}
    
	// Get the event corresponding to the current index path and configure the table view cell.
/*	Event *event = (Event *)[eventsArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [dateFormatter stringFromDate:[event creationDate]];
	cell.imageView.image = event.thumbnail;
*/    
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		NSLog(@"push the button 0");
		imgViewController *imgController = [[imgViewController alloc]init];
		[self presentModalViewController:imgController animated:TRUE];
		
	}/*else if(indexPath.row == 1){
		NSLog(@"push the button 1");
		//[self presentAlertView];
	}*/
}
#pragma mark -

/*
- (void)myinit:(NSString *)myName NavTitle:(NSString *)myTitle{
	//myImageView = nil;
	//myImageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:myName]]autorelease];
	myImageView = [UIImageView alloc];
	//myImageView.image = [UIImage imageNamed:myName];
	//UIImage *image = [[UIImage alloc]autorelease];
	//[image imageNamed: myName];
	[myImageView setImage: [UIImage imageNamed:myName]];
	self.navigationItem.title = myTitle;
	//myImageView = [UIImageView alloc];
	//return self;
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//myTableView.delegate = self;
	//[self.view addSubview:myTableView];
	
	
	//myImageView = [UIImageView alloc];
	//[myImageView initWithImage:[UIImage imageNamed:@"Hotel.png"]];
	//myImageView.frame = CGRectMake(0, 0, 320, 480);
	//[myImageView animationImages];

	//self.navigationItem.title = @"實景照片";
	
	
	//[self.view addSubview:myImageView];
	//[myImageView release];
	//[self.view]
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
	self.myImageView = nil;
}


- (void)dealloc {
    [super dealloc];
	[myImageView release];
	//[textarray release];
}


@end
