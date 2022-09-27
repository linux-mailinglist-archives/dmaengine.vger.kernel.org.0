Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA795EC7C3
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiI0PbQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiI0PbN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 11:31:13 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6911A1BB6E3;
        Tue, 27 Sep 2022 08:31:10 -0700 (PDT)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 245014FF60;
        Tue, 27 Sep 2022 17:31:08 +0200 (CEST)
Message-ID: <a2b5c35d-ced2-ff83-c550-4bbf29973b80@gpxsee.org>
Date:   Tue, 27 Sep 2022 17:31:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH V4 XDMA 2/2] dmaengine: xilinx: xdma: Add user logic
 interrupt support
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com
Cc:     max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1663871905-60498-1-git-send-email-lizhi.hou@amd.com>
 <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
Content-Language: en-US
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <1663871905-60498-3-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22. 09. 22 20:38, Lizhi Hou wrote:
> The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
> interrupt wires to user logic that generate interrupts to the host.
> This patch adds APIs to register/unregister interrupt handler for a given
> interrupt wire index.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> ---
>   MAINTAINERS                  |  1 +
>   drivers/dma/xilinx/xdma.c    | 80 ++++++++++++++++++++++++++++++++++++
>   include/linux/dma/amd_xdma.h | 17 ++++++++
>   3 files changed, 98 insertions(+)
>   create mode 100644 include/linux/dma/amd_xdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1be0b2e378a..019d84b2b086 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21691,6 +21691,7 @@ L:	dmaengine@vger.kernel.org
>   S:	Supported
>   F:	drivers/dma/xilinx/xdma-regs.h
>   F:	drivers/dma/xilinx/xdma.c
> +F:	include/linux/dma/amd_xdma.h
>   F:	include/linux/platform_data/amd_xdma.h
>   
>   XILINX ZYNQMP DPDMA DRIVER
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 58a57e03bef5..884942cd2a37 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -25,6 +25,7 @@
>   #include <linux/dmapool.h>
>   #include <linux/regmap.h>
>   #include <linux/dmaengine.h>
> +#include <linux/dma/amd_xdma.h>
>   #include <linux/platform_device.h>
>   #include <linux/platform_data/amd_xdma.h>
>   #include <linux/dma-mapping.h>
> @@ -736,6 +737,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
>   static int xdma_irq_init(struct xdma_device *xdev)
>   {
>   	u32 irq = xdev->irq_start;
> +	u32 user_irq_start;
>   	int i, j, ret;
>   
>   	/* return failure if there are not enough IRQs */
> @@ -786,6 +788,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
>   		goto failed;
>   	}
>   
> +	/* config user IRQ registers if needed */
> +	user_irq_start = xdev->h2c_chan_num + xdev->c2h_chan_num;
> +	if (xdev->irq_num > user_irq_start) {
> +		ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
> +					  user_irq_start,
> +					  xdev->irq_num - user_irq_start);
> +		if (ret) {
> +			xdma_err(xdev, "failed to set user vectors: %d", ret);
> +			goto failed;
> +		}
> +	}
> +
>   	/* enable interrupt */
>   	ret = xdma_enable_intr(xdev);
>   	if (ret) {
> @@ -816,6 +830,72 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
>   	return true;
>   }
>   
> +/**
> + * xdma_free_user_irq - Free user interrupt
> + * @pdev: Pointer to the platform_device structure
> + * @user_irq_index: User IRQ index
> + * @arg: User interrupt cookie
> + */
> +void xdma_free_user_irq(struct platform_device *pdev, u32 user_irq_index,
> +			void *arg)
> +{
> +	struct xdma_device *xdev = platform_get_drvdata(pdev);
> +	u32 user_irq;
> +
> +	user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index;
> +	if (user_irq >= xdev->irq_num) {
> +		xdma_err(xdev, "invalid user irq index");
> +		return;
> +	}
> +	user_irq += xdev->irq_start;
> +
> +	xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
> +		       (1 << user_irq_index));
> +
> +	free_irq(user_irq, arg);
> +}
> +EXPORT_SYMBOL(xdma_free_user_irq);
> +
> +/**
> + * xdma_request_user_irq - Register user interrupt
> + * @pdev: Pointer to the platform_device structure
> + * @user_irq_index: User IRQ index
> + * @flags: Handling flags
> + * @handler: User interrupt handler
> + * @arg: User interrupt cookie
> + */
> +int xdma_request_user_irq(struct platform_device *pdev, u32 user_irq_index,
> +			  irq_handler_t handler, void *arg, ulong flags)
> +{
> +	struct xdma_device *xdev = platform_get_drvdata(pdev);
> +	u32 user_irq;
> +	int ret;
> +
> +	user_irq = xdev->h2c_chan_num + xdev->c2h_chan_num + user_irq_index;
> +	if (user_irq >= xdev->irq_num) {
> +		xdma_err(xdev, "invalid user irq index");
> +		return -EINVAL;
> +	}
> +	user_irq += xdev->irq_start;
> +
> +	ret = request_irq(user_irq, handler, flags, "xdma-user", arg);
> +	if (ret) {
> +		xdma_err(xdev, "request irq failed, %d", ret);
> +		return ret;
> +	}
> +
> +	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
> +			     (1 << user_irq_index));
> +	if (ret) {
> +		xdma_err(xdev, "set user irq mask failed, %d", ret);
> +		free_irq(user_irq, arg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xdma_request_user_irq);
> +
>   /**
>    * xdma_remove - Driver remove function
>    * @pdev: Pointer to the platform_device structure
> diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
> new file mode 100644
> index 000000000000..b70486121ca6
> --- /dev/null
> +++ b/include/linux/dma/amd_xdma.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _DMAENGINE_AMD_XDMA_H
> +#define _DMAENGINE_AMD_XDMA_H
> +
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +int xdma_request_user_irq(struct platform_device *pdev, u32 user_irq_index,
> +			  irq_handler_t handler, void *arg, ulong flags);
> +void xdma_free_user_irq(struct platform_device *pdev, u32 user_irq_index,
> +			void *arg);
> +
> +#endif /* _DMAENGINE_AMD_XDMA_H */

Hi,
The user IRQ logic is unusable, if you have other IP cores with linux 
drivers (eg. spi or i2c) connected to that IRQs like we (and many other 
users as well) have on our PCIe card. You can't use the already existing
xiic or xilinx-spi drivers with your xdma driver!

You must split the "IRQ enable" and "IRQ request" operations for your 
driver to be usable with the other platform drivers in linux. Instead of
"xdma_request_user_irq" there must be something like 
"xdma_enable_user_irq" that only enables the IRQ in the IP block, but 
does not "eat" the IRQ so you can pass it to the initialization of
the platform driver of xiic or xilinx-spi.

M.
