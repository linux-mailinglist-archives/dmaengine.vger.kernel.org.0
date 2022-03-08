Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5998F4D128D
	for <lists+dmaengine@lfdr.de>; Tue,  8 Mar 2022 09:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbiCHIpl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Mar 2022 03:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiCHIpl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Mar 2022 03:45:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120F3DA65
        for <dmaengine@vger.kernel.org>; Tue,  8 Mar 2022 00:44:44 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nRVSD-0004uE-Rn; Tue, 08 Mar 2022 09:44:25 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nRVSC-0005PI-4E; Tue, 08 Mar 2022 09:44:24 +0100
Date:   Tue, 8 Mar 2022 09:44:24 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     vkoul@kernel.org, michal.simek@xilinx.com, lars@metafoo.de,
        libaokun1@huawei.com, yukuai3@huawei.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma: xilinx: check the return value of dma_set_mask()
 in zynqmp_dma_probe()
Message-ID: <20220308084424.GC26648@pengutronix.de>
References: <20220305093120.28999-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220305093120.28999-1-baijiaju1990@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:42:40 up 87 days, 17:28, 80 users,  load average: 0.52, 0.44,
 0.27
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 05 Mar 2022 01:31:20 -0800, Jia-Ju Bai wrote:
> The function dma_set_mask() in zynqmp_dma_probe() can fail, so its
> return value should be checked.
> 
> Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> ---
> v2:
> * Print an error message and forward the return value of dma_set_mask().
>   Thank Michael for good advice.
> 
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 7aa63b652027..2791e9c6a4ea 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1050,7 +1050,10 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	zdev->dev = &pdev->dev;
>  	INIT_LIST_HEAD(&zdev->common.channels);
>  
> -	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
> +	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "No usable DMA available\n");
> +
>  	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
>  
>  	p = &zdev->common;
> -- 
> 2.17.1
> 
> 
