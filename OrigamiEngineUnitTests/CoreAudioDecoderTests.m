//
// CoreAudioDecoderTests.m
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

#import "CoreAudioDecoder.h"
#import "FileSource.h"

@interface CoreAudioDecoderTests : XCTestCase
@property (nonatomic, retain) CoreAudioDecoder *decoder;
@end

@implementation CoreAudioDecoderTests

- (void) setUp {
	[super setUp];
	_decoder = [[CoreAudioDecoder alloc] init];
	
	FileSource *source = [[FileSource alloc] init];
	
	NSURL *mp3Url = [[NSBundle bundleForClass:self.class] URLForResource:@"id3v22-tda"
														   withExtension:@"mp3"];
	[source open:mp3Url];
	
	XCTAssertTrue([_decoder open:source], @"");
}

- (void) tearDown {
	[_decoder close];
	[super tearDown];
}

- (void) testFlacDecoderShouldReturnSupportedFileTypes {
	XCTAssertTrue([[CoreAudioDecoder fileTypes] containsObject:@"mp3"], @"");
	XCTAssertTrue([[CoreAudioDecoder fileTypes] containsObject:@"wav"], @"");
	XCTAssertTrue([[CoreAudioDecoder fileTypes] containsObject:@"m4a"], @"");
	XCTAssertTrue([[CoreAudioDecoder fileTypes] containsObject:@"mp4"], @"");
}

- (void) testFlacDecoderShouldReturnSuppertedValidProperties {
	NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithInt:0], @"bitrate",
								[NSNumber numberWithInt:2], @"channels",
								[NSNumber numberWithInt:16], @"bitsPerSample",
								[NSNumber numberWithFloat:44100.0], @"sampleRate",
								[NSNumber numberWithDouble:9797760.0], @"totalFrames",
								[NSNumber numberWithBool:YES], @"seekable",
								@"big",@"endian",
								nil];
	XCTAssertEqualObjects([_decoder properties], properties, @"");
}

- (void) testFlacDecoderShouldReturnSuppertedValidMetadata {
	NSDictionary *metadata = @{
		@"album": @"n Water I Can Fly",
		@"approximate duration in seconds": @"222.171",
		@"artist": @"Basshunter",
		@"comments": @"Ripped by THSLIVE",
		@"genre": @"Dance",
		@"title": @"I Can Walk On Water I Can Fly",
		@"track number": @"1",
		@"year": @"2010",
	};
	XCTAssertEqualObjects([_decoder metadata], metadata, @"");
}

- (void) testFlacDecoderShouldReadAudioData {
	void *buffer = malloc(16 * 1024);
	XCTAssertEqual([_decoder readAudio:buffer frames:4], 4, @"");
	free(buffer);
}

- (void) testFlacDecoderShouldSeekAudioData {
	XCTAssertEqual([_decoder seek:10], 10L, @"");
}

@end
