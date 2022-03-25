//
//  TableViewCell.m
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 23/03/22.
//

#import <Foundation/Foundation.h>
#import "TableViewCell.h"
#import "Movie.h"


@implementation TableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.imageCell.layer setCornerRadius:10];
    
}

- (void)populateCellWithMovie:(Movie *)movie {
    [self.titleCell setText:movie.title];
    [self.descriptionCell setText:movie.overview];
    NSMutableAttributedString* rating = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[movie.rating doubleValue]]];
    
    [self.ratingCell setAttributedText:rating];
    
    if (movie.poster != nil) {
        [self.imageCell setImage:[UIImage imageWithData:movie.poster]];
    } else if ([movie.poster_path.absoluteString isEqualToString:@""]) {
        [self.imageCell setImage:[UIImage systemImageNamed:@"camera.fill"]];
    } else {
        NSURLSessionDownloadTask* poster_download = [[NSURLSession sharedSession] downloadTaskWithURL:movie.poster_path completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [movie setPoster:[NSData dataWithContentsOfURL:location]];
            UIImage* poster = [UIImage imageWithData:movie.poster];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageCell setImage:poster];
            });
        }];
        
        [poster_download resume];
    }
    
}

@end
