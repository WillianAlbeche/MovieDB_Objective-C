//
//  TableViewCellTitleDetails.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#ifndef TableViewCellTitleDetails_h
#define TableViewCellTitleDetails_h
#import <UIKit/UIKit.h>


@class Movie;
@interface TableViewCellTitleDetails : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageCell;
@property (weak, nonatomic) IBOutlet UILabel *titleCell;
@property (weak, nonatomic) IBOutlet UILabel *genreCell;
@property (weak, nonatomic) IBOutlet UILabel *ratingCell;
@property (nonatomic) Movie* movie;

//-(void)populateCellWithMovie:(Movie*)movie;

@end


#endif /* TableViewCellTitleDetails_h */
