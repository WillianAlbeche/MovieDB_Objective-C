//
//  TableViewCell.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#ifndef TableViewCell_h
#define TableViewCell_h
#import <UIKit/UIKit.h>

@class Movie;
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *titleCell;
@property (weak, nonatomic) IBOutlet UILabel *descriptionCell;
@property (weak, nonatomic) IBOutlet UILabel *ratingCell;
-(void)populateCellWithMovie:(Movie*)movie;


@end

#endif /* TableViewCell_h */
