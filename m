Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F663CED5
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 06:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiK3Fsj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 00:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiK3Fsj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 00:48:39 -0500
X-Greylist: delayed 389 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 21:48:34 PST
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F107D52173
        for <dmaengine@vger.kernel.org>; Tue, 29 Nov 2022 21:48:34 -0800 (PST)
Received: from [192.168.42.220] (62-nat1-1.centrio.cz [217.195.172.62])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 94F04353FD;
        Wed, 30 Nov 2022 06:42:03 +0100 (CET)
Message-ID: <0aa32a6f-2ec1-4ba8-ce62-2e998bc8c93a@gpxsee.org>
Date:   Wed, 30 Nov 2022 06:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RESEND PATCH V10 XDMA 0/2] xilinx XDMA driver
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1669137709-22028-1-git-send-email-lizhi.hou@amd.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <1669137709-22028-1-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22. 11. 22 18:21, Lizhi Hou wrote:
> Hello,
> 
> This V10 of patch series is to provide the platform driver to support the
> Xilinx XDMA subsystem. The XDMA subsystem is used in conjunction with the
> PCI Express IP block to provide high performance data transfer between host
> memory and the card's DMA subsystem. It also provides up to 16 user
> interrupt wires to user logic that generate interrupts to the host.
> 
>              +-------+       +-------+       +-----------+
>     PCIe     |       |       |       |       |           |
>     Tx/Rx    |       |       |       |  AXI  |           |
>   <=======>  | PCIE  | <===> | XDMA  | <====>| User Logic|
>              |       |       |       |       |           |
>              +-------+       +-------+       +-----------+
> 
> The XDMA has been used for Xilinx Alveo PCIe devices.
> And it is also integrated into Versal ACAP DMA and Bridge Subsystem.
>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>      https://docs.xilinx.com/r/en-US/pg344-pcie-dma-versal/Introduction-to-the-DMA-and-Bridge-Subsystems
> 
> The device driver for any FPGA based PCIe device which leverages XDMA can
> call the standard dmaengine APIs to discover and use the XDMA subsystem
> without duplicating the XDMA driver code in its own driver.
> 
> Changes since v9:
> - Cleanup code based on review comments.
> 
> Changes since v8:
> - Fixed test robot failure on s390.
> 
> Changes since v7:
> - Used pci device pointer for dma_pool_create().
> 
> Changes since v6:
> - Fixed descriptor filling bug.
> 
> Changes since v5:
> - Modified user logic interrupt APIs to handle user logic IP which does not
>    have its own register to enable/disable interrupt.
> - Clean up code based on review comments.
> 
> Changes since v4:
> - Modified user logic interrupt APIs.
> 
> Changes since v3:
> - Added one patch to support user logic interrupt.
> 
> Changes since v2:
> - Removed tasklet.
> - Fixed regression bug introduced to V2.
> - Test Robot warning.
> 
> Changes since v1:
> - Moved filling hardware descriptor to xdma_prep_device_sg().
> - Changed hardware descriptor enum to "struct xdma_hw_desc".
> - Minor changes from code review comments.
> 
> Lizhi Hou (2):
>    dmaengine: xilinx: xdma: Add xilinx xdma driver
>    dmaengine: xilinx: xdma: Add user logic interrupt support
> 
>   MAINTAINERS                            |   11 +
>   drivers/dma/Kconfig                    |   14 +
>   drivers/dma/xilinx/Makefile            |    1 +
>   drivers/dma/xilinx/xdma-regs.h         |  173 ++++
>   drivers/dma/xilinx/xdma.c              | 1004 ++++++++++++++++++++++++
>   include/linux/dma/amd_xdma.h           |   16 +
>   include/linux/platform_data/amd_xdma.h |   34 +
>   7 files changed, 1253 insertions(+)
>   create mode 100644 drivers/dma/xilinx/xdma-regs.h
>   create mode 100644 drivers/dma/xilinx/xdma.c
>   create mode 100644 include/linux/dma/amd_xdma.h
>   create mode 100644 include/linux/platform_data/amd_xdma.h
> 

Hi,
I see that there is no response for more than two weeks on this driver, 
is there some problem with it? The XDMA driver is required for our mgb4
v4l2 driver to work:

https://patchwork.kernel.org/project/linux-media/patch/20221123140431.4730-2-tumic@gpxsee.org/

The patches not being included in the kernel block the progress on our 
driver as it naturally fails to compile and as a result the willingness 
to deal with our patch is quiet low among the v4l2 people... Thanks for 
any help.

Martin Tůma
