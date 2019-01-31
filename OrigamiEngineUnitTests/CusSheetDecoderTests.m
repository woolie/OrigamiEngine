//
// CusSheetDecoderTests.m
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

#import "CueSheetDecoder.h"
#import "FileSource.h"

@interface CusSheetDecoderTests : XCTestCase
@property (nonatomic, retain) CueSheetDecoder *decoder;
@end

@implementation CusSheetDecoderTests

- (void) setUp {
	[super setUp];
	_decoder = [[CueSheetDecoder alloc] init];
	
	FileSource *source = [[FileSource alloc] init];
	
	NSURL *cueUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															   withExtension:@"cue"];
	NSString *cuePath = [[cueUrl absoluteString] stringByAppendingString:@"#01"];
	cueUrl = [NSURL URLWithString:cuePath];
	[source open:cueUrl];
	
	XCTAssertTrue([_decoder open:source], @"");
}

- (void) tearDown {
	[_decoder close];
	[super tearDown];
}

- (void) testFlacDecoderShouldReturnSupportedFileTypes {
	XCTAssertEqualObjects([CueSheetDecoder fileTypes], @[@"cue"], @"");
}

- (void) testFlacDecoderShouldReturnSuppertedValidProperties {
	NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithInt:2], @"channels",
								[NSNumber numberWithInt:16], @"bitsPerSample",
								[NSNumber numberWithFloat:44100.0], @"sampleRate",
								[NSNumber numberWithDouble:162496.0], @"totalFrames",
								[NSNumber numberWithBool:YES], @"seekable",
								@"big",@"endian",
								nil];
	XCTAssertEqualObjects([_decoder properties], properties, @"");
}

- (void) testFlacDecoderShouldReturnSuppertedValidMetadata {
	NSDictionary *metadata = @{
		@"album": @"Banga",
		@"artist": @"Patti Smith",
		@"genre": @"Rock",
		@"title": @"Amerigo",
		@"track": @1,
		@"year": @"2012",
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
