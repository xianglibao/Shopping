//
//  Protocol.h
//  shopping
//
//  Created by chentao on 16/1/7.
//  Copyright © 2016年 gof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCartDetail.h"
#import "CategoryInfo.h"
#import "Address.h"
#import "DeliveryTimeInfo.h"
#import "CodeInfo.h"

@protocol shoppingCartDelegate <NSObject>

- (void)refreshShoppingCart;

@end

@protocol AddressDelegate <NSObject>

- (void)AddressReload;

@end

@protocol goodCellDelegate <NSObject>

- (void)addToShoppingCart:(Good*)good;

@end

@protocol goodSectionHeaderDelegate <NSObject>

- (void)showAll:(CategoryInfo*)category;

@end

@protocol LoginDelegate <NSObject>

- (void)AfterLoginSuccess;

@end

@protocol ShoppingCartCellDelegate <NSObject>

- (void)addClick:(ShoppingCartDetail*)shoppingCartDetail;
- (void)cutClick:(ShoppingCartDetail*)shoppingCartDetail;
- (void)selectClick:(ShoppingCartDetail*)shoppingCartDetail;
- (void)goodImageClick:(ShoppingCartDetail*)shoppingCartDetail;

@end

@protocol EditUserDelegate <NSObject>

- (void)reloadUser;

@end

@protocol ChangeAddressDelegate <NSObject>

- (void)changeAddress:(Address*)address;

@end

@protocol DeliveryTimeDelegate <NSObject>

- (void)deliveryTimeSelected:(DeliveryTimeInfo*)deliveryTime;

@end

@protocol SearchAddressDelegate <NSObject>

- (void)addressSelected:(NSString *)address;

@end

@protocol PayDelegate <NSObject>

- (void)afterPaySuccess;

@end

@protocol ServicePhoneDelegate <NSObject>

- (void)servicePhoneCall:(CodeInfo *)codeInfo;

@end

