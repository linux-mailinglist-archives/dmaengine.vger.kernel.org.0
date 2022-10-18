Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC86027EF
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJRJHY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 05:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiJRJHV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 05:07:21 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 390154E402;
        Tue, 18 Oct 2022 02:07:19 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id C6E3222233;
        Tue, 18 Oct 2022 11:07:16 +0200 (CEST)
Message-ID: <a2660505-f2f2-3b2a-86e2-82f9458e5e5e@gpxsee.org>
Date:   Tue, 18 Oct 2022 11:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V8 XDMA 0/2] xilinx XDMA driver
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com
Cc:     max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1666022581-27279-1-git-send-email-lizhi.hou@amd.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <1666022581-27279-1-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17. 10. 22 18:02, Lizhi Hou wrote:
> Hello,
> 
> This V8 of patch series is to provide the platform driver to support the
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
> Changes since v7
> - Use pci device pointer for dma_pool_create().
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
>   drivers/dma/Kconfig                    |   13 +
>   drivers/dma/xilinx/Makefile            |    1 +
>   drivers/dma/xilinx/xdma-regs.h         |  171 ++++
>   drivers/dma/xilinx/xdma.c              | 1041 ++++++++++++++++++++++++
>   include/linux/dma/amd_xdma.h           |   16 +
>   include/linux/platform_data/amd_xdma.h |   34 +
>   7 files changed, 1287 insertions(+)
>   create mode 100644 drivers/dma/xilinx/xdma-regs.h
>   create mode 100644 drivers/dma/xilinx/xdma.c
>   create mode 100644 include/linux/dma/amd_xdma.h
>   create mode 100644 include/linux/platform_data/amd_xdma.h
> 

Hi,
Just for the record - this version works fine with our HW.

M.
