//
//  imgViewController.h
//  III_AR_Navigation
//
//  Created by Chun F.Hsu on 2010/9/2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface imgViewController : UIViewController {
 IBOutlet UIButton *back;
}
-(IBAction) buttonBack:(id)sender;
@property (retain , nonatomic)UIButton *back;
@end
