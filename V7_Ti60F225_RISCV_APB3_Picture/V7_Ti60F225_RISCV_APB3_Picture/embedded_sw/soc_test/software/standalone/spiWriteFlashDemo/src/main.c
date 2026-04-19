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
* @file main.c: spiWriteFlashDemo
*
* @brief This demo shows how to write data to the SPI flash device on the development board. 
*        The software writes data starting at address 0x380000, which is the default 
*        location of the user binary in the flash device. 
*
******************************************************************************/
#include <stdint.h>
#include <stdio.h>
#include "bsp.h"
#include "spi.h"
#include "spiDemo.h"

//userBinary location
#define StartAddress 0x380000   


/*******************************************************************************
*
* @brief This function initialize the spi configuration setting based on the following
*        parameters. 
*
* @param
* - cpol: Clock polarity (0 or 1).
* - cpha: Clock phase (0 or 1).
* - mode: SPI mode 
*      0: Full-duplex dual line
*      1: Half-duplex dual line
*          (Available only when data width is configured as 8 or 16)
*      2: Half-duplex quad line
*          (Available only when data width is configured as 8 or 16)
*
* - clkDivider: Clock divider value. SPI frequency = FCLK/((clockDivider+1)*2)
*               FCLK is the system clock (io_systemClk) to the SoC. If
*               you enable the peripheral clock, then FCLK is driven by
*               the peripheral clock (io_peripheralClk) instead.
*
* - ssSetup: Slave select setup time. Clock cycle between activated chip-select and first
*            rising-edge of SCLK. Clock cycle refers to FCLK.
*
* - ssHold: Slave select hold time. Clock cycle between last falling-edge and deactivated
*           chip-select is activated. Clock cycle refers to FCLK.
*           
* - ssDisable: Slave select disable time.
*
******************************************************************************/
void init(){
    //SPI init
    Spi_Config spiA;
    spiA.cpol = 1;
    spiA.cpha = 1;
    //Assume full duplex (standard SPI)
    spiA.mode = 0; 
    spiA.clkDivider = 10;
    spiA.ssSetup = 5;
    spiA.ssHold = 5;
    spiA.ssDisable = 5;
    spi_applyConfig(SPI, &spiA);
}

/******************************************************************************
*
* @brief This function waits until the SPI flash is not busy.
*
******************************************************************************/
void WaitBusy(void)
{
    u8 out;
    u16 timeout=0;

    while(1)
    {
        bsp_uDelay(1*1000);
        spi_select(SPI, 0);
        //Write Enable
        spi_write(SPI, 0x05);   
        out = spi_read(SPI);
        spi_diselect(SPI, 0);
        if((out & 0x01) ==0x00)
            return;
        timeout++;
        //sector erase max=400ms
        if(timeout >=400)       
        {
            bsp_printf("Time out \r\n");
            return;
        }
    }
}

/******************************************************************************
*
* @brief This function enables the write latch of the SPI flash. 
*
******************************************************************************/
void WriteEnableLatch(void)
{
    spi_select(SPI, 0);
    //Write Enable latch
    spi_write(SPI, 0x06);   
    spi_diselect(SPI, 0);
}


/******************************************************************************
*
* @brief This function globally locks the SPI flash.  
*
******************************************************************************/
void GlobalLock(void)
{
    WriteEnableLatch();
    spi_select(SPI, 0);
    //Global lock
    spi_write(SPI, 0x7E);   
    spi_diselect(SPI, 0);
}

/******************************************************************************
*
* @brief This function globally unlocks the SPI flash.  
*
******************************************************************************/
void GlobalUnlock(void)
{
    WriteEnableLatch();
    spi_select(SPI, 0);
    //Global unlock
    spi_write(SPI, 0x98);   
    spi_diselect(SPI, 0);
}

/******************************************************************************
*
* @brief This function erases a sector of the SPI flash given an address. 
*
******************************************************************************/
void SectorErase(u32 Addr)
{
    WriteEnableLatch();
    spi_select(SPI, 0);     
    //Erase Sector
    spi_write(SPI, 0x20);
    spi_write(SPI, (Addr>>16)&0xFF);
    spi_write(SPI, (Addr>>8)&0xFF);
    spi_write(SPI, Addr&0xFF);
    spi_diselect(SPI, 0);
    WaitBusy();
}

/******************************************************************************
*
* @brief This main function demostrates the process of writing data to an SPI
*        flash memory. 
*
******************************************************************************/
void main() {
    init();
    int i,len;
    u8 out;
    //page write
    len =256;                                           // Define the length of data to write
    bsp_printf("spi 0 flash write start ! \r\n");
    GlobalUnlock();                                     // Unlock the flash memory to allow write operations
    SectorErase(StartAddress);                          // Erase the sector where the data will be written
    WriteEnableLatch();                                 // Enable the write latch of the flash memory
    spi_select(SPI, 0);                                 // Select the SPI device
    spi_write(SPI, 0x02);                               // Send the Page Program command (0x02) to the flash memory
    spi_write(SPI, (StartAddress>>16)&0xFF);            // Send the start address where the data will be written
    spi_write(SPI, (StartAddress>>8)&0xFF);
    spi_write(SPI, StartAddress&0xFF);
    //Write sequential number for testing
    for(i=0;i<len;i++)          
    {
        spi_write(SPI, i&0xFF);
        bsp_printf("WR Addr %x := %x \r\n", StartAddress+i, i&0xFF);
    }
    spi_diselect(SPI, 0);                               // Deselect the SPI device
    //wait for page progarm done
    WaitBusy();                                         // Wait for the write operation to complete
    GlobalLock();                                       // Lock the flash memory to prevent write operation
    bsp_printf("spi 0 flash write end ! \r\n");
    while(1){}                                          // Infinite loop to keep the program running
}
