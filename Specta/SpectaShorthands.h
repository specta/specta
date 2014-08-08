// these functions are not actually implemented, but are present here to aid code-completion

void  describe(NSString *name, void (^block)());
void fdescribe(NSString *name, void (^block)());
void   context(NSString *name, void (^block)());
void  fcontext(NSString *name, void (^block)());

void       it(NSString *name, void (^block)());
void      fit(NSString *name, void (^block)());
void  example(NSString *name, void (^block)());
void fexample(NSString *name, void (^block)());
void  specify(NSString *name, void (^block)());
void fspecify(NSString *name, void (^block)());

void  beforeAll(void (^block)());
void   afterAll(void (^block)());
void     before(void (^block)());
void      after(void (^block)());
void beforeEach(void (^block)());
void  afterEach(void (^block)());

void sharedExamplesFor(NSString *name, void (^block)(NSDictionary *data));
void    sharedExamples(NSString *name, void (^block)(NSDictionary *data));

void itShouldBehaveLike(NSString *name, id dictionaryOrBlockOrNil);
void      itBehavesLike(NSString *name, id dictionaryOrBlockOrNil);

void waitUntil(void (^block)(DoneCallback done));

void setAsyncSpecTimeout(NSTimeInterval timeout);

// ---

#define  describe spt_describe
#define fdescribe spt_fdescribe
#define   context spt_describe
#define  fcontext spt_fcontext

#define       it spt_it
#define      fit spt_fit
#define  example spt_it
#define fexample spt_fit
#define  specify spt_it
#define fspecify spt_fit

#define   pending(...) spt_pending_(__VA_ARGS__, nil)
#define xdescribe(...) spt_pending_(__VA_ARGS__, nil)
#define  xcontext(...) spt_pending_(__VA_ARGS__, nil)
#define  xexample(...) spt_pending_(__VA_ARGS__, nil)
#define       xit(...) spt_pending_(__VA_ARGS__, nil)
#define  xspecify(...) spt_pending_(__VA_ARGS__, nil)

#define  beforeAll spt_beforeAll
#define   afterAll spt_afterAll
#define     before spt_beforeEach
#define      after spt_afterEach
#define beforeEach spt_beforeEach
#define  afterEach spt_afterEach

#define sharedExamplesFor spt_sharedExamplesFor
#define    sharedExamples spt_sharedExamplesFor

#define itShouldBehaveLike(...) spt_itShouldBehaveLike_(@(__FILE__), __LINE__, __VA_ARGS__)
#define      itBehavesLike(...) spt_itShouldBehaveLike_(@(__FILE__), __LINE__, __VA_ARGS__)

#define setAsyncSpecTimeout spt_setAsyncSpecTimeout
#define waitUntil spt_waitUntil