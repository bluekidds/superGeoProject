//
//  mapLinesViewController.m
//  mapLines
//
//  Created by Craig on 4/12/09.
//  Copyright Craig Spitzkoff 2009. All rights reserved.
//

#import "ARThirdViewController.h"


@implementation ARThirdViewController

- (void)viewDidLoad 
{
	UIBarButtonItem *tempbutton = [[UIBarButtonItem alloc] init];
	tempbutton.title = @"TEST";
	self.navigationItem.rightBarButtonItem = tempbutton;
	
	[tempbutton release];
	
    [super viewDidLoad];
	
}


- (void)viewDidUnload {
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {	
    
	[super dealloc];
	
}



@end
