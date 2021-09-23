Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF53F4160DE
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbhIWOTi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 10:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhIWOTi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Sep 2021 10:19:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6977C061574
        for <dmaengine@vger.kernel.org>; Thu, 23 Sep 2021 07:18:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mTPXz-0007m8-0V; Thu, 23 Sep 2021 16:17:59 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mTPXy-0000Xt-8t; Thu, 23 Sep 2021 16:17:58 +0200
Date:   Thu, 23 Sep 2021 16:17:58 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     vkoul@kernel.org, romain.perier@gmail.com, allen.lkml@gmail.com,
        yukuai3@huawei.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com, shravya.kumbham@xilinx.com,
        kernel@pengutronix.de
Subject: Re: [PATCH 4/4] dmaengine: zynqmp_dma: Typecast with enum to fix the
 coverity warning
Message-ID: <20210923141758.GB30905@pengutronix.de>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
 <20210914082817.22311-5-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914082817.22311-5-harini.katakam@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:12:10 up 217 days, 17:36, 113 users,  load average: 0.96, 0.50,
 0.32
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, 14 Sep 2021 13:58:17 +0530, Harini Katakam wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> Typecast the flags variable with (enum dma_ctrl_flags) in
> zynqmp_dma_prep_memcpy function to fix the coverity warning.
> 
> Addresses-Coverity: Event mixed_enum_type.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 588460e56ab8..282d01ab402f 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -849,7 +849,7 @@ static struct dma_async_tx_descriptor *zynqmp_dma_prep_memcpy(
>  
>  	zynqmp_dma_desc_config_eod(chan, desc);
>  	async_tx_ack(&first->async_tx);
> -	first->async_tx.flags = flags;
> +	first->async_tx.flags = (enum dma_ctrl_flags)flags;

Thanks for the patch.

I looked at a few dmaengine drivers, at it looks like all of them have this
issue. Maybe we should change the signature of the dmaengine_prep_dma_memcpy()
engine to accept "enum dma_ctrl_flags flags" instead of "unsigned long flags"?

Michael

>  	return &first->async_tx;
>  }
>  
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
