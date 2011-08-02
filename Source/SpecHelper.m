#import "SpecHelper.h"

@interface SpecHelper ()
@property (nonatomic, retain, readwrite) NSMutableDictionary *sharedExampleGroups, *sharedExampleContext;
@end

static SpecHelper *specHelper__;

@implementation SpecHelper

@synthesize sharedExampleGroups = sharedExampleGroups_, sharedExampleContext = sharedExampleContext_;
@synthesize globalBeforeEachClasses = globalBeforeEachClasses_, globalAfterEachClasses = globalAfterEachClasses_;

+ (id)specHelper {
    if (!specHelper__) {
        specHelper__ = [[SpecHelper alloc] init];
    }
    return specHelper__;
}

- (id)init {
    if (self = [super init]) {
        self.sharedExampleGroups = [NSMutableDictionary dictionary];
        self.sharedExampleContext = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    [sharedExampleGroups_ release];
    [sharedExampleContext_ release];
    [globalBeforeEachClasses_ release];
    [globalAfterEachClasses_ release];

    [super dealloc];
}

#pragma mark CDRExampleParent
- (void)setUp {
    [self.sharedExampleContext removeAllObjects];

    if ([self respondsToSelector:@selector(beforeEach)]) {
        NSLog(@"********************************************************************************");
        NSLog(@"Cedar no longer runs beforeEach blocks defined on the SpecHelper class.\n");
        NSLog(@"Rather than defining a global beforeEach on the SpecHelper instance,");
        NSLog(@"declare a +beforeEach class method on a separate spec-specific class.");
        NSLog(@"This allows for more than one beforeEach without them overwriting one another.");
        NSLog(@"********************************************************************************");
    }

    [self.globalBeforeEachClasses makeObjectsPerformSelector:@selector(beforeEach)];
}

- (void)tearDown {
    if ([self respondsToSelector:@selector(afterEach)]) {
        NSLog(@"********************************************************************************");
        NSLog(@"Cedar no longer runs afterEach blocks defined on the SpecHelper class.\n");
        NSLog(@"Rather than defining a global afterEach on the SpecHelper instance,");
        NSLog(@"declare an +afterEach class method on a separate spec-specific class.");
        NSLog(@"This allows for more than one afterEach without them overwriting one another.");
        NSLog(@"********************************************************************************");
    }

    [self.globalAfterEachClasses makeObjectsPerformSelector:@selector(afterEach)];
}

@end