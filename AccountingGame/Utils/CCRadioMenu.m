//
//  CCRadioMenu.m
//  AccountingGame
//
//  Created by 张超 on 13-9-10.
//
//

#import "CCRadioMenu.h"

@implementation CCRadioMenu

- (void)setSelectedItem_:(CCMenuItem *)item {
    [selectedItem_ unselected];
    selectedItem_ = item;    
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
 
    if ( state_ != kCCMenuStateWaiting ) return NO;
    
    CCMenuItem *curSelection = [self itemForTouch:touch];
    
    [curSelection selected];
    _curHighlighted = curSelection;
    
    if (_curHighlighted) {
        if (selectedItem_ != curSelection) {
            [selectedItem_ unselected];
        }
        state_ = kCCMenuStateTrackingTouch;
        return YES;
    }
    return NO;
    
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {

    NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchEnded] -- invalid state");
	
    CCMenuItem *curSelection = [self itemForTouch:touch];
    
    if (curSelection != _curHighlighted && curSelection != nil) {
        [selectedItem_ selected];
        [_curHighlighted unselected];
        _curHighlighted = nil;
        state_ = kCCMenuStateWaiting;
        return;
    } 
    
    selectedItem_ = _curHighlighted;
    [_curHighlighted activate];
    _curHighlighted = nil;
    
	state_ = kCCMenuStateWaiting;
    
}

- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
 
    NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchCancelled] -- invalid state");
	
	[selectedItem_ selected];
    [_curHighlighted unselected];
    _curHighlighted = nil;
	
	state_ = kCCMenuStateWaiting;
    
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchMoved] -- invalid state");
	
	CCMenuItem *curSelection = [self itemForTouch:touch];
    if (curSelection != _curHighlighted && curSelection != nil) {       
        [_curHighlighted unselected];
        [curSelection selected];
        _curHighlighted = curSelection;        
        return;
    }
    
}

-(CCMenuItem *) itemForTouch: (UITouch *) touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	CCMenuItem* item;
	CCARRAY_FOREACH(children_, item){
		// ignore invisible and disabled items: issue #779, #866
		if ( [item visible] && [item isEnabled] ) {
			
			CGPoint local = [item convertToNodeSpace:touchLocation];
			CGRect r = [item rect];
			r.origin = CGPointZero;
			
			if( CGRectContainsPoint( r, local ) )
				return item;
		}
	}
	return nil;
}


@end
