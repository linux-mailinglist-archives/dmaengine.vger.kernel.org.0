Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A44CCFD3
	for <lists+dmaengine@lfdr.de>; Fri,  4 Mar 2022 09:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiCDIVb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Mar 2022 03:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiCDIV3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Mar 2022 03:21:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BAF195335
        for <dmaengine@vger.kernel.org>; Fri,  4 Mar 2022 00:20:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nQ3An-0002sn-TG; Fri, 04 Mar 2022 09:20:25 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nQ3Am-0002hT-2F; Fri, 04 Mar 2022 09:20:24 +0100
Date:   Fri, 4 Mar 2022 09:20:24 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     vkoul@kernel.org, michal.simek@xilinx.com, yukuai3@huawei.com,
        lars@metafoo.de, libaokun1@huawei.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dma: xilinx: check the return value of dma_set_mask() in
 zynqmp_dma_probe()
Message-ID: <20220304082024.GO8137@pengutronix.de>
References: <20220303024334.813-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303024334.813-1-baijiaju1990@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:16:28 up 83 days, 17:02, 75 users,  load average: 0.05, 0.22,
 0.31
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

On Wed, 02 Mar 2022 18:43:34 -0800, Jia-Ju Bai wrote:
> The function dma_set_mask() in zynqmp_dma_probe() can fail, so its
> return value should be checked.
> 
> Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 7aa63b652027..963fb1de93af 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -1050,7 +1050,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	zdev->dev = &pdev->dev;
>  	INIT_LIST_HEAD(&zdev->common.channels);
>  
> -	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
> +	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(44)))
> +		return -EIO;

Thanks.

You may print an error message with dev_err_probe and forward the return value
of dma_set_mask.

Michael

>  	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
>  
>  	p = &zdev->common;
> -- 
> 2.17.1
> 
> 
