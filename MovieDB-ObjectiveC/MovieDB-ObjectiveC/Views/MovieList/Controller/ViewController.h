//
//  ViewController.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 22/03/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) IBOutlet UITableView *myTableView;
@end

