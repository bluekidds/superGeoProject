//
//  ARFirstViewController.m
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/4/9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ARFirstViewController.h"
#import <math.h>
#define showAlert(format, ...) myShowAlert(__LINE__, (char *)__FUNCTION__, format, ##__VA_ARGS__)
#define IMAGEPICKERSOURCE UIImagePickerControllerSourceTypeCamera
const double pii = 3.14159265;
const double range = 60.0f;
const double myTime = 0.2;

@implementation ARFirstViewController

@synthesize myCameraDelegate;
@synthesize camera;
@synthesize locManager;
@synthesize headingLabel;
@synthesize arrowView;
@synthesize myMap;

@synthesize annoArray;
@synthesize viewArray;
@synthesize annoViewDictionary;
@synthesize back;
@synthesize locationCurrent;

@synthesize baseAlert;
@synthesize maxdistance;
@synthesize mindistance;
@synthesize max_angle;
@synthesize updateTimer;

@synthesize paranomaViewController;
@synthesize localizeButton;
@synthesize infoButton;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Start the tree recursion at level 0 with the root view
- (NSString *) displayViews: (UIView *) aView
{
	NSMutableString *outstring = [[NSMutableString alloc] init];
	[self dumpView: self.view.window atIndent:0 into:outstring];
	return [outstring autorelease];
}

// Show the tree
- (void) displayViews
{
	CFShow([self displayViews: self.view.window]);
}




-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
	updatedLocation = newLocation.coordinate;
	MKCoordinateRegion updateRegion;
	
	updateRegion.center = updatedLocation;
    MKCoordinateSpan span;
	
	span.latitudeDelta=.002;
	span.longitudeDelta=.002;
	updateRegion.span=span;	
	
	//issac stupid test 0520
/*	double max = 0.0;
	max = [self initialGeoLocation:newLocation];
	[self drawAnnotation:max];
*/
/*	if(locationCurrent == nil)
	{
		[self action];
		locationCurrent = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude
													 longitude:newLocation.coordinate.longitude];
		//locationCurrent =
	}
*/
	[myMap setRegion:updateRegion animated:YES];

	//NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
	//double lon = newLocation.coordinate.longitude;
	//double lat = newLocation.coordinate.latitude;
	// This part sets the region 
	//[myMap showsUserLocation];	
	
	//	myMap.region = updateRegion;
	//	MKCoordinateRegion zoomOut = { { newLocation.coordinate.latitude , newLocation.coordinate.longitude }, {4, 4} };
	//	[myMap setRegion:zoomOut animated:YES];
	//	myMap.region.center= newLocation.coordinate; 
	//	myMap.region.span = {newLocation.horizontalAccuracy,newLocation.verticalAccuracy};
	//	[myMap setRegion:zoomOut  animated:YES];
	//	[self.view setNeedsDisplay];
	//	myMap.centerCoordinate = newLocation.coordinate;	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	//NS Timer
	updatedHeading = newHeading.trueHeading;
	//updatedHeading = newHeading.magneticHeading;
	//NSLog(@"%f", updatedHeading);
	
	//CGAffineTransform myDistort = CGAffineTransformIdentity;
	myDistort = CGAffineTransformIdentity;
	
	//northRotateAngle = (newHeading.magneticHeading>180)? 360-newHeading.magneticHeading : -(newHeading.magneticHeading);
	//issac 0608 trueheading
	northRotateAngle = (newHeading.trueHeading>180)? 360-newHeading.trueHeading : -(newHeading.trueHeading);
	//northRotateAngle = (newHeading.magneticHeading>180)? 360-newHeading.magneticHeading : -(newHeading.magneticHeading);
	double FinalAngle = (northRotateAngle/180)*pii;
	myDistort = CGAffineTransformRotate(myDistort, FinalAngle);

	//issac 0517
	//[back setTransform:myDistort];
	
	//issac 0531

	
	//issac test 0510 for arrow distort
	//AccX = cos(northRotateAngle)*X + sin(northRotateAngle)*Y;
	//AccY = cos(northRotateAngle)*Y + sin(northRotateAngle)*X;

	//myDistort = CGAffineTransformScale(myDistort, AccX, AccY);
	myDistort = CGAffineTransformScale(myDistort, 0.71, 0.71);
	[arrowView setTransform:myDistort];


	
	
	//northRotateAngle = (newHeading.trueHeading>180)? 360-newHeading.trueHeading : -(newHeading.trueHeading);
	//NSLog(@"%f %f %f %f", newHeading.x, newHeading.y, newHeading.z, newHeading.magneticHeading);
	//headingLabel.text = [NSString stringWithFormat:@"Heading%f, rotating angle:%f",newHeading.trueHeading, northRotateAngle ] ;
	//myDistort = CGAffineTransformMakeScale(0.5, 1);
	//myDistort = CGAffineTransformScale(myDistort, 2, 1);
	//myDistort = CGAffineTransformScale(myDistort, (1.2 - (1.2/128)*newHeading.z)  , (1.2 - (1.2/128)*newHeading.y));
	//NSLog(@"%f %f %f %f", ((1.2/128)*newHeading.z), newHeading.z,((1.2/128)*newHeading.y), newHeading.y);
	//[arrowView setTransform:CGAffineTransformScale(myDistort, (1 - 0.7/128*newHeading.z)  , (1 - 0.7/128*newHeading.y))];
	//[arrowView setTransform:CGAffineTransformRotate(myDistort, (northRotateAngle/180)*pi)];
	//[arrowView setTransform:transform];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
//- (void)accelerometer:(UIAccelerometer *)sharedAccelerometer didAccelerate:(UIAcceleration *)acceleration
{
	//CGAffineTransform myDistortAcc = CGAffineTransformIdentity;
	//myDistort = CGAffineTransformIdentity;

	NSLog(@"%f %f %f", acceleration.x, acceleration.y, acceleration.z);
	
	AccZ = acceleration.z;
	
	
	
	//[arrowView setTransform:CGAffineTransformMakeScale((1.5 - fabs(acceleration.x))  , (1.5+0.3 - fabs(acceleration.y)))];
	//float xx = -[acceleration x];
	//float yy = [acceleration y];
	//NSLog(@"%f %f", xx, yy);
	//float angle = atan2(yy, xx);
	//myDistortAcc = CGAffineTransformRotate(myDistortAcc, angle);
	//myDistortAcc = CGAffineTransformScale(myDistortAcc, (1.5 - fabs(acceleration.x)), (1.5+0.3 - fabs(acceleration.y)));
	
	//X = (1.5 - fabs(acceleration.x));
	//Y = (1.5+0.4 - fabs(acceleration.y));
	
	//myDistort = CGAffineTransformScale(myDistort, (1.5 - fabs(acceleration.x)), (1.5+0.3 - fabs(acceleration.y)));
	//NSLog(@"%f %f", (1.5 - fabs(acceleration.x)), (1.5+0.3 - fabs(acceleration.y)));
	//NSLog(@"WoW distort !!");
	
	//[arrowView setTransform:CGAffineTransformMakeRotation(angle)];
	//[arrowView setTransform:myDistort];
}

-(BOOL)settingLocationManager
{
	//First we will start heading service
	self.locManager = [[[CLLocationManager alloc] init] autorelease];
	locManager.headingFilter = kCLHeadingFilterNone;	
	locManager.distanceFilter = kCLLocationAccuracyBest;
        // setup delegate callbacks
	locManager.delegate = self;
        // start the compass
	[locManager startUpdatingHeading];
	[locManager startUpdatingLocation];

	return YES;
}

//NS Timer
-(BOOL)PointInView:(SFAnnotation *)annotation range:(double)rangedistance
{
	//issac 0531 test
	//updatedHeading = 200.0;
	
/*	if (annotation.distance > rangedistance) {
		return NO;
	}
*/	
	
	double bearing = (annotation.bearing > 0)?annotation.bearing : (360 + annotation.bearing);
	double left, right;
	left = updatedHeading - range;
	if (left < 0) {
		left = left + 360; 
	}
	right = updatedHeading + range;
	if(right > 360){
		right = right - 360;
	}
	BOOL result = (bearing > left && bearing < right);
	if (left > right) {
		result = (bearing > left || bearing < right);
	}
	return result;
	
	
	
/*	
	double bearing = (annotation.bearing > 0)?annotation.bearing : (360 + annotation.bearing);
	double shift = (fabs(bearing - updatedHeading) > 180) 
						? 360 - fabs(bearing - updatedHeading) : fabs(bearing - updatedHeading);
	if(shift < 30)
	{
		return YES;
	}else
	{
		return NO;
	}
*/
}

-(void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:YES];
	
	
	camera = [[[UIImagePickerController alloc]init]autorelease];
	camera.delegate = myCameraDelegate;
	camera.sourceType = IMAGEPICKERSOURCE;
	camera.showsCameraControls = NO;
	//camera.navigationBarHidden = YES;
	
	//	camera.wantsFullScreenLayout = YES;
	//	camera.cameraOverlayView= nil;
	camera.cameraOverlayView= self.parentViewController.parentViewController.view;
	camera.cameraViewTransform = CGAffineTransformMakeScale(1.011, 1.011);
	
	//	[self.parentViewController presentModalViewController:camera animated:NO];	
	//	[camera dismissModalViewControllerAnimated:NO];
	
	[self presentModalViewController:camera animated:YES];	
	//NSLog(@"%@",[self.parentViewController description]);
	//	[self.parentViewController ]
	//NSLog(@"%@",[[self parentViewController] parentViewController description]);	
}

//issac 0517
-(double) computeRelativeDistance : (CLLocation *)myLocation Destination: (CLLocationCoordinate2D)destCoordinate
{
	CLLocation *localLocation = [[[CLLocation alloc] initWithLatitude:destCoordinate.latitude longitude:destCoordinate.longitude]autorelease];
	//(CLLocationDistance)distanceFromLocation:(const CLLocation *)location
	//CLLocationDistance distance = [myCoordinate distanceFromLocation:localLocation];
	
	CLLocationDistance distance = [myLocation distanceFromLocation:localLocation];
	//CLLocationDistance distance = [myLocation getDistanceFrom:localLocation];
	return distance;
}
- (double)Angle:(CLLocationCoordinate2D)coord1 destination:(CLLocationCoordinate2D)coord2
{
	double theta;
	theta = atan2(sin(coord2.longitude-coord1.longitude)*cos(coord2.latitude), cos(coord1.latitude)*sin(coord2.latitude)
				  -sin(coord1.latitude)*cos(coord2.latitude)*cos(coord2.longitude-coord1.longitude));
	//NSLog(@"%f",theta);
	return theta;
}
-(void) loadAnnotation
{
	//self.annoArray = [NSMutableArray arrayWithCapacity:100];
	self.annoArray = [[NSMutableArray alloc] init];
	//viewArray = [NSMutableArray arrayWithCapacity:100];
	self.viewArray = [[NSMutableArray alloc] init];

	
	//---------------read the coordinate file--------
	NSString* fPath_coord = [[NSBundle mainBundle] pathForResource:@"NTUdown1-1" ofType:@"txt"];
	NSString* text_coord = [NSString stringWithContentsOfFile:fPath_coord encoding:NSUTF8StringEncoding error:nil];
	NSArray* textarray_coord = [text_coord componentsSeparatedByString:@"\r\n"];
	
	
	
	for (NSString *element in textarray_coord) {
		NSArray* itemarray_coord = [element componentsSeparatedByString:@"\t"];
		
		//NSLog(@"-%@-", [itemarray_coord objectAtIndex:0]);
		//NSLog(@"-%@-", [itemarray_coord objectAtIndex:1]);
		//NSLog(@"-%@-", [itemarray_coord objectAtIndex:2]);
		//NSLog(@"-%@-", [itemarray_coord objectAtIndex:3]);
		
		
		CLLocation* location = [[CLLocation alloc] initWithLatitude:[[itemarray_coord objectAtIndex:1] doubleValue]
														  longitude:[[itemarray_coord objectAtIndex:2] doubleValue]];
		//if ([[itemarray_coord objectAtIndex:0] doubleValue] < 200) {
		{	
			SFAnnotation *poi ;
			
			//NSString *test = [NSString stringWithString:[itemarray_coord objectAtIndex:1]];
			//[test stringByAppendingString:[itemarray_coord objectAtIndex:1]];
			
			
			poi = [[SFAnnotation alloc] initWithTextAndLocation:[itemarray_coord objectAtIndex:0]
													  LocationX:location.coordinate.latitude
													  LocationY:location.coordinate.longitude];
			//NSLog(@"%@", poi.title);
			
			[self.annoArray addObject:poi];
			[poi release];
					
		}
		[location release];
	}
	//---------------read end------------------------	
	
}
-(double) initialGeoLocation:(CLLocation *)localCurrent
{
	//locationCurrent = [[CLLocation alloc] initWithLatitude:25.078602570310615 longitude:121.52626633644104];
	/*NSString * teststring = [NSString stringWithFormat:@"%@%5.0f公尺", element.title, element.distance];
	CallOutView *myview3 = [CallOutView addCalloutView:back 
												  text:teststring
												 point:testPoint
												target:self
												action:@selector(handleCalloutClick:)];
	*/
	//0602Chun Setting Maximum angle
	max_angle = M_PI/6;
	//
	CGPoint testPoint = CGPointMake(0.0,0.0);
	
	
	double max = 0.0;
	for (SFAnnotation *element in annoArray)
	{
		//Distance
		//NSLog(@"Geolocation1");
		//NSLog(@"%@", element.title);
		element.distance = [self computeRelativeDistance :localCurrent Destination: element.coordinate];
	
		//Bearing
		element.bearing = [self Angle:localCurrent.coordinate destination:element.coordinate];
		element.bearing = (element.bearing * 180)/pii;
		
		NSString * teststring = [NSString stringWithFormat:@"%@ %.0fmeters", element.title, element.distance];
		
		//CallOutView *myview3 = [CallOutView alloc];

		CallOutView *myview3 = [CallOutView addCalloutView:back 
										  text:teststring
										 point:testPoint
										target:self
										action:@selector(handleCalloutClick:)];
		
		[viewArray addObject:myview3];
		
		//NSLog(@"%@", myview3.calloutLabel.text);
		
		//insert to the back view
		//[back insertSubview:myview3 atIndex:0];
		//[myview3 release];
		
		if(element.distance > max)
			max = element.distance;
		
		NSLog(@"%f", element.distance);
		
		if(element.distance < mindistance)
			mindistance = element.distance;
	}
	//issac 0531
	[self.view addSubview:back];


	//NSTimer
	updateTimer = [NSTimer scheduledTimerWithTimeInterval:myTime
												   target:self
												 selector:@selector(updateHeading:)
												 userInfo:nil
												  repeats:YES];
	
	//move the button to the front
	[self.view bringSubviewToFront:infoButton];
	[self.view bringSubviewToFront:localizeButton];
	
	return max;
}
-(void)handleCalloutClick : (UIButton *) button
{
	NSLog(@"%@", button.currentTitle);
	for (int i=1; i<=39; i++) {
		NSString *Number = [NSString stringWithFormat:@"%d-", i];
		//NSLog(@"%@", button.currentTitle);
		NSLog(@"%@", Number);
		if ([button.currentTitle hasPrefix:Number]) {
			[paranomaViewController initWithPanoID:i  NavTitle:button.currentTitle];
			[self.navigationController pushViewController:paranomaViewController animated:YES];	
			[self.navigationController setNavigationBarHidden:NO];
			[camera dismissModalViewControllerAnimated:YES];			
			break;
		}
	}
}

NSInteger intSort(CallOutView *num1, CallOutView *num2, void *context)
{
    CGPoint v1 = num1.calloutPoint;
    CGPoint v2 = num2.calloutPoint;
    if (v1.y < v2.y)
        return NSOrderedAscending;
    else if (v1.y > v2.y)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

-(void)updateHeading:(NSTimer *)timer
{
//	NSLog(@"YOYO");
	//issac madness 0601 
	//運算量應該會超大吧XD
	//NSMutableArray *PointArray = [[NSMutableArray alloc] init];
	//maxdistance = 4800;

	
	//issac madness 1102
	NSMutableArray *CallOutArray = [NSMutableArray arrayWithCapacity:100];
	
	for (int i = 0; i < [annoArray count]; i++) {
		SFAnnotation *element = [annoArray objectAtIndex:i];
		CallOutView *elementV = [viewArray objectAtIndex:i];
		
		//CallOutView *element = [annoArray objectAtIndex: i];
		
		if([self PointInView:element range:maxdistance])/*-(BOOL)PointInView:(SFAnnotation *)annotation*/
			//if(1)
		{
			CGPoint testPoint =  [self CALlocation:element Maxdistance:maxdistance];			
			//CGPoint testPointT = CGPointMake(testPoint.x, testPoint.y);
			
			//NSLog(@"XXX %f, %f", testPoint.x, testPoint.y);
			
			
		
/*	
	for (int i = 0; i < [annoArray count]; i++) {
		SFAnnotation *element = [annoArray objectAtIndex:i];
		CallOutView *elementV = [viewArray objectAtIndex:i];
		
		if([self PointInView:element range:maxdistance])
		//if(1)
		{
			CGPoint testPoint =  [self CALlocation:element Maxdistance:maxdistance];			
			CGPoint testPointT = CGPointMake(testPoint.x, testPoint.y);
			//issac 0601
			//[PointArray addObject: [NSValue valueWithPointer:&testPoint]];
			//for (int y=0; y < [PointArray count] ; y++) {
			//}
*/
			
/*			
			//issac 0701
			//accelerometer to decide the y position.
			int AccZtemp = 0;
			AccZtemp = AccZ * 10;
			float AccZtemp2 = 0.0;
			AccZtemp2 = AccZtemp / 10.0;
			float AccZtemp3 = 0.0;
			if( (AccZtemp3 = (AccZtemp2 - (-0.4))) >= 0 )
			{
				testPointT.y += AccZtemp3 * 120;
			}else {
				testPointT.y += AccZtemp3 * 120;
				//testPointT.y += (AccZtemp2 >=0 ) ? AccZtemp2 * 90 : AccZtemp2 * -90;
			}
			
*/		
				
/*			//issac 0601 2
			//button collision
			for (int y=0 ; y < i ; y++) {
				SFAnnotation *elementT = [annoArray objectAtIndex:y];
				CallOutView *elementTV = [viewArray objectAtIndex:y];
				//NSLog(@"%f %f", testPoint.x, elementTV.calloutPoint.x);
				if (elementTV.calloutPoint.x != 0) {
					//NSLog(@"%f %f", testPoint.x, elementTV.calloutPoint.x);
					if((fabs(testPoint.x - elementTV.calloutPoint.x) < 150) 
						&& fabs(testPoint.y - elementTV.calloutPoint.y) < 70 ){
						if(element.distance > elementT.distance)
						{
							testPointT.y -= 60;
						}else {
							testPointT.y += 60;
						}
						break;

					}
				}
			}
*/		

			
			//issac 0531
//			[elementV setAnchorPoint:testPointT];
			//NSLog(@"%f %f %f", testPointT.x, testPointT.y, element.bearing);
			
			//Chun 0602
			double bearing = (element.bearing > 0)?element.bearing : (360 + element.bearing);
			double centerBearing = updatedHeading;
            if (bearing-centerBearing>180) {
				centerBearing+=360;
			}
			else if (bearing-centerBearing<-180) {
				bearing+=360;
			}
			double angleDifference = bearing -centerBearing;
			if (angleDifference>90) {
				angleDifference = 90;
			}
			if (angleDifference <-90) {
				angleDifference = -90;
			}
			angleDifference = -angleDifference;
			//CALayer *layer = elementV.layer;
			CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
			rotationAndPerspectiveTransform.m34 = 1.0 / -500;
			//rotationAndPerspectiveTransform.m34 = 1.0 / 300; 
			rotationAndPerspectiveTransform=CATransform3DRotate(rotationAndPerspectiveTransform, 
																 angleDifference * M_PI / 180.0f
																 , 0, 1, 0);
			// [layer setTransform:rotationAndPerspectiveTransform];
			elementV.layer.transform = rotationAndPerspectiveTransform;
			elementV.layer.zPosition = -200 * i;
			
			//issac 1029
			[elementV setAnchorPoint:testPoint];	//assign the point
			[CallOutArray addObject:elementV];			
			
			
			
			 //	layer.transform = rotationAndPerspectiveTransform;
			 
			if(!(elementV.superview))
			{
				[back addSubview:elementV];
			}
			//	[back insertSubview:elementV atIndex:0];
			
			//issac 0528
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			//[elementV setAnchorPoint:testPoint];

		}else {
			if(!(elementV.superview))
			{
				[elementV removeFromSuperview];
				//elementV.transform = CGAffineTransformIdentity;
			}
			//remove the calloutview from back view
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			
			//issac 0531
			//if(elementV.superview != nil)
			//	NSLog(@"YAYA");
			//[elementV removeFromSuperview];
			
			//issac 0601
			CGPoint testPoint =  CGPointMake(0.0, 0.0);
			[elementV setAnchorPoint:testPoint];
		}
	}
/*	
	for(SFAnnotation *element in annoArray)
	{
		CallOutView *elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];

		if([self PointInView:element])
		//if(1)
		{
			CGPoint testPoint =  [self CALlocation:element Maxdistance:maxdistance];
			//issac 0531
			[elementV setAnchorPoint:testPoint];
			//if(elementV.superview == nil)
			//	[back insertSubview:elementV atIndex:0];
			
			//issac 0528
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			//[elementV setAnchorPoint:testPoint];
		}else {
			//remove the calloutview from back view
			//id elementV = [viewArray objectAtIndex:[annoArray indexOfObject:element]];
			
			//issac 0531
			//if(elementV.superview != nil)
			//	NSLog(@"YAYA");
				//[elementV removeFromSuperview];

			//issac 0601
			CGPoint testPoint =  CGPointMake(0.0, 0.0);
			[elementV setAnchorPoint:testPoint];
		}
	}
*/
	
	//issac 1102
/*	NSArray *sort_CallOutArray;
	sort_CallOutArray = [CallOutArray sortedArrayUsingFunction:intSort context:nil];
		
	for(int i=0 ; i<[sort_CallOutArray count]; i++)
	{
		CallOutView *element = [sort_CallOutArray objectAtIndex:i];
		
		CGPoint testP = CGPointMake(element.calloutPoint.x, element.calloutPoint.y);
		NSLog(@"1 %d %f", i, element.calloutPoint.y);
		
		testP.y = (float)i/[sort_CallOutArray count]* 430;
		
		
		//CGPoint testP2 = CGPointMake(0.0, 0.0);
		//[element setAnchorPoint:testP2];
		[element setAnchorPoint:testP];
		NSLog(@"2 %d %f", i, element.calloutPoint.y);
		
		if(!(element.superview))
		{
			[back addSubview:element];
		}
		
	}	
*/	
}

-(CGPoint) CALlocation:(SFAnnotation *)annotation Maxdistance:(double)distanceM
{
	//distanceM += 500;
	//mybearing not relative to the north direction anymore?!
	double mybearing = (annotation.bearing >= 0)? annotation.bearing : (360 + annotation.bearing) ;
	
	
	//issac 0531
	mybearing = (mybearing - updatedHeading);

	double mybearing_pi = mybearing * pii/180;
	double Y_coord = (cos(mybearing_pi) >= 0) ? 1 : -1;

	CGPoint testPoint;
//	testPoint = CGPointMake(460 + annotation.distance * 700/distanceM * sin(mybearing * pii/180)
//							, 420 - annotation.distance * 460/distanceM * cos(mybearing * pii/180));
	//issac 0601
//	testPoint = CGPointMake(460 + (annotation.distance * 30/distanceM) * tan(mybearing_pi)
//							, 420 - (annotation.distance * 460/distanceM) * Y_coord);
	//issac 0602
	//testPoint = CGPointMake(460 + 320*sin(mybearing_pi), 420 - (annotation.distance * 460/distanceM) * Y_coord);

	//issac 1104
	testPoint = CGPointMake(460 + 320*sin(mybearing_pi)
							, 420 - ((annotation.distance - mindistance) * 380/(distanceM - mindistance)) * Y_coord);
	//NSLog(@"%f %f %f %f", testPoint.x, testPoint.y, (annotation.distance - mindistance), (distanceM - mindistance));

	return testPoint;
}

-(void) drawAnnotation:(double)distanceM
{
//	back = [[UIView alloc] initWithFrame:CGRectMake(-300, 0, 920, 920)];
//	back.backgroundColor = [UIColor clearColor];

	distanceM = 3000;
    for(SFAnnotation *element in annoArray)
	{
		double mybearing = (element.bearing >= 0)? element.bearing : (180 + element.bearing + 180) ;
		//double mybearing = element.bearing;
		
		//NSLog(@"%f", mybearing);
		//NSLog(@"%f", element.bearing);
		
		//double mybearing = element.bearing;
		//CGPoint testPoint = CGPointMake(320, element.distance * 320 / max) ;
		CGPoint testPoint;
		//if(element.bearing >=0)
		//{
		testPoint = CGPointMake(460 + element.distance * 160/distanceM * sin(mybearing * pii/180)
										, 420 - element.distance * 460/distanceM * cos(mybearing * pii/180));
		//}else{
		//testPoint = CGPointMake(460 + element.distance * 460/distanceM * cos(mybearing * pii/180)
		//									, 420 - element.distance * 460/distanceM * sin(mybearing * pii/180));			
		//}
		
		//NSLog(@"%f %f %f", testPoint.x, testPoint.y, element.distance);
		
		//issac test 0528
		NSInteger temp = [annoArray indexOfObject:element];
		//NSLog(@"%d", temp);
		CallOutView * elementV = [viewArray objectAtIndex:temp];
		
		//issac 0531
		//[elementV initWithText:elementV.calloutLabel.text point:testPoint];
		
		[elementV setAnchorPoint:testPoint];
		//NSLog(@"%@", elementV.calloutLabel.text);

		//[elementV initialize];
/*		NSString * teststring = [NSString stringWithFormat:@"%@%5.0f公尺", element.title, element.distance];
		CallOutView *myview3 = [CallOutView addCalloutView:back 
													  text:teststring
													 point:testPoint
													target:self
													action:@selector(handleCalloutClick:)];
		
		[myview3 setTransform:CGAffineTransformMakeRotation(element.bearing * pii/180)];
*/		
//		[back insertSubview:elementV atIndex:0];
//		[back insertSubview:myview3 atIndex:0];
		
		//[myview3 release];
	}
	
	[self.view addSubview:back];
	[back release];	
}

- (void) performDismiss
{
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
	
	//test 0520
	maxdistance = 0.0;
	locationCurrent = [[CLLocation alloc] initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];
	
	//FloraExpo
//	locationCurrent = [[CLLocation alloc] initWithLatitude:25.070649 longitude:121.521868];
		
//	locationCurrent = [[CLLocation alloc] initWithLatitude:25.027935299122106 
//												 longitude:121.5168035030365];
//	locationCurrent = [[CLLocation alloc] initWithLatitude:25.083754775873032 
//												 longitude:121.55733263292502];

	//43	37.421435	-122.084069
	//locationCurrent = [[CLLocation alloc] initWithLatitude:37.421435
	//											 longitude:-122.084069];

	//earthmine coordinateX:37.862043 coordinateY:-122.298244
	//locationCurrent = [[CLLocation alloc] initWithLatitude:37.862043
	//											 longitude:-122.298244];
	
	//issac 0608 singleton
	ARDataSingleton *singleton = [ARDataSingleton sharedData];
	[singleton.myLocation initWithLatitude:locationCurrent.coordinate.latitude
								 longitude:locationCurrent.coordinate.longitude];

	//CGPoint testPoint = CGPointMake(160, 320);
	maxdistance = [self initialGeoLocation:locationCurrent];
	
	//[self drawAnnotation:maxdistance];
	
	
	//add localize button
	self.localizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	self.localizeButton.frame = CGRectMake(260, 60, 40, 35);
	[self.localizeButton addTarget:self action:@selector(localizeClick:) forControlEvents:UIControlEventTouchUpInside];
	
	self.infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	self.infoButton.frame = CGRectMake(280, 35, 20, 20);
	[self.infoButton addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:self.localizeButton];
	[self.view addSubview:self.infoButton];
}
- (void) action
{
	baseAlert = [[[UIAlertView alloc] initWithTitle:@"請稍後"
					 message:@"正在鎖定您目前所在的位置" delegate:self cancelButtonTitle:nil
					 otherButtonTitles: nil] autorelease];
	[baseAlert show];
	// Create and add the activity indicator
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc]
										initWithActivityIndicatorStyle:
										UIActivityIndicatorViewStyleWhiteLarge];
	aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f,
							 baseAlert.bounds.size.height - 40.0f);
	[aiv startAnimating];
	[baseAlert addSubview:aiv];
	[aiv release];
	// Auto dismiss after 3 seconds for this example
	[self performSelector:@selector(performDismiss) withObject:nil
		afterDelay:6.0f];	
}

-(void)setMyMap{
	myMap.mapType = MKMapTypeStandard;
//	myMap.centerCoordinate = myMap.userLocation.coordinate;
//	NSLog(@"Location:%f", myMap.userLocation.coordinate.latitude);
	[myMap showsUserLocation]; 
	myMap.delegate = self;
	myMap.layer.cornerRadius = 70.0;
	

	
/*	MKCoordinateRegion mapRegion;
	
	mapRegion.center.latitude = locationCurrent.coordinate.latitude;
	mapRegion.center.longitude = locationCurrent.coordinate.longitude;
	
    MKCoordinateSpan span;
	
	span.latitudeDelta=.005;
	span.longitudeDelta=.005;
	mapRegion.span=span;		
	
	[self.myMap setRegion:mapRegion animated:YES];
	[self.view addSubview:myMap];
*/	
//	MKCoordinateRegion region;
	//region.center.latitude = locationCurrent.coordinate.latitude;
	//region.center.longitude = locationCurrent.coordinate.longitude;
	//[myMap setRegion:region animated:YES];
	//[myMap setCenterCoordinate:locationCurrent.coordinate animated:YES];
	//CLLocationCoordinate2D mytest = {25.063546878877353, 121.55214657064167};
	//MKPlacemark *placemark=[[MKPlacemark alloc] initWithCoordinate:mytest];
	//[myMap addAnnotation:placemark];
	//[placemark release];
	
	
	//myMap.view.alpha = 0.2f;
	//[self.view addSubview:myMap];
}

#pragma mark localizeClick
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	printf("Button %d\n", buttonIndex + 1);

	switch (buttonIndex) {
		case 0://GPS
			[self.locManager startUpdatingLocation];
			[self.locationCurrent initWithLatitude:updatedLocation.latitude longitude:updatedLocation.longitude];
			
			maxdistance = 0.0;
			mindistance = 1000000000.0;		
			self.maxdistance = [self initialGeoLocation:self.locationCurrent];
			break;
		case 1://Manual
			[self.locManager stopUpdatingLocation];
			//25.016886	121.534758
			[self.locationCurrent initWithLatitude:25.016886 longitude:121.534758];
			
			maxdistance = 0.0;
			mindistance = 1000000000.0;		
			self.maxdistance = [self initialGeoLocation:self.locationCurrent];
			break;
		case 2://Cancel
			;
			break;
		default:
			break;
	}
}

- (void) presentSheet
{
	UIActionSheet *menu = [[UIActionSheet alloc]
						   initWithTitle:@"定位方式"
						   delegate:self
						   cancelButtonTitle:@"Cancel"
						   destructiveButtonTitle:nil 
						   otherButtonTitles:@"GPS定位", @"手動定位", nil];
	
	//[self.view window] for not to be overlay by the TABBAR!!
	[menu showInView:[self.view window]];
	[menu release];
}

- (void)localizeClick:(id)element
{
	[self presentSheet];
}
#pragma mark -
#pragma mark SearchAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0://取消
			;
			break;
		case 1://確定
			//set the Num and Range(singleton)
			;
			break;
		default:
			break;
	}
}
#pragma mark -
- (void)infoClick:(id)element
{
/*	Information *infoViewController;
	infoViewController = [[Information alloc] init];
	[self.navigationController pushViewController:infoViewController animated:YES];	
	[self.navigationController setNavigationBarHidden:NO];
	[camera dismissModalViewControllerAnimated:YES];
*/
	//alertview test
	SearchAlertView *mySearchAlertView;
	mySearchAlertView = [[SearchAlertView alloc] initWithTitle:@"test" 
													   message:nil 
													  delegate:self 
											 cancelButtonTitle:@"取消" 
											 otherButtonTitles:@"確定", nil];
	[mySearchAlertView show];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	// 此塊用來先啓動相機
	NSLog(@"YAYA viewdidload");
	
	
	//back navigation item button 0831
	// create a custom navigation bar button and set it to always says "Back"
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"BACK";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
	//open the accelerometer
	//[[UIAccelerometer sharedAccelerometer] setDelegate:self];	

	//[self start];	
	//accelerometer by issac	
	
	
	//issac 0517
	//[self calculate ]
	maxdistance = 0.0;
	mindistance = 1000000000.0;
	
	//issac 0929
	paranomaViewController = [panoWebView alloc];
	
	
	[self loadAnnotation];
	
	
	[self setMyMap];
	
	
	//locationCurrent = nil;
	//locationCurrent = [[CLLocation alloc] initWithLatitude:25.078602570310615 longitude:121.52626633644104];
	
	//[self action];
	
	NSLog(@"what?");

	
	//	back = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	//back = [[UIView alloc] initWithFrame:CGRectMake(-320, 0, 960, 960)];

	back = [[UIView alloc] initWithFrame:CGRectMake(-300, 0, 920, 920)];
	back.backgroundColor = [UIColor clearColor];
	[self settingLocationManager];

	//[self presentSheet];
	[self action];
	
	[super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void)viewWillDisappear:(BOOL)animated
{
//	[super viewDidDisappear:animated];
//	if(animated)
//	{
//	}
	NSLog(@"Run hereeee");
	//[self dismissModalViewControllerAnimated:YES];

	[super viewWillDisappear:animated];

}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
//	[camera dismissModalViewControllerAnimated:YES];
//	[self dismissModalViewControllerAnimated:YES];

	self.myMap = nil;
	self.camera= nil;
	self.back = nil;
}


- (void)dealloc {
//	[camera dismissModalViewControllerAnimated:YES];
//	[self dismissModalViewControllerAnimated:YES];
	[locManager stopUpdatingHeading];
	[locManager stopUpdatingLocation];
	[locManager release];
	[myCameraDelegate release];
	
	[myMap release];
	[headingLabel release];
	[camera release];
	[arrowView release];
	[locationCurrent release];
	[annoArray release];
	[viewArray release];
	[annoViewDictionary release];
	[back release];

    [super dealloc];
}


@end
