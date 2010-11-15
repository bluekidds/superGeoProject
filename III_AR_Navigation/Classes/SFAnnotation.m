
#import "SFAnnotation.h"

@implementation SFAnnotation 

/*@synthesize image;
@synthesize latitude;
@synthesize longitude;
*/
@synthesize coordinate;

@synthesize subtitle,title;

@synthesize Number;
@synthesize bearing;
@synthesize distance;
@synthesize place;

- (id) initWithCoords:(CLLocationCoordinate2D) coords{
	
	self = [super init];
	
	if (self != nil) {
		
		coordinate = coords; 
		
	}
	
	self.Number = 0;
	
	return self;
	
}

- (id) initWithTextAndLocation : (NSString *)myTitle LocationX:(double)coorX LocationY:(double)coorY
{
	
	self= [super init];
	
	//title = [[NSString alloc] init];
	//subtitle = [[NSString alloc] init];
	
	if (self!=nil) {
		//self.coordinate.latitude = coorX;
		//self.coordinate.longitude = coorY;
		coordinate = CLLocationCoordinate2DMake(coorX, coorY);
		if (myTitle !=nil) {
			self.title = myTitle;
		}
	}

	return self;
}

- (void)dealloc
{
    //[image release];
	[subtitle release];
	[title release];
    [super dealloc];
}

@end
