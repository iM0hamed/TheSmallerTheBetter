#import <Foundation/Foundation.h>
#define HOOKED_BUNDLE [[NSBundle mainBundle] bundleIdentifier]
#define PREF_PLIST @"/var/mobile/Library/Preferences/com.pixelomer.tstbprefs.plist"
#define SHOULD_HOOK ((getPrefValue(HOOKED_BUNDLE) && getPrefValue(@"WorkReverse")) || (!getPrefValue(HOOKED_BUNDLE) && !getPrefValue(@"WorkReverse")))
#if !DEBUG
#define NSLog(...) //
#endif

inline bool getPrefValue(NSString *key)
{
	if ([[NSFileManager defaultManager] fileExistsAtPath:PREF_PLIST]) {
		NSDictionary *keys = [NSDictionary dictionaryWithContentsOfFile:PREF_PLIST];
		if ([keys objectForKey:key] != nil)
			return [[keys valueForKey:key] boolValue];
	}
	return false;
}

%ctor {
	NSLog(@"[TSTB] Hooking to %@", HOOKED_BUNDLE);
}

%hook UINavigationBar

-(bool)prefersLargeTitles {
	NSLog(@"[TSTB] Got called: prefersLargeTitles");
	if (SHOULD_HOOK && ![@"com.apple.springboard" isEqualToString:[HOOKED_BUNDLE lowercaseString]]) return false;
	else {
		NSLog(@"[TSTB] Not modifying the return value for %@", HOOKED_BUNDLE);
		return %orig;
	}
}

-(void)setPrefersLargeTitles:(bool)v1 {
	NSLog(@"[TSTB] Got called: setPreferLargeTitles:(bool)v1");
	if (SHOULD_HOOK && ![@"com.apple.springboard" isEqualToString:[HOOKED_BUNDLE lowercaseString]]) %orig(false);
	else {
		NSLog(@"[TSTB] Not modifying the function for %@", HOOKED_BUNDLE);
		%orig;
	}
}

%end