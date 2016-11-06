//
//  intrinsics.h
//  Graphene
//
//  Created by Kodama Yoshinori on 12/24/14.
//  Copyright (c) 2014 Yoshinori Kodama. All rights reserved.
//

#ifndef __Graphene__intrinsics__
#define __Graphene__intrinsics__

#include <stdio.h>
#include <stdint.h>

extern unsigned int _bitScanForward(uint64_t board);
extern unsigned int _bitPop(uint64_t board);

#endif /* defined(__Graphene__intrinsics__) */
