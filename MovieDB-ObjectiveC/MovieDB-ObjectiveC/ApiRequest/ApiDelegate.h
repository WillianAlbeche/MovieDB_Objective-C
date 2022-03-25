//
//  ApiDelegate.h
//  MovieDB-ObjectiveC
//
//  Created by Willian Magnum Albeche on 24/03/22.
//

#ifndef ApiDelegate_h
#define ApiDelegate_h

@protocol ApiDelegate <NSObject>

-(void)receivedMovieList:(NSData*) json from:(FetchOption) option;
-(void)receivedMovieDetails:(NSData*) json for:(Movie*) movie;
-(void)fetchFailedWithError:(NSError*) error;

@end
#endif /* ApiDelegate_h */
