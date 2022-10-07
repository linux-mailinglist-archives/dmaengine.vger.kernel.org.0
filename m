Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB15F78DC
	for <lists+dmaengine@lfdr.de>; Fri,  7 Oct 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJGNVS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJGNVR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 09:21:17 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA4F79E2ED;
        Fri,  7 Oct 2022 06:21:12 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 1104D44632;
        Fri,  7 Oct 2022 15:21:10 +0200 (CEST)
Message-ID: <c04fce1e-63b1-c698-4ac8-746617600f5c@gpxsee.org>
Date:   Fri, 7 Oct 2022 15:21:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V6 XDMA 0/2] xilinx XDMA driver
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com
Cc:     max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1664919839-27149-1-git-send-email-lizhi.hou@amd.com>
 <4e4481e9-0eb9-ac28-b9ff-348adb4dc866@gpxsee.org>
 <e04c498e-c3f5-9b0f-14cf-56057dd77d4e@amd.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <e04c498e-c3f5-9b0f-14cf-56057dd77d4e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06. 10. 22 19:42, Lizhi Hou wrote:
> 
> On 10/6/22 09:37, Martin Tůma wrote:
>> On 04. 10. 22 23:43, Lizhi Hou wrote:
>>> Hello,
>>>
>>> This V6 of patch series is to provide the platform driver to support the
>>> Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with 
>>> the
>>> PCI Express IP block to provide high performance data transfer 
>>> between host
>>> memory and the card's DMA subsystem. It also provides up to 16 user
>>> interrupt wires to user logic that generate interrupts to the host.
>>>
>>>              +-------+       +-------+       +-----------+
>>>     PCIe     |       |       |       |       |           |
>>>     Tx/Rx    |       |       |       |  AXI  |           |
>>>   <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
>>>              |       |       |       |       |           |
>>>              +-------+       +-------+       +-----------+
>>>
>>> The XDMA has been used for Xilinx Alveo PCIe devices.
>>> And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
>>>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>>> https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems
>>>
>>> The device driver for any FPGA based PCIe device which leverages XDMA 
>>> can
>>> call the standard dmaengine APIs to discover and use the XDMA subsystem
>>> without duplicating the XDMA driver code in its own driver.
>>>
>>> Changes since v5:
>>> - Modified user logic interrupt APIs to handle user logic IP which 
>>> does not
>>>    have its own register to enable/disable interrupt.
>>> - Clean up code based on review comments.
>>>
>>> Changes since v4:
>>> - Modified user logic interrupt APIs.
>>>
>>> Changes since v3:
>>> - Added one patch to support user logic interrupt.
>>>
>>> Changes since v2:
>>> - Removed tasklet.
>>> - Fixed regression bug introduced to V2.
>>> - Test Robot warning.
>>>
>>> Changes since v1:
>>> - Moved filling hardware descriptor to xdma_prep_device_sg().
>>> - Changed hardware descriptor enum to "struct xdma_hw_desc".
>>> - Minor changes from code review comments.
>>>
>>> Lizhi Hou (2):
>>>    dmaengine: xilinx: xdma: Add xilinx xdma driver
>>>    dmaengine: xilinx: xdma: Add user logic interrupt support
>>>
>>>   MAINTAINERS                            |   11 +
>>>   drivers/dma/Kconfig                    |   13 +
>>>   drivers/dma/xilinx/Makefile            |    1 +
>>>   drivers/dma/xilinx/xdma-regs.h         |  171 ++++
>>>   drivers/dma/xilinx/xdma.c              | 1034 ++++++++++++++++++++++++
>>>   include/linux/dma/amd_xdma.h           |   16 +
>>>   include/linux/platform_data/amd_xdma.h |   34 +
>>>   7 files changed, 1280 insertions(+)
>>>   create mode 100644 drivers/dma/xilinx/xdma-regs.h
>>>   create mode 100644 drivers/dma/xilinx/xdma.c
>>>   create mode 100644 include/linux/dma/amd_xdma.h
>>>   create mode 100644 include/linux/platform_data/amd_xdma.h
>>>
>>
>> Hi,
>> I have rewritten our V4L2 driver to use this new XDMA driver, but it 
>> does not work on our HW (where the previous Xilinx XDMA driver derived 
>> from the Xilinx sample code worked fine). The driver is sucessfully 
>> loaded and 4(2+2) DMA channels are successfully created. But when a 
>> DMA transfer is initiated, I get an error from my PC's DMA chip:
>>
>> AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000a address=0x36a00000 
>> flags=0x0000]
>>
>> and no error from XDMA.
>>
>> Does the driver expect some special FPGA IP core configuration? Or is 
>> there something else I'm missing? My code is quiet similar to what you 
>> use in your XRT repo on GitHub (there is btw. a bug in the XRT code - 
>> you do not clear the dma_slave_config struct before using) but in my 
>> case the DMA transfer triggers the AMD-Vi error and timeouts.
>>
>> The code of our driver is attached, the relevant parts are in mgb4_dma.c
>> and mgb4_core.c.
>>
>> M.
> 
> Hi Martin,
> 
> Thanks for trying this and got a lot thing works. I have read your 
> driver. Could you call pci_map_sg() before calling prep_sg()? (and 
> pci_unmap_sg()) after transfer complete?
> 
> example: 
> https://github.com/houlz0507/XRT-1/blob/xdma_v4_usage/src/runtime_src/core/pcie/driver/linux/xocl/subdev/xdma.c#L103
> 
> 
> Thanks,
> 
> Lizhi
> 

Hi,
That's not the problem, the sg is already mapped by V4L2 videobuf-dma-sg
(https://elixir.bootlin.com/linux/v6.0/source/drivers/media/v4l2-core/videobuf-dma-sg.c#L285). 
With the original XDMA driver I was also not mapping the sg and it 
worked fine. And yes, I have tried it anyway and it didn't help ;-)

So there must be some other problem in your XDMA driver.

M.
