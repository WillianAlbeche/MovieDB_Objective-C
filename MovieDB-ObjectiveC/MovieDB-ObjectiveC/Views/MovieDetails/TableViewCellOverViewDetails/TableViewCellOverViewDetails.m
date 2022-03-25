//
//  TableViewCellOverViewDetails.m
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#import <Foundation/Foundation.h>
#import "TableViewCellOverViewDetails.h"
#import "Movie.h"
@implementation TableViewCellOverViewDetails
- (void)setMovie:(Movie*)movie{
    [self.overviewCell setText:movie.overview];
}

@end
