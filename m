Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A124813BB1F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 09:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgAOIcp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 03:32:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38481 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOIco (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 03:32:44 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ire6G-0003Op-LB; Wed, 15 Jan 2020 09:32:28 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1ire6E-0001jx-6Z; Wed, 15 Jan 2020 09:32:26 +0100
Date:   Wed, 15 Jan 2020 09:32:26 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Han Xu <han.xu@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, esben@geanix.com,
        boris.brezillon@collabora.com, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mtd: rawnand: gpmi: refine the runtime pm ops
Message-ID: <20200115083226.lbwtfvoevp3k33qt@pengutronix.de>
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com>
 <1579038243-28550-6-git-send-email-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579038243-28550-6-git-send-email-han.xu@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:17:31 up 191 days, 14:27, 88 users,  load average: 0.39, 0.32,
 0.30
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 15, 2020 at 05:44:02AM +0800, Han Xu wrote:
> several changes for runtime code in gpmi-nand driver
> 
> - Always invoke runtime get/put in same function to balance the usage
> counter.
> 
> - leverage the runtime pm for system pm, move acquire dma to runtime pm
> to acquire dma only when needed.
> 
> - add pm_runtime_dont_use_autosuspend in err path. If driver failed to
> probe before runtime pm timeout, such as NAND not mounted in socket,
> runtime suspend won't be called without the change.

Using a bullet list in a commit message is often a sign that the patch
should be split into multiple patches...

> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 56 +++++++++++-----------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index fcc7325f2a10..73644c96fa9b 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -183,7 +183,6 @@ static int gpmi_init(struct gpmi_nand_data *this)
>  	 */
>  	writel(BM_GPMI_CTRL1_DECOUPLE_CS, r->gpmi_regs + HW_GPMI_CTRL1_SET);
>  
> -	return 0;
>  err_out:
>  	pm_runtime_mark_last_busy(this->dev);
>  	pm_runtime_put_autosuspend(this->dev);
> @@ -556,7 +555,6 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
>  	/* Set *all* chip selects to use layout 0. */
>  	writel(0, r->bch_regs + HW_BCH_LAYOUTSELECT);
>  
> -	ret = 0;
>  err_out:
>  	pm_runtime_mark_last_busy(this->dev);
>  	pm_runtime_put_autosuspend(this->dev);

While I agree that this "ret = 0" is unnecessary because 'ret' holds the
successful return value of the last function called, I still think it's
nice to make it explicit that this is the success path of this function.

If you disagree please at least make this a separate patch.

> @@ -1213,10 +1211,6 @@ static int acquire_resources(struct gpmi_nand_data *this)
>  	if (ret)
>  		goto exit_regs;
>  
> -	ret = acquire_dma_channels(this);
> -	if (ret)
> -		goto exit_regs;
> -
>  	ret = gpmi_get_clks(this);
>  	if (ret)
>  		goto exit_clock;
> @@ -2656,15 +2650,9 @@ static int gpmi_nand_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto exit_acquire_resources;
>  
> -	ret = __gpmi_enable_clk(this, true);
> -	if (ret)
> -		goto exit_nfc_init;
> -
> +	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
>  	pm_runtime_use_autosuspend(&pdev->dev);
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
>  
>  	ret = gpmi_init(this);
>  	if (ret)
> @@ -2674,15 +2662,12 @@ static int gpmi_nand_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto exit_nfc_init;
>  
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
> -
>  	dev_info(this->dev, "driver registered.\n");
>  
>  	return 0;
>  
>  exit_nfc_init:
> -	pm_runtime_put(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	release_resources(this);
>  exit_acquire_resources:
> @@ -2694,7 +2679,6 @@ static int gpmi_nand_remove(struct platform_device *pdev)
>  {
>  	struct gpmi_nand_data *this = platform_get_drvdata(pdev);
>  
> -	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  
>  	nand_release(&this->nand);
> @@ -2706,10 +2690,11 @@ static int gpmi_nand_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int gpmi_pm_suspend(struct device *dev)
>  {
> -	struct gpmi_nand_data *this = dev_get_drvdata(dev);
> +	int ret;
>  
> -	release_dma_channels(this);
> -	return 0;
> +	ret = pm_runtime_force_suspend(dev);
> +
> +	return ret;
>  }
>  
>  static int gpmi_pm_resume(struct device *dev)
> @@ -2717,9 +2702,11 @@ static int gpmi_pm_resume(struct device *dev)
>  	struct gpmi_nand_data *this = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = acquire_dma_channels(this);
> -	if (ret < 0)
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(this->dev, "Error in resume %d\n", ret);
>  		return ret;
> +	}
>  
>  	/* re-init the GPMI registers */
>  	ret = gpmi_init(this);
> @@ -2743,18 +2730,33 @@ static int gpmi_pm_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM_SLEEP */
>  
> -static int __maybe_unused gpmi_runtime_suspend(struct device *dev)
> +#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
> +#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)

These defines do not add any value.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
