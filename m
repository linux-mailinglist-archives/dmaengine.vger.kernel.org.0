Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E254413BAC0
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAOIOy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 03:14:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAOIOy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 03:14:54 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1irdp0-0001Tj-6d; Wed, 15 Jan 2020 09:14:38 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1irdoz-0000CT-5q; Wed, 15 Jan 2020 09:14:37 +0100
Date:   Wed, 15 Jan 2020 09:14:37 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Han Xu <han.xu@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, esben@geanix.com,
        boris.brezillon@collabora.com, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dmaengine: mxs: switch from dma_coherent to dma_pool
Message-ID: <20200115081437.gsrzwm5bkk2hg6vo@pengutronix.de>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
 <1579038243-28550-5-git-send-email-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579038243-28550-5-git-send-email-han.xu@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:03:40 up 191 days, 14:13, 86 users,  load average: 0.25, 0.42,
 0.34
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 15, 2020 at 05:44:01AM +0800, Han Xu wrote:
> create one dma_pool dedicate for mxs-dma to avoid the
> "alloc_contig_range: [xxx, xxx) PFNs busy" warning message during
> frequently alloc/free resource ops in runtime pm.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/dma/mxs-dma.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 251492c5ea58..dfee41ae1981 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/dma/mxs-dma.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/dmapool.h>
>  
>  #include <asm/irq.h>
>  
> @@ -121,6 +122,7 @@ struct mxs_dma_chan {
>  	enum dma_status			status;
>  	unsigned int			flags;
>  	bool				reset;
> +	struct dma_pool			*ccw_pool;
>  #define MXS_DMA_SG_LOOP			(1 << 0)
>  #define MXS_DMA_USE_SEMAPHORE		(1 << 1)
>  };
> @@ -422,9 +424,10 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  	struct device *dev = &mxs_dma->pdev->dev;
>  	int ret;
>  
> -	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
> -					   CCW_BLOCK_SIZE,
> -					   &mxs_chan->ccw_phys, GFP_KERNEL);
> +	mxs_chan->ccw = dma_pool_zalloc(mxs_chan->ccw_pool,
> +					GFP_ATOMIC,
> +					&mxs_chan->ccw_phys);

Why GFP_ATOMIC?

> +
>  	if (!mxs_chan->ccw) {
>  		ret = -ENOMEM;
>  		goto err_alloc;
> @@ -454,8 +457,8 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  err_clk:
>  	free_irq(mxs_chan->chan_irq, mxs_dma);
>  err_irq:
> -	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
> -			mxs_chan->ccw, mxs_chan->ccw_phys);
> +	dma_pool_free(mxs_chan->ccw_pool, mxs_chan->ccw,
> +		      mxs_chan->ccw_phys);
>  err_alloc:
>  	return ret;
>  }
> @@ -470,8 +473,8 @@ static void mxs_dma_free_chan_resources(struct dma_chan *chan)
>  
>  	free_irq(mxs_chan->chan_irq, mxs_dma);
>  
> -	dma_free_coherent(mxs_dma->dma_device.dev, CCW_BLOCK_SIZE,
> -			mxs_chan->ccw, mxs_chan->ccw_phys);
> +	dma_pool_free(mxs_chan->ccw_pool, mxs_chan->ccw,
> +		      mxs_chan->ccw_phys);
>  
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
> @@ -796,6 +799,7 @@ static int mxs_dma_probe(struct platform_device *pdev)
>  	const struct mxs_dma_type *dma_type;
>  	struct mxs_dma_engine *mxs_dma;
>  	struct resource *iores;
> +	struct dma_pool *ccw_pool;
>  	int ret, i;
>  
>  	mxs_dma = devm_kzalloc(&pdev->dev, sizeof(*mxs_dma), GFP_KERNEL);
> @@ -843,7 +847,6 @@ static int mxs_dma_probe(struct platform_device *pdev)
>  		tasklet_init(&mxs_chan->tasklet, mxs_dma_tasklet,
>  			     (unsigned long) mxs_chan);
>  
> -
>  		/* Add the channel to mxs_chan list */
>  		list_add_tail(&mxs_chan->chan.device_node,
>  			&mxs_dma->dma_device.channels);
> @@ -858,6 +861,17 @@ static int mxs_dma_probe(struct platform_device *pdev)
>  
>  	mxs_dma->dma_device.dev = &pdev->dev;
>  
> +	/* create the dma pool */
> +	ccw_pool = dma_pool_create("ccw_pool",
> +				   mxs_dma->dma_device.dev,
> +				   CCW_BLOCK_SIZE, 32, 0);
> +
> +	for (i = 0; i < MXS_DMA_CHANNELS; i++) {
> +		struct mxs_dma_chan *mxs_chan = &mxs_dma->mxs_chans[i];
> +
> +		mxs_chan->ccw_pool = ccw_pool;
> +	}

ccw_pool is the same for every channel, it should be a member of
struct mxs_dma_engine and not of struct mcs_dma_chan.

> +
>  	/* mxs_dma gets 65535 bytes maximum sg size */
>  	mxs_dma->dma_device.dev->dma_parms = &mxs_dma->dma_parms;
>  	dma_set_max_seg_size(mxs_dma->dma_device.dev, MAX_XFER_BYTES);
> @@ -899,11 +913,13 @@ static int mxs_dma_remove(struct platform_device *pdev)
>  	int i;
>  
>  	dma_async_device_unregister(&mxs_dma->dma_device);
> +	dma_pool_destroy(mxs_dma->mxs_chans[0].ccw_pool);

It doesn't seem to make a big difference, but I would do this after
killing the tasklets, not before. Otherwise we would have to prove that
no tasklet is still accessing the dma_pool.

>  
>  	for (i = 0; i < MXS_DMA_CHANNELS; i++) {
>  		struct mxs_dma_chan *mxs_chan = &mxs_dma->mxs_chans[i];
>  
>  		tasklet_kill(&mxs_chan->tasklet);
> +		mxs_chan->ccw_pool = NULL;

There's no point in resetting this to NULL, mxs_chan is never going to
be touched again.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
