//
//  imgViewController.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/9/2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "imgViewController.h"


@implementation imgViewController
@synthesize back;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	UIImage *img = [UIImage imageNamed:@"routing2.png"];
	UIImageView *imgView = [[[UIImageView alloc] initWithImage:img]autorelease ];
	[self.view addSubview:imgView];
	
	
	
	//[back addTarget:self action:@selector(buttonBack:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:back];
}

-(IBAction) buttonBack:(id)sender
{
	
	[self dismissModalViewControllerAnimated:YES];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[back release];
    [super dealloc];
}


@end
