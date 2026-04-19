///////////////////////////////////////////////////////////////////////////////////
//  MIT License
//  
//  Copyright (c) 2023 SaxonSoc contributors
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
///////////////////////////////////////////////////////////////////////////////////

/******************************************************************************
*
* @file main.c: coreTimerInterruptDemo
*
* @brief This demo shows how to use the core timer and its interrupt function.
*        This demo configures the core timer to generate an interrupt every 1
*        second. It prints messages on a terminal when the SoC is interrupted 
*        by the core timer.
*
******************************************************************************/

#include <stdint.h>
#include "bsp.h"
#include "clint.h"
#include "riscv.h"
#include "gpio.h"
#include "plic.h"

#ifdef SIM
    //Faster timer tick in simulation to avoid having to wait too long
    #define TIMER_TICK_DELAY (SYSTEM_CLINT_HZ/200) 
#else
    #define TIMER_TICK_DELAY (SYSTEM_CLINT_HZ)
#endif

void init();
void main();
void trap();
void crash();
void trap_entry();
void timerInterrupt();
void initTimer();
void scheduleTimer();

//Store the next interrupt time
uint64_t timerCmp; 

/******************************************************************************
*
* @brief This main function initialize the system and waiting to be interrupted
*        by the core timer.
*
******************************************************************************/
void main() {
    init();
    bsp_printf("core timer interrupt demo ! \r\n");
    while(1); //Idle
}

/******************************************************************************
*
* @brief This function initialize timer and enable machine timer interrupts. 
*
******************************************************************************/
void init(){
    //configure PLIC
    //cpu 0 accept all interrupts with priority above 0
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); 
    //configure timer
    initTimer();
    //enable interrupts
    //Set the machine trap vector (../common/trap.S)
    csr_write(mtvec, trap_entry); 
    //Enable machine timer interrupts
    csr_set(mie, MIE_MTIE); 
    csr_write(mstatus, csr_read(mstatus) | MSTATUS_MPP | MSTATUS_MIE);
}

/******************************************************************************
*
* @brief This function initialize timer.  
*
******************************************************************************/
void initTimer(){
    timerCmp = clint_getTime(BSP_CLINT);
    scheduleTimer();
}


/******************************************************************************
*
* @brief This function make the timer tick in 1 second.
*
* @note For simulation, the timer tick faster as to avoid having to wait too long. 
*
******************************************************************************/
void scheduleTimer(){
    timerCmp += TIMER_TICK_DELAY;
    clint_setCmp(BSP_CLINT, timerCmp, 0);
}


/******************************************************************************
*
* @brief This function handles exceptions and interrupts in the system.
*
* @note It is called by the trap_entry function on both exceptions and interrupts 
* 		events. If the cause of the trap is an interrupt, it checks the cause of 
* 		the interrupt and calls corresponding interrupt handler functions. If 
* 		the cause is an exception or an unhandled interrupt, it calls a 
*		crash function to handle the error.
*
******************************************************************************/
void trap(){
    int32_t mcause = csr_read(mcause);
    int32_t interrupt = mcause < 0;    //Interrupt if true, exception if false
    int32_t cause     = mcause & 0xF;
    if(interrupt){
        switch(cause){
        case CAUSE_MACHINE_TIMER: timerInterrupt(); break;
        default: crash(); break;
        }
    } else {
        crash();
    }
}

/******************************************************************************
*
* @brief This function handles the timer interrupt event. 
*
******************************************************************************/
void timerInterrupt(){
    static uint32_t counter = 0;
    scheduleTimer();
    bsp_printf("core timer interrupt %d \r\n", counter);
    if(++counter == 10) counter = 0;
}

/******************************************************************************
*
* @brief This function handles the system crash scenario by printing a crash message
* 		 and entering an infinite loop.
*
******************************************************************************/
void crash(){
    bsp_printf("\r\n*** CRASH ***\r\n");
    while(1);
}

