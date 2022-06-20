Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8328D5512DE
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jun 2022 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbiFTIdO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 04:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbiFTIdO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 04:33:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B312AA6
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 01:33:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o3CqN-00044u-EH; Mon, 20 Jun 2022 10:33:11 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o3CqM-0002ka-Re; Mon, 20 Jun 2022 10:33:10 +0200
Date:   Mon, 20 Jun 2022 10:33:10 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Hui Wang <hui.wang@canonical.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org, shawnguo@kernel.org,
        yibin.gong@nxp.com
Subject: Re: [PATCH] dmaengine: imx-sdma: Setting DMA_PRIVATE capability
 during the probe
Message-ID: <20220620083310.GV2387@pengutronix.de>
References: <20220524074933.38413-1-hui.wang@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524074933.38413-1-hui.wang@canonical.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:28:04 up 81 days, 20:57, 81 users,  load average: 0.20, 0.35,
 0.38
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
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

On Tue, May 24, 2022 at 03:49:33PM +0800, Hui Wang wrote:
> We have an imx6sx EVB, the audio driver fails to get a valid dma chan
> and the audio can't work at all on this board, below is the error log:
>  fsl-ssi-dai 202c000.ssi: Missing dma channel for stream: 0
>  202c000.ssi-nau8822-hifi: ASoC: pcm constructor failed: -22
>  asoc-simple-card sound: ASoC: can't create pcm 202c000.ssi-nau8822-hifi :-22
> 
> Then I checked the usage_count of each dma chan through sysfs, all
> channels are occupied as below:
> ubuntu@ubuntu:cd /sys/devices/platform/soc/2000000.bus/20ec000.sdma/dma
> ubuntu@ubuntu:find . -iname in_use | xargs cat
> 2
> 2
> 2
> ...
> 
> Through debugging, we found the root cause, the
> crypo/async_tx/async_tx.c calls the dmaengine_get() ahead of
> registration of dma_device from imx-sdma.c. In the dmaengine_get(), the
> dmaengine_ref_count will be increased, then in the
> dma_async_device_register(), the client_count of each chan will be
> increased.
> 
> To fix this issue, we could set DMA_PRIVATE to the dma_deivce before
> registration.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/dma/imx-sdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 95367a8a81a5..aabe8a8069fb 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2201,6 +2201,7 @@ static int sdma_probe(struct platform_device *pdev)
>  	for (i = 0; i < sizeof(*sdma->script_addrs) / sizeof(s32); i++)
>  		saddr_arr[i] = -EINVAL;
>  
> +	dma_cap_set(DMA_PRIVATE, sdma->dma_device.cap_mask);

I am not sure about the impacts on the memcpy capability of the SDMA
driver when setting this flag. It looks like this flag influences the
way suitable channels are picked for memcpy, but I don't understand
the code just by looking at it. I see that several other drivers
providing memcpy set this flag as well, so I guess it's ok to set it,
but it would be good to hear a word from Vinod about it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
