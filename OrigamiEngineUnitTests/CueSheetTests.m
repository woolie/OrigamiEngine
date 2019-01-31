//
// CueSheetTests.m
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

@import XCTest;

#import "CueSheet.h"

@interface CueSheetTests : XCTestCase
{
	NSURL*	_multiFileCueUrl;
	NSURL*	_singleFileCueUrl;
}
@end

@interface CueSheetTests ()
@end

@implementation CueSheetTests

- (void) setUp
{
	[super setUp];

	_multiFileCueUrl = [[NSBundle bundleForClass:[self class]] URLForResource:@"multi_file"
																withExtension:@"cue"];
	_singleFileCueUrl = [[NSBundle bundleForClass:[self class]] URLForResource:@"single_file"
																 withExtension:@"cue"];
}

- (void) tearDown
{
	[super tearDown];
}

- (void) testCueSheetShouldParseCueSheetFromSingleFileFixture
{
	CueSheet* cueSheet = [[CueSheet alloc] initWithURL:_singleFileCueUrl];

	XCTAssertNotNil(cueSheet, @"");
	XCTAssertEqual(cueSheet.tracks.count, 14U, @"");

	NSURL *bundleUrl = [NSBundle bundleForClass:[self class]].bundleURL;
	NSURL *url = [bundleUrl URLByAppendingPathComponent:@"Contents/Resources/NEW!.flac"];
	
	CueSheetTrack *firstTrack = [cueSheet.tracks objectAtIndex:0];
	XCTAssert([firstTrack.title isEqualToString:@"Warning"], @"");
	XCTAssertEqualObjects(firstTrack.artist, @"LAMA", @"");
	XCTAssertEqualObjects(firstTrack.album, @"NEW!", @"");
	XCTAssertEqualObjects(firstTrack.track, @"01", @"");
	XCTAssertEqualObjects(firstTrack.year, @"2011", @"");
	XCTAssertEqualObjects(firstTrack.genre, @"Rock", @"");
	XCTAssertEqualWithAccuracy(firstTrack.time, 0.0, 0.1, @"");
	XCTAssertEqualObjects(firstTrack.url, url, @"");
	
	CueSheetTrack *lastTrack = [cueSheet.tracks objectAtIndex:13];
	XCTAssertEqualObjects(lastTrack.title, @"Dreamin'", @"");
	XCTAssertEqualObjects(lastTrack.artist, @"LAMA", @"");
	XCTAssertEqualObjects(lastTrack.album, @"NEW!", @"");
	XCTAssertEqualObjects(lastTrack.track, @"14", @"");
	XCTAssertEqualObjects(lastTrack.year, @"2011", @"");
	XCTAssertEqualObjects(lastTrack.genre, @"Rock", @"");
	XCTAssertEqualWithAccuracy(lastTrack.time, 2691.7, 0.1, @"");
	XCTAssertEqualObjects(lastTrack.url, url, @"");
}

- (void) testCueSheetShouldParseCueSheetFromMultiFileFixture
{
	CueSheet* cueSheet = [[CueSheet alloc] initWithURL:_multiFileCueUrl];
	
	XCTAssertNotNil(cueSheet, @"");
	XCTAssertEqual(cueSheet.tracks.count, 12U, @"");
	
	NSURL* bundleUrl = [NSBundle bundleForClass:[self class]].bundleURL;
	
	CueSheetTrack* firstTrack = [cueSheet.tracks objectAtIndex:0];
	XCTAssertEqualObjects(firstTrack.title, @"Amerigo", @"");
	XCTAssertEqualObjects(firstTrack.artist, @"Patti Smith", @"");
	XCTAssertEqualObjects(firstTrack.album, @"Banga", @"");
	XCTAssertEqualObjects(firstTrack.track, @"01", @"");
	XCTAssertEqualObjects(firstTrack.year, @"2012", @"");
	XCTAssertEqualObjects(firstTrack.genre, @"Rock", @"");
	XCTAssertEqualWithAccuracy(firstTrack.time, 0.0, 0.1, @"");
	XCTAssertEqualObjects(firstTrack.url, [bundleUrl URLByAppendingPathComponent:@"Contents/Resources/01 - Amerigo.wav"], @"");
	
	CueSheetTrack *lastTrack = [cueSheet.tracks objectAtIndex:11];
	XCTAssertEqualObjects(lastTrack.title, @"After The Gold Rush", @"");
	XCTAssertEqualObjects(lastTrack.artist, @"Patti Smith", @"");
	XCTAssertEqualObjects(lastTrack.album, @"Banga", @"");
	XCTAssertEqualObjects(lastTrack.track, @"12", @"");
	XCTAssertEqualObjects(lastTrack.year, @"2012", @"");
	XCTAssertEqualObjects(lastTrack.genre, @"Rock", @"");
	XCTAssertEqualWithAccuracy(lastTrack.time, 0.0, 0.1, @"");
	XCTAssertEqualObjects(lastTrack.url, [bundleUrl URLByAppendingPathComponent:@"Contents/Resources/12 - After The Gold Rush.wav"], @"");
}

@end
