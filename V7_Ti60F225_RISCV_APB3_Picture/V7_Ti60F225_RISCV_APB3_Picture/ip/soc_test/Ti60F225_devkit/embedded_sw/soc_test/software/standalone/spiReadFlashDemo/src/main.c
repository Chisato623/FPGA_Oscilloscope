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
* @file main.c: spiReadFlashDemo
*
* @brief This demo shows how to read data from the SPI flash device on the development board. 
*        The software reads 124K of data starting at address 0x380000, which is the default 
*        location of the user binary in the flash device. 
*
******************************************************************************/

#include <stdint.h>
#include "bsp.h"
#include "spi.h"
#include "spiDemo.h"

//User Binary Location
#define StartAddress    0x380000    
//Read size
#define ReadSize        124*1024

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
* @brief Main function for SPI 0 flash read demo
*
* @note This function initializes the system, reads data from SPI flash starting from a specific address and for a specified length.
*
******************************************************************************/
void main() {
    // Initialize the system
    init();
    int i,len;
    len = ReadSize;

    bsp_printf("spi 0 flash read start ! \r\n");

    for(i=StartAddress;i<StartAddress+len;i++)
    {
        // Select SPI device
        spi_select(SPI, 0);
        // Send read command (0x03) and address to SPI flash
        spi_write(SPI, 0x03);
        spi_write(SPI, (i>>16)&0xFF);
        spi_write(SPI, (i>>8)&0xFF);
        spi_write(SPI, i&0xFF);
        // Read data from SPI flash
        uint8_t out = spi_read(SPI);
        // Deselect SPI device
        spi_diselect(SPI, 0);
        // Print the read address and data
        bsp_printf("Addr %x := %x \r\n", i, out);
    }
    bsp_printf("spi 0 flash read end ! \r\n");
    while(1) {
        // Infinite loop to keep the program running
    }
}

