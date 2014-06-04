//
//  CCRadioMenu.h
//  AccountingGame
//
//  Created by 张超 on 13-9-10.
//
//

#import "cocos2d.h"

@interface CCRadioMenu : CCMenu {
    CCMenuItem *_curHighlighted;
}

- (void)setSelectedItem_:(CCMenuItem *)item;

@end
