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
* @file main.c: userTimerDemo
*
* @brief This demo shows how to use the user timer and its interrupt function. 
*        This demo configures the user timer and its prescaler setting, which 
*        user used to further scale down the frequency used by the timer's counter.
*        When the timer's counter reaches the targeted tick value, it generates 
*        an interrupt signal to interrupt the controller to let the SoC jump from 
*        the main routine to the interrupt routine.
*
******************************************************************************/
#include <stdint.h>
#include "bsp.h"
#include "prescaler.h"
#include "timer.h"
#include "userTimerDemo.h"
#include "riscv.h"
#include "plic.h"

#ifdef SYSTEM_USER_TIMER_0_CTRL 

    #define TIMER_PRESCALER_CTRL            (TIMER_CTRL + 0x00)
    #define TIMER_0_CTRL                    (TIMER_CTRL +  0x40)
    #define TIMER_CONFIG_WITH_PRESCALER     0x2
    #define TIMER_CONFIG_WITHOUT_PRESCALER  0x1
    #define TIMER_CONFIG_SELF_RESTART       0x10000

#ifdef SIM
    #define TIMER_TICK_DELAY (BSP_CLINT_HZ/200) //Faster timer tick in simulation to avoid having to wait too long
#else
    #define TIMER_TICK_DELAY (BSP_CLINT_HZ)
#endif

void init();
void main();
void trap();
void crash();
void trap_entry();
void timerInterrupt();
void externalInterrupt();
void initTimer();

/******************************************************************************
*
* @brief This function initializes user timer interrupts and enables external interrupts
*        by setting up the machine trap vector. 
*
******************************************************************************/
void init(){
    //configure timer
    initTimer();

    //configure PLIC
    plic_set_threshold(BSP_PLIC, BSP_PLIC_CPU_0, 0); //cpu 0 accept all interrupts with priority above 0

    //enable Timer 0 interrupts
    plic_set_enable(BSP_PLIC, BSP_PLIC_CPU_0, SYSTEM_PLIC_TIMER_INTERRUPTS_0, 1);
    plic_set_priority(BSP_PLIC, SYSTEM_PLIC_TIMER_INTERRUPTS_0, 1);

    //enable interrupts
    csr_write(mtvec, trap_entry); //Set the machine trap vector (../common/trap.S)
    csr_set(mie, MIE_MEIE); //Enable machine timer and external interrupts
    csr_write(mstatus, csr_read(mstatus) | MSTATUS_MPP | MSTATUS_MIE);
}

uint64_t timerCmp; //Store the next interrupt time

/******************************************************************************
*
* @brief This function initializes user timer by setting up the prescaler value. 
*
******************************************************************************/
void initTimer(){
    //Divide clock rate by 99+1
    prescaler_setValue(TIMER_PRESCALER_CTRL, 99); 
    //Will tick each (999+1)*(99+1) cycles (as it use the prescaler)
    timer_setConfig(TIMER_0_CTRL, TIMER_CONFIG_WITH_PRESCALER | TIMER_CONFIG_SELF_RESTART);
    timer_setLimit(TIMER_0_CTRL, 999); 
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
        case CAUSE_MACHINE_EXTERNAL: externalInterrupt(); break;
        default: crash(); break;
        }
    } else {
        crash();
    }
}

/******************************************************************************
*
* @brief This function handles user timer interrupt by claiming pending interrupts 
* 		 and print message on terminal regarding the interrupt routine. 
*
******************************************************************************/
void externalInterrupt(){
    uint32_t claim;
    //While there is pending interrupts
    while(claim = plic_claim(BSP_PLIC, BSP_PLIC_CPU_0)){
        switch(claim){
        case SYSTEM_PLIC_TIMER_INTERRUPTS_0: bsp_printf("user timer 0 interrupt routine \r\n"); break;
        default: crash(); break;
        }
        //unmask the claimed interrupt
        plic_release(BSP_PLIC, BSP_PLIC_CPU_0, claim); 
    }
}

/******************************************************************************
*
* @brief This function handles the system crash scenario by printing a crash 
* 		 message and entering an infinite loop.
*
******************************************************************************/
void crash(){
    bsp_printf("\r\n*** CRASH ***\r\n");
    while(1);
}

/******************************************************************************
*
* @brief This main function intialize the system and then prints a message 
*        indicating that the user timer 0 demo is starting.
*
******************************************************************************/
void main() {
    bsp_init();
    bsp_printf("user timer 0 demo ! \r\n");
    init();
    while(1); 
}

#else
void trap(){
}

/******************************************************************************
*
* @brief This main function is executed when I2C functionality is disabled.
*        It initializes the BSP and prints a message indicating that
*        I2C 0 is disabled, and the user should enable it to run the app.
*
******************************************************************************/
void main() {
    bsp_init();
    bsp_printf("user timer 0 is disabled, please enable it to run this app \r\n");
}
#endif

