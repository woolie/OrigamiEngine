//
// CueSheetTrack.m
//
// Copyright (c) 2012 ap4y (lod@pisem.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CueSheetTrack.h"

@interface CueSheetTrack ()
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, copy) NSString* track;
@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* album;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* genre;
@property (nonatomic, copy) NSString* year;
@property (nonatomic, assign) double time;
@end

@implementation CueSheetTrack

+ (instancetype) trackWithURL:(NSURL*) url
						track:(NSString*) track
						 time:(double) seconds
					   artist:(NSString*) artist
						album:(NSString*) album
						title:(NSString*) title
						genre:(NSString*) genre
						 year:(NSString*) year
{
	return [[CueSheetTrack alloc] initWithURL:url
										track:track
										 time:seconds
									   artist:artist
										album:album
										title:title
										genre:genre
										 year:year];
}

- (instancetype) initWithURL:(NSURL*) url
					   track:(NSString*) track
						time:(double) seconds
					  artist:(NSString*) artist
					   album:(NSString*) album
					   title:(NSString*) title
					   genre:(NSString*) genre
						year:(NSString*) year
{
	self = [super init];
	if (self != nil)
	{
		_url = url;
		_track = [track copy];
		_artist = [artist copy];
		_album = [album copy];
		_title = [title copy];
		_genre = [genre copy];
		_year = [year copy];
		_time = seconds;
	}
	
	return self;
}

@end
