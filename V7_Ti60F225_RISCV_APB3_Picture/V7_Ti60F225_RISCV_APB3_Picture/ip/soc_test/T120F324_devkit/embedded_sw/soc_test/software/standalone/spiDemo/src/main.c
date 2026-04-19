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
* @file main.c: spiDemo
*
* @brief This demo provides example code for reading the device ID and JEDEC ID of the SPI flash 
*        device on the development board. The application displays the results on a UART terminal. 
*        It continues to print to the terminal until you suspend or stop the application.
*
* @note
*   The default base address map of the SPI flash master is 0xF801_4000.
*   The default SCK frequency is half of the SoC system clock frequency.
*   The default base address of the UART is 0xF801_0000 with a default baud rate of 115200.
*
******************************************************************************/
#include <stdint.h>
#include "bsp.h"
#include "spi.h"
#include "spiDemo.h"

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
    spiA.mode = 0; //Assume full duplex (standard SPI)
    spiA.clkDivider = 10;
    spiA.ssSetup = 5;
    spiA.ssHold = 5;
    spiA.ssDisable = 5;
    spi_applyConfig(SPI, &spiA);
}

/******************************************************************************
*
* @brief This main function initializes the SPI interface, selects the SPI device, 
*        writes commands and reads device ID and status command response in a 
*        continuous loop.
*
******************************************************************************/
void main() {
    // Initialize the system
    init();

    bsp_printf("spi 0 demo ! \r\n");

    // Select SPI device
    spi_select(SPI, 0);

    // Send write commands
    spi_write(SPI, 0xAB);
    spi_write(SPI, 0x00);
    spi_write(SPI, 0x00);
    spi_write(SPI, 0x00);

    // Read the device ID
    uint8_t id = spi_read(SPI);

    // Deselect SPI device
    spi_diselect(SPI, 0);

    bsp_printf("Device ID : %x \r\n", id);

    while(1){
        uint8_t data[3];

        // Select SPI device
        spi_select(SPI, 0);

        // Send command 0x9F to SPI device
        spi_write(SPI, 0x9F);

        // Read the response
        data[0] = spi_read(SPI);
        data[1] = spi_read(SPI);
        data[2] = spi_read(SPI);

        // Deselect SPI device
        spi_diselect(SPI, 0);

        // Print the response
        bsp_printf("CMD 0x9F : %x \r\n", data[2] | data[1] << 8 | data[0] << 16);
    }
}

