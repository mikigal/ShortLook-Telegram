#import "TelegramContactPhotoProvider.h"

@implementation TelegramContactPhotoProvider

- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *apps = [fileManager contentsOfDirectoryAtPath:@"/private/var/mobile/Containers/Shared/AppGroup/" error:Nil];
    NSString *telegramPath = nil;
    for (int i = 0; i < [apps count]; i++) {
        if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"/private/var/mobile/Containers/Shared/AppGroup/%@/telegram-data/", [apps objectAtIndex: i]]]) {
            telegramPath = [apps objectAtIndex: i];
            break;
        }
    }

    NSDictionary *info = [notification applicationUserInfo];
    NSString *imagePath = [NSString stringWithFormat:@"/private/var/mobile/Containers/Shared/AppGroup/%@/telegram-data/accounts-metadata/spotlight/p:%@/avatar.png", telegramPath, [info objectForKey:@"from_id"]];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

    return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerInstantlyResolvingPromiseWithPhotoIdentifier:imagePath image:image];
}

@end