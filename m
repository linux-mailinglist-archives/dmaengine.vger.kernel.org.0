Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140FE671493
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjARG60 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 01:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjARG5j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 01:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFCA63E05;
        Tue, 17 Jan 2023 22:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F325615AA;
        Wed, 18 Jan 2023 06:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB4DC433D2;
        Wed, 18 Jan 2023 06:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674023379;
        bh=jTAtI1meqFg4A1MDMWrkwGfJrx8IetaItUUhiM5XP7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw0IDKyFoQxUlNX+pSkSdIBdBRfJz/1UjBUXRFdDKP7ykkumrHyN0X3G4Q5Ancekb
         8kclUtiki+/uXvRJBN9j82v3fp96LYDVFcuS5qgAd5SWk3cDvOxUU1GkWShItsRmbM
         hgv7PwIQ6iFTm6FB8/CG1ocnSlFy0/dMP1iq51Xdxxb8H/tOBufMuIcrycX5iBJBEA
         evDrZv5eikro5z0yvM/OJNdH7OBTi6xW+j3rKdW+XdSmYVS9tMCeUeXqkCirkKujR8
         qIzKTd6OkNJpGCePqSf579kx56nKe6qqMybX30xFgBJff6ykHP32D0gx710Vwylva6
         E0+R8auaeI5gA==
Date:   Wed, 18 Jan 2023 11:59:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, tumic@gpxsee.org
Subject: Re: [RESEND PATCH V11 XDMA 2/2] dmaengine: xilinx: xdma: Add user
 logic interrupt support
Message-ID: <Y8eRz2sXrnCtSib+@matsya>
References: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
 <1673988842-43631-3-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1673988842-43631-3-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-01-23, 12:54, Lizhi Hou wrote:
> The Xilinx DMA/Bridge Subsystem for PCIe (XDMA) provides up to 16 user
> interrupt wires to user logic that generate interrupts to the host.
> This patch adds APIs to enable/disable user logic interrupt for a given
> interrupt wire index.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> Tested-by: Martin Tuma <tumic@gpxsee.org>
> ---
>  MAINTAINERS                  |  1 +
>  drivers/dma/xilinx/xdma.c    | 85 ++++++++++++++++++++++++++++++++++++
>  include/linux/dma/amd_xdma.h | 16 +++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 include/linux/dma/amd_xdma.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d598c4e23901..eaf6590dda19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22583,6 +22583,7 @@ L:	dmaengine@vger.kernel.org
>  S:	Supported
>  F:	drivers/dma/xilinx/xdma-regs.h
>  F:	drivers/dma/xilinx/xdma.c
> +F:	include/linux/dma/amd_xdma.h
>  F:	include/linux/platform_data/amd_xdma.h
>  
>  XILINX ZYNQMP DPDMA DRIVER
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 118528295fb7..846f10317bba 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -25,6 +25,7 @@
>  #include <linux/dmapool.h>
>  #include <linux/regmap.h>
>  #include <linux/dmaengine.h>
> +#include <linux/dma/amd_xdma.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/amd_xdma.h>
>  #include <linux/dma-mapping.h>
> @@ -713,6 +714,7 @@ static int xdma_set_vector_reg(struct xdma_device *xdev, u32 vec_tbl_start,
>  static int xdma_irq_init(struct xdma_device *xdev)
>  {
>  	u32 irq = xdev->irq_start;
> +	u32 user_irq_start;
>  	int i, j, ret;
>  
>  	/* return failure if there are not enough IRQs */
> @@ -755,6 +757,18 @@ static int xdma_irq_init(struct xdma_device *xdev)
>  		goto failed_init_c2h;
>  	}
>  
> +	/* config user IRQ registers if needed */
> +	user_irq_start = XDMA_CHAN_NUM(xdev);
> +	if (xdev->irq_num > user_irq_start) {
> +		ret = xdma_set_vector_reg(xdev, XDMA_IRQ_USER_VEC_NUM,
> +					  user_irq_start,
> +					  xdev->irq_num - user_irq_start);
> +		if (ret) {
> +			xdma_err(xdev, "failed to set user vectors: %d", ret);
> +			goto failed_init_c2h;
> +		}
> +	}
> +
>  	/* enable interrupt */
>  	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_CHAN_INT_EN_W1S, ~0);
>  	if (ret)
> @@ -780,6 +794,77 @@ static bool xdma_filter_fn(struct dma_chan *chan, void *param)
>  	return chan_info->dir == xdma_chan->dir;
>  }
>  
> +/**
> + * xdma_disable_user_irq - Disable user interrupt
> + * @pdev: Pointer to the platform_device structure
> + * @irq_num: System IRQ number
> + */
> +void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num)
> +{
> +	struct xdma_device *xdev = platform_get_drvdata(pdev);
> +	u32 user_irq_index;
> +
> +	user_irq_index = irq_num - xdev->irq_start;
> +	if (user_irq_index < XDMA_CHAN_NUM(xdev) ||
> +	    user_irq_index >= xdev->irq_num) {
> +		xdma_err(xdev, "invalid user irq number");
> +		return;
> +	}
> +	user_irq_index -= XDMA_CHAN_NUM(xdev);
> +
> +	xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1C,
> +		       (1 << user_irq_index));
> +}
> +EXPORT_SYMBOL(xdma_disable_user_irq);
> +
> +/**
> + * xdma_enable_user_irq - Enable user logic interrupt
> + * @pdev: Pointer to the platform_device structure
> + * @irq_num: System IRQ number
> + */
> +int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num)
> +{
> +	struct xdma_device *xdev = platform_get_drvdata(pdev);
> +	u32 user_irq_index;
> +	int ret;
> +
> +	user_irq_index = irq_num - xdev->irq_start;
> +	if (user_irq_index < XDMA_CHAN_NUM(xdev) ||
> +	    user_irq_index >= xdev->irq_num) {
> +		xdma_err(xdev, "invalid user irq number");
> +		return -EINVAL;
> +	}
> +	user_irq_index -= XDMA_CHAN_NUM(xdev);
> +
> +	ret = xdma_write_reg(xdev, XDMA_IRQ_BASE, XDMA_IRQ_USER_INT_EN_W1S,
> +			     (1 << user_irq_index));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(xdma_enable_user_irq);
> +
> +/**
> + * xdma_get_user_irq - Get system IRQ number
> + * @pdev: Pointer to the platform_device structure
> + * @user_irq_index: User logic IRQ wire index
> + *
> + * Return: The system IRQ number allocated for the given wire index.
> + */
> +int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index)
> +{
> +	struct xdma_device *xdev = platform_get_drvdata(pdev);
> +
> +	if (XDMA_CHAN_NUM(xdev) + user_irq_index >= xdev->irq_num) {
> +		xdma_err(xdev, "invalid user irq index");
> +		return -EINVAL;
> +	}
> +
> +	return xdev->irq_start + XDMA_CHAN_NUM(xdev) + user_irq_index;
> +}
> +EXPORT_SYMBOL(xdma_get_user_irq);
> +
>  /**
>   * xdma_remove - Driver remove function
>   * @pdev: Pointer to the platform_device structure
> diff --git a/include/linux/dma/amd_xdma.h b/include/linux/dma/amd_xdma.h
> new file mode 100644
> index 000000000000..ceba69ed7cb4
> --- /dev/null
> +++ b/include/linux/dma/amd_xdma.h
> @@ -0,0 +1,16 @@
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
> +int xdma_enable_user_irq(struct platform_device *pdev, u32 irq_num);
> +void xdma_disable_user_irq(struct platform_device *pdev, u32 irq_num);
> +int xdma_get_user_irq(struct platform_device *pdev, u32 user_irq_index);

who is the user of these APIs? It is not clear to me how this is to be
used...


> +
> +#endif /* _DMAENGINE_AMD_XDMA_H */
> -- 
> 2.27.0

-- 
~Vinod
