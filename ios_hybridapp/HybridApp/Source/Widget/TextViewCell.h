//
//  TextViewCell.h
//  SalesManager
//
//  Created by liu xueyan on 8/1/13.
//  Copyright (c) 2013 liu xueyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceTextView.h"

@interface TextViewCell : UITableViewCell{

    PlaceTextView *textView;

}

@property(nonatomic,retain) PlaceTextView *textView;

@end
