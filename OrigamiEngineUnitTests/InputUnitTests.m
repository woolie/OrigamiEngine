//
// InputUnitTests.m
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

#import "ORGMInputUnit.h"

@interface InputUnitTests : XCTestCase
@property (retain, nonatomic) ORGMInputUnit *inputUnit;
@end

@implementation InputUnitTests

- (void) setUp {
	[super setUp];
	_inputUnit = [[ORGMInputUnit alloc] init];
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	XCTAssertTrue([_inputUnit openWithUrl:flacUrl], @"");
}

- (void) tearDown {
	[_inputUnit close];
	[super tearDown];
}

- (void) testInputUnitShouldHaveCorrectAudioFormat {
	AudioStreamBasicDescription format = [_inputUnit format];
	XCTAssertEqual((NSInteger)format.mFormatID, kAudioFormatLinearPCM, @"");
	XCTAssertEqualWithAccuracy(format.mSampleRate, 44100.0, 0.1, @"");
	XCTAssertEqual((NSInteger)format.mBitsPerChannel, 16, @"");
	XCTAssertEqual((NSInteger)format.mChannelsPerFrame, 2, @"");
}

- (void) testInputUnitShouldHaveCorrectFramesCount {
	XCTAssertEqualWithAccuracy([_inputUnit framesCount], 162496.0, 0.1, @"");
}

- (void) testInputUnitShouldHaveMetadata {
	XCTAssertEqualObjects([_inputUnit metadata], @{@"artist": @"Artist 2"}, @"");
}

#if 0
- (void) testInputUnitShouldProcessData {
	[_inputUnit process];
	XCTAssertEqual(_inputUnit.data.length, 139264U, @"");
}

- (void) testInputUnitShouldSeekToTime {
	[_inputUnit seek:1];
	[_inputUnit process];
	XCTAssertEqual(_inputUnit.data.length, 132848U, @"");
}

- (void) testInputUnitShouldSetEndFlag {
	[_inputUnit seek:(([_inputUnit framesCount]/44100) - 0.01)];
	[_inputUnit process];
	XCTAssertTrue(_inputUnit.endOfInput, @"");
}

- (void) testInputUnitShouldNotExceedMaxAmountInBuffer {
	[_inputUnit process];
	NSUInteger _saveLength = _inputUnit.data.length;
	[_inputUnit process];
	XCTAssertEqual(_inputUnit.data.length, _saveLength, @"");
}

#endif
@end
