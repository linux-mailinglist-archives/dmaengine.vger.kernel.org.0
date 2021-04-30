Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84636F32E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 02:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhD3AhP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 20:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhD3AhO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Apr 2021 20:37:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB623C06138B;
        Thu, 29 Apr 2021 17:36:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D89EB8B;
        Fri, 30 Apr 2021 02:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619742984;
        bh=Hp8mtrcjCCtlKZbePuUwuModbgTwBktIt0Cn/vGVBjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RopSS5Qr4kDBHzXGmcEjkLXYs2KNu7eHkj9d6BZeHjMcbPrkHF9wkrCjXghcyLVXp
         rYIwxQqZdIJXRxwOLmG8gHL5xRfku8mpA8nO67wXtA7kiKxVSWJq39LUazhBrAq9ER
         Mimo2oQxL9WSUrwTU1QaTOYDmFFmG3IJJlRa0YHw=
Date:   Fri, 30 Apr 2021 03:36:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     quanyang.wang@windriver.com
Cc:     Vinod Koul <vkoul@kernel.org>, Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: xilinx: dpdma: request_irq after initializing
 dma channels
Message-ID: <YItRB7SBhiilzDLk@pendragon.ideasonboard.com>
References: <20210429065821.3495234-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210429065821.3495234-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Quanyang,

Thank you for the patch.

On Thu, Apr 29, 2021 at 02:58:21PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> In some scenarios (kdump), dpdma hardware irqs has been enabled when
> calling request_irq in probe function, and then the dpdma irq handler
> xilinx_dpdma_irq_handler is invoked to access xdev->chan[i]. But at
> this moment xdev->chan[i] hasn't been initialized. So let's call the
> request_irq after initializing dma channels to avoid kdump kernel
> crash as below:
> 
> [    3.696128] Unable to handle kernel NULL pointer dereference at virtual address 000000000000012c
> [    3.696710] xilinx-zynqmp-dpdma fd4c0000.dma-controller: Xilinx DPDMA engine is probed
> [    3.704900] Mem abort info:
> [    3.704902]   ESR = 0x96000005
> [    3.704905]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    3.704907]   SET = 0, FnV = 0
> [    3.704912]   EA = 0, S1PTW = 0
> [    3.713800] ahci-ceva fd0c0000.ahci: supply ahci not found, using dummy regulator
> [    3.715585] Data abort info:
> [    3.715587]   ISV = 0, ISS = 0x00000005
> [    3.715589]   CM = 0, WnR = 0
> [    3.715592] [000000000000012c] user address but active_mm is swapper
> [    3.715596] Internal error: Oops: 96000005 [#1] SMP
> [    3.715599] Modules linked in:
> [    3.715608] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.0-12170-g60894882155f-dirty #77
> [    3.723937] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [    3.723942] pstate: 80000085 (Nzcv daIf -PAN -UAO -TCO BTYPE=--)
> [    3.723956] pc : xilinx_dpdma_irq_handler+0x418/0x560
> [    3.793049] lr : xilinx_dpdma_irq_handler+0x3d8/0x560
> [    3.798089] sp : ffffffc01186bdf0
> [    3.801388] x29: ffffffc01186bdf0 x28: ffffffc011836f28
> [    3.806692] x27: ffffff8023e0ac80 x26: 0000000000000080
> [    3.811996] x25: 0000000008000408 x24: 0000000000000003
> [    3.817300] x23: ffffffc01186be70 x22: ffffffc011291740
> [    3.822604] x21: 0000000000000000 x20: 0000000008000408
> [    3.827908] x19: 0000000000000000 x18: 0000000000000010
> [    3.833212] x17: 0000000000000000 x16: 0000000000000000
> [    3.838516] x15: 0000000000000000 x14: ffffffc011291740
> [    3.843820] x13: ffffffc02eb4d000 x12: 0000000034d4d91d
> [    3.849124] x11: 0000000000000040 x10: ffffffc0112d2d48
> [    3.854428] x9 : ffffffc0112d2d40 x8 : ffffff8021c00268
> [    3.859732] x7 : 0000000000000000 x6 : ffffffc011836000
> [    3.865036] x5 : 0000000000000003 x4 : 0000000000000000
> [    3.870340] x3 : 0000000000000001 x2 : 0000000000000000
> [    3.875644] x1 : 0000000000000000 x0 : 000000000000012c
> [    3.880948] Call trace:
> [    3.883382]  xilinx_dpdma_irq_handler+0x418/0x560
> [    3.888079]  __handle_irq_event_percpu+0x5c/0x178
> [    3.892774]  handle_irq_event_percpu+0x34/0x98
> [    3.897210]  handle_irq_event+0x44/0xb8
> [    3.901030]  handle_fasteoi_irq+0xd0/0x190
> [    3.905117]  generic_handle_irq+0x30/0x48
> [    3.909111]  __handle_domain_irq+0x64/0xc0
> [    3.913192]  gic_handle_irq+0x78/0xa0
> [    3.916846]  el1_irq+0xc4/0x180
> [    3.919982]  cpuidle_enter_state+0x134/0x2f8
> [    3.924243]  cpuidle_enter+0x38/0x50
> [    3.927810]  call_cpuidle+0x1c/0x40
> [    3.931290]  do_idle+0x20c/0x270
> [    3.934502]  cpu_startup_entry+0x28/0x58
> [    3.938410]  rest_init+0xbc/0xcc
> [    3.941631]  arch_call_rest_init+0x10/0x1c
> [    3.945718]  start_kernel+0x51c/0x558
> 
> Fixes: 7cbb0c63de3f ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 70b29bd079c9..0b599402c53f 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -1622,19 +1622,6 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>  	if (IS_ERR(xdev->reg))
>  		return PTR_ERR(xdev->reg);
>  
> -	xdev->irq = platform_get_irq(pdev, 0);
> -	if (xdev->irq < 0) {
> -		dev_err(xdev->dev, "failed to get platform irq\n");
> -		return xdev->irq;
> -	}
> -
> -	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
> -			  dev_name(xdev->dev), xdev);
> -	if (ret) {
> -		dev_err(xdev->dev, "failed to request IRQ\n");
> -		return ret;
> -	}
> -
>  	ddev = &xdev->common;
>  	ddev->dev = &pdev->dev;
>  
> @@ -1688,6 +1675,19 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>  		goto error_of_dma;
>  	}
>  
> +	xdev->irq = platform_get_irq(pdev, 0);
> +	if (xdev->irq < 0) {
> +		dev_err(xdev->dev, "failed to get platform irq\n");

As reported by the kbuild bot, ret isn't initialized here.

> +		goto error_irq;
> +	}

This part could stay where it was, just after
devm_platform_ioremap_resource().

> +
> +	ret = request_irq(xdev->irq, xilinx_dpdma_irq_handler, IRQF_SHARED,
> +			  dev_name(xdev->dev), xdev);
> +	if (ret) {
> +		dev_err(xdev->dev, "failed to request IRQ\n");
> +		goto error_irq;
> +	}

Ideally we should reset the device before requesting the IRQ, to ensure
we start in a consistent state. There doesn't seem to be any global
reset unfortunately. Shouldn't we at least disable interrupts ? It may
be a bit pointless though as we reenable them right below, so I suppose
this would be OK.

> +
>  	xilinx_dpdma_enable_irq(xdev);
>  
>  	xilinx_dpdma_debugfs_init(xdev);
> @@ -1696,6 +1696,8 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +error_irq:
> +	of_dma_controller_free(pdev->dev.of_node);

Why not free_irq() ? This change isn't described in the commit message.

>  error_of_dma:
>  	dma_async_device_unregister(ddev);
>  error_dma_async:
> @@ -1704,8 +1706,6 @@ static int xilinx_dpdma_probe(struct platform_device *pdev)
>  	for (i = 0; i < ARRAY_SIZE(xdev->chan); i++)
>  		xilinx_dpdma_chan_remove(xdev->chan[i]);
>  
> -	free_irq(xdev->irq, xdev);
> -
>  	return ret;
>  }
>  

-- 
Regards,

Laurent Pinchart
