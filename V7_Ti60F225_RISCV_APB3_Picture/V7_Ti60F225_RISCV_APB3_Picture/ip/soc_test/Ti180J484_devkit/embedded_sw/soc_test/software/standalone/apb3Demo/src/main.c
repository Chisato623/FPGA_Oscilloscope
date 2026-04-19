////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2023 Efinix Inc. All rights reserved.              
//
// This   document  contains  proprietary information  which   is        
// protected by  copyright. All rights  are reserved.  This notice       
// refers to original work by Efinix, Inc. which may be derivitive       
// of other work distributed under license of the authors.  In the       
// case of derivative work, nothing in this notice overrides the         
// original author's license agreement.  Where applicable, the           
// original license agreement is included in it's original               
// unmodified form immediately below this header.                        
//                                                                       
// WARRANTY DISCLAIMER.                                                  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND        
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH               
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES,  
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF          
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR    
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED       
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.           
//                                                                       
// LIMITATION OF LIABILITY.                                              
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY       
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT    
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY   
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT,      
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY    
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF      
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR   
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN    
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER    
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR            
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT   
//     APPLY TO LICENSEE.                                                
//
////////////////////////////////////////////////////////////////////////////////

/******************************************************************************
*
* @file main.c: apb3Demo
*
* @brief This demo shows how to use an APB3 slave peripheral where APB3 slave is 
*        attached to a pseudorandom number generator. When user run the application, 
*        the Sapphire SoC programs the APB3 slave to stop generating a new random
*        number and reads the last random number generated. The test passes if the 
*        returned data is a non-zero value.
*
* @note Please ensure APB3 is enabled in Sapphire Soc. 
*
******************************************************************************/
#include <stdint.h>
#include "bsp.h"
#include "apb3_cl.h"

#ifdef IO_APB_SLAVE_0_INPUT

    #define APB0    IO_APB_SLAVE_0_INPUT

#endif


/*******************************************************************************
*
* @brief This function prints error message on terminal and enters an infinite loop
*         to halt the program's execution.
*
******************************************************************************/
void error_state() {
    bsp_printf("Failed! \r\n");
    while (1) {}
}


/*******************************************************************************
*
* @brief This main function initialize the system and stop APB3 from generating a
*        new random number and read the value from APB3 slave. The result is passed
*        if the return value is non-zero. 
*
******************************************************************************/
void main() {
    struct ctrl_reg cfg0={0};
    u32 data = 0;    

    bsp_init();

#ifdef IO_APB_SLAVE_0_INPUT

    bsp_printf("apb3 slave 0 demo ! \r\n");
    cfg0.lfsr_stop = 1;
    apb3_ctrl_write(APB0, &cfg0);
    data = apb3_read(APB0);
    bsp_printf("Random number: 0x%x \r\n", data);
    if(data == 0x0)
        error_state();
    else
        bsp_printf("Passed! \r\n");

#else

    bsp_printf("apb3 Slave 0 is disabled, please enable it to run this app. \r\n");

#endif

}

