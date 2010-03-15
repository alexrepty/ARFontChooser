//
//  ARFontPickerViewController.m
//
//  Created by Alexander Repty on 15.03.10.
// 
//  Copyright (c) 2010, Alexander Repty
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//  Neither the name of Alexander Repty nor the names of his contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

#import "ARFontPickerViewController.h"

NSString *const kARFontPickerViewControllerCellIdentifier = @"ARFontPickerViewControllerCellIdentifier";

@interface ARFontPickerViewController (PrivateMethods)

- (NSString *)_fontFamilyForSection:(NSInteger)section;
- (NSString *)_fontNameForRow:(NSInteger)row inFamily:(NSString *)family;

@end

@implementation ARFontPickerViewController

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark UITableViewController methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *familyName = [self _fontFamilyForSection:section];
	return [[UIFont fontNamesForFamilyName:familyName] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self _fontFamilyForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kARFontPickerViewControllerCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kARFontPickerViewControllerCellIdentifier] autorelease];
    }
    
    NSString *familyName = [self _fontFamilyForSection:indexPath.section];
	NSString *fontName = [self _fontNameForRow:indexPath.row inFamily:familyName];
	UIFont *font = [UIFont fontWithName:fontName size:[UIFont smallSystemFontSize]];
	
	cell.textLabel.text = fontName;
	cell.textLabel.font = font;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (nil != _delegate) {
		NSString *familyName = [self _fontFamilyForSection:indexPath.section];
		NSString *fontName = [self _fontNameForRow:indexPath.row inFamily:familyName];
		[_delegate fontPickerViewController:self didSelectFont:fontName];
	}
}

#pragma mark -
#pragma mark Private methods

- (NSString *)_fontFamilyForSection:(NSInteger)section {
	@try {
		return [[UIFont familyNames] objectAtIndex:section];
	}
	@catch (NSException * e) {
		// ignore
	}
	return nil;
}

- (NSString *)_fontNameForRow:(NSInteger)row inFamily:(NSString *)family {
	@try {
		return [[UIFont fontNamesForFamilyName:family] objectAtIndex:row];
	}
	@catch (NSException * e) {
		// ignore
	}
	return nil;
}

@end

