//
// OutputUnitTests.m
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

#import "ORGMConverter.h"
#import "ORGMInputUnit.h"
#import "ORGMOutputUnit.h"

@interface OutputUnitTests : XCTestCase
@property (retain, nonatomic) ORGMOutputUnit *outputUnit;
@end

@implementation OutputUnitTests

- (void) setUp {
	[super setUp];
	ORGMInputUnit *input = [[ORGMInputUnit alloc] init];
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	[input openWithUrl:flacUrl];
	ORGMConverter *converter = [[ORGMConverter alloc] initWithInputUnit:input];
		
	_outputUnit = [[ORGMOutputUnit alloc] initWithConverter:converter];
	[converter setupWithOutputUnit:_outputUnit];
}

- (void) testOutputUnitShouldHaveValidFormat {
	AudioStreamBasicDescription format = [_outputUnit format];
	XCTAssertEqual((NSInteger)format.mChannelsPerFrame, 2, @"");
	XCTAssertEqual((NSInteger)format.mBytesPerFrame, 4, @"");
	XCTAssertEqual((NSInteger)format.mBytesPerPacket, 4, @"");
}

- (void) testOutputUnitShouldReturnAmountPlayed {
	XCTAssertEqualWithAccuracy([_outputUnit amountPlayed], 0.0, 0.1, @"");
}

- (void) testOutputUnitShouldConvertFramesToSeconds {
	double seconds = [_outputUnit framesToSeconds:10000];
	XCTAssertEqualWithAccuracy(seconds, 0.2267, 0.1, @"");
}

- (void) testOutputUnitShouldChangePlayedTimeAfterSeek {
	[_outputUnit seek:10.0];
	XCTAssertEqualWithAccuracy([_outputUnit amountPlayed], 10.0, 0.1, @"");
}

@end
