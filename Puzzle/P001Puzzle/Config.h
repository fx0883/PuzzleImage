

#import <Foundation/Foundation.h>

#define H_COUNT 4
#define V_COUNT 4
#define CARD_WIDTH  70
#define CARD_HEIGHT 70

CGImageRef currentImage;


typedef enum{
    DIR_LEFT = 1,
    DIR_UP = 2,
    DIR_RIGHT=3,
    DIR_DOWN=4,
    DIR_NONE=5
} Dir;

