//
//  TableViewCellOverViewDetails.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#ifndef TableViewCellOverViewDetails_h
#define TableViewCellOverViewDetails_h
#import<UIKit/UIKit.h>


@class Movie;
@interface TableViewCellOverViewDetails : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *overviewCell;

@property (nonatomic) Movie* movie;
@end

#endif /* TableViewCellOverViewDetails_h */
