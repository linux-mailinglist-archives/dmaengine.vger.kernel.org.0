Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA121D09D8
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 09:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgEMHVp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 03:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbgEMHVo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 03:21:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B4DC061A0C
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2020 00:21:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jYlhs-00012g-PP; Wed, 13 May 2020 09:21:32 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jYlhs-0008Jd-7d; Wed, 13 May 2020 09:21:32 +0200
Date:   Wed, 13 May 2020 09:21:32 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 RESEND 07/13] spi: imx: fix ERR009165
Message-ID: <20200513072132.GL5877@pengutronix.de>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
 <1589218356-17475-8-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589218356-17475-8-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:06:09 up 83 days, 13:36, 88 users,  load average: 0.20, 0.23,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 01:32:30AM +0800, Robin Gong wrote:
> Change to XCH  mode even in dma mode, please refer to the below
> errata:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

This patch is the one bisecting will end up with when somebody uses an
older SDMA firmware or the ROM scripts. It should have a better
description what happens and what should be done about it.

Sascha

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-imx.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index f4f28a4..70df8e6 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -585,8 +585,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> -	if (spi_imx->usedma)
> -		ctrl |= MX51_ECSPI_CTRL_SMC;
> +	/* ERR009165: work in XHC mode as PIO */
> +	ctrl &= ~MX51_ECSPI_CTRL_SMC;
>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  
> @@ -617,7 +617,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
>  	 * and enable DMA request.
>  	 */
>  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> +		MX51_ECSPI_DMA_TX_WML(0) |
>  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
>  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
>  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
> @@ -1171,7 +1171,11 @@ static int spi_imx_dma_configure(struct spi_master *master)
>  	tx.direction = DMA_MEM_TO_DEV;
>  	tx.dst_addr = spi_imx->base_phys + MXC_CSPITXDATA;
>  	tx.dst_addr_width = buswidth;
> -	tx.dst_maxburst = spi_imx->wml;
> +	/*
> +	 * For ERR009165 with tx_wml = 0 could enlarge burst size to fifo size
> +	 * to speed up fifo filling as possible.
> +	 */
> +	tx.dst_maxburst = spi_imx->devtype_data->fifo_size;
>  	ret = dmaengine_slave_config(master->dma_tx, &tx);
>  	if (ret) {
>  		dev_err(spi_imx->dev, "TX dma configuration failed with %d\n", ret);
> @@ -1265,10 +1269,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>  {
>  	int ret;
>  
> -	/* use pio mode for i.mx6dl chip TKT238285 */
> -	if (of_machine_is_compatible("fsl,imx6dl"))
> -		return 0;
> -
>  	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
>  
>  	/* Prepare for TX DMA: */
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
