//
// ConverterUnitTests.m
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

#if 0
@interface ConverterUnitTests : XCTestCase
@property (retain, nonatomic) ORGMConverter *converter;
@end

@implementation ConverterUnitTests

- (void) setUp
{
	[super setUp];
	ORGMInputUnit *input = [[ORGMInputUnit alloc] init];
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	[input openWithUrl:flacUrl];
	_converter = [[ORGMConverter alloc] initWithInputUnit:input];
	
	ORGMOutputUnit *output = [[ORGMOutputUnit alloc] initWithConverter:_converter];
	XCTAssertTrue([_converter setupWithOutputUnit:output], @"");
}

- (void) testConverterUnitShouldHaveValidInputUnit {
	XCTAssertNotNil(_converter.inputUnit, @"");
}

- (void) testConverterUnitShouldHaveValidOutputUnit {
	XCTAssertNotNil(_converter.outputUnit, @"");
}

- (void) testConverterUnitShouldProcessData {
	[_converter.inputUnit process];
	[_converter process];
	XCTAssertEqual(_converter.convertedData.length, 131072U, @"");
}

- (void) testInputUnitShouldNotExceedMaxAmountInBuffer {
	[_converter.inputUnit process];
	[_converter process];
	NSUInteger _saveLength = _converter.convertedData.length;
	[_converter.inputUnit process];
	[_converter process];
	XCTAssertEqual(_converter.convertedData.length, _saveLength, @"");
}

- (void) testConverterUnitshouldReinitWithNewInputUnit {
	[_converter.inputUnit process];
	[_converter process];
	NSUInteger _saveLength = _converter.convertedData.length;
	
	ORGMInputUnit *input = [[ORGMInputUnit alloc] init];
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	[input openWithUrl:flacUrl];
	[_converter reinitWithNewInput:input withDataFlush:NO];
	
	XCTAssertEqual(_converter.inputUnit, input, @"");
	XCTAssertEqual(_converter.convertedData.length, _saveLength, @"");
}

- (void) testConverterUnitshouldReinitWithNewInputUnitAndFlushData {
	[_converter.inputUnit process];
	[_converter process];
	
	ORGMInputUnit *input = [[ORGMInputUnit alloc] init];
	NSURL *flacUrl = [[NSBundle bundleForClass:self.class] URLForResource:@"multiple-vc"
															withExtension:@"flac"];
	[input openWithUrl:flacUrl];
	[_converter reinitWithNewInput:input withDataFlush:YES];
	
	XCTAssertEqual(_converter.inputUnit, input, @"");
	XCTAssertEqual(_converter.convertedData.length, 0U, @"");
}

@end
#endif
