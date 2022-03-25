//
//  TableViewCellTitleDetails.m
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#import <Foundation/Foundation.h>
#import "TableViewCellTitleDetails.h"
#import "Movie.h"

@implementation TableViewCellTitleDetails

- (void)setMovie:(Movie *)movie{
    [self.titleCell setText: movie.title];
    [self.genreCell setText:movie.genre];
    
    NSMutableAttributedString* rating = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[movie.rating doubleValue]]];
    
//    [self.ratingCell setAttributedText:rating];
    NSURLSessionDownloadTask* poster_download = [[NSURLSession sharedSession] downloadTaskWithURL:movie.poster_path completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           UIImage* poster = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
           
           dispatch_async(dispatch_get_main_queue(), ^{
               [self.imageCell setImage:poster];
           });
       }];
       
       [poster_download resume];
}

@end
