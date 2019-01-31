//
// FileSourceTests.m
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

#import "FileSource.h"

@interface FileSourceTests : XCTestCase
@property (retain, nonatomic) FileSource *source;
@end

@implementation FileSourceTests

- (void) setUp {
	[super setUp];
	
	_source = [[FileSource alloc] init];
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	XCTAssertTrue([_source open:flacUrl], @"");
}

- (void) tearDown {
	[_source close];
	[super tearDown];
}

- (void) testFileSourceShouldReturnValidScheme {
	XCTAssertEqualObjects([FileSource scheme], @"file", @"");
}

- (void) testFileSourceShouldReturnValidUrl {
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	XCTAssertEqualObjects([_source url], flacUrl, @"");
}

- (void) testFileSourceShouldReturnCorrectSize {
	XCTAssertEqual([_source size], 4754L, @"");
}

- (void) testFileSourceShouldSeekToPositionWithWhenceAndTellCurrentPosition {
	XCTAssertTrue([_source seek:100 whence:SEEK_SET], @"");
	XCTAssertEqual([_source tell], 100L, @"");
	XCTAssertTrue([_source seek:100 whence:SEEK_CUR], @"");
	XCTAssertEqual([_source tell], 200L, @"");
	XCTAssertTrue([_source seek:0 whence:SEEK_END], @"");
	XCTAssertEqual([_source tell], 4754L, @"");
}

- (void) testFileSourceShouldReadData {
	void *buffer = malloc(100);
	XCTAssertEqual([_source read:buffer amount:100], 100, @"");
	free(buffer);
}

@end
