Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16ED13BAAA
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 09:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgAOIDO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 03:03:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51055 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOIDO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 03:03:14 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1irddj-0000Js-MF; Wed, 15 Jan 2020 09:02:59 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1irddh-0008IE-N7; Wed, 15 Jan 2020 09:02:57 +0100
Date:   Wed, 15 Jan 2020 09:02:57 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Han Xu <han.xu@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, esben@geanix.com,
        boris.brezillon@collabora.com, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dmaengine: mxs: add the power management functions
Message-ID: <20200115080257.dtd4vss4uhopbvn2@pengutronix.de>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
 <1579038243-28550-4-git-send-email-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579038243-28550-4-git-send-email-han.xu@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:51:32 up 191 days, 14:01, 85 users,  load average: 0.23, 0.25,
 0.25
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 15, 2020 at 05:44:00AM +0800, Han Xu wrote:
> add the power management functions and leverage the runtime pm for
> system suspend/resume
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/dma/mxs-dma.c | 97 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index b458f06f9067..251492c5ea58 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_dma.h>
>  #include <linux/list.h>
>  #include <linux/dma/mxs-dma.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <asm/irq.h>
>  
> @@ -39,6 +40,8 @@
>  #define dma_is_apbh(mxs_dma)	((mxs_dma)->type == MXS_DMA_APBH)
>  #define apbh_is_old(mxs_dma)	((mxs_dma)->dev_id == IMX23_DMA)
>  
> +#define MXS_DMA_RPM_TIMEOUT 50 /* ms */
> +
>  #define HW_APBHX_CTRL0				0x000
>  #define BM_APBH_CTRL0_APB_BURST8_EN		(1 << 29)
>  #define BM_APBH_CTRL0_APB_BURST_EN		(1 << 28)
> @@ -416,6 +419,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  {
>  	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
>  	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	struct device *dev = &mxs_dma->pdev->dev;
>  	int ret;
>  
>  	mxs_chan->ccw = dma_alloc_coherent(mxs_dma->dma_device.dev,
> @@ -431,9 +435,11 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan *chan)
>  	if (ret)
>  		goto err_irq;
>  
> -	ret = clk_prepare_enable(mxs_dma->clk);
> -	if (ret)
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable clock\n");
>  		goto err_clk;

From looking at other DMA drivers I know we are in good company here,
but I think this is wrong. Doing pm_runtime_get_sync() in
alloc_chan_resources() and going to autosuspend in free_chan_resources()
effectively disables runtime_pm as clients normally acquire their
channels during driver probe and release them only in driver remove.

In the next patch you release the DMA channels in the GPMI nand drivers
runtime_suspend hook just to somehow trigger the runtime_suspend of the
DMA driver.

What you should do instead is to make sure the hook runtime_pm to the
DMA drivers activity phases, like for example the pl330 driver does.
Then you wouldn't have to care about manually putting the DMA driver into
suspend from the GPMI NAND driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
