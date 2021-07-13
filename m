Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331193C6EA7
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhGMKhx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhGMKhu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jul 2021 06:37:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458EEC0613DD
        for <dmaengine@vger.kernel.org>; Tue, 13 Jul 2021 03:35:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m3FkW-0001lP-3A; Tue, 13 Jul 2021 12:34:48 +0200
Message-ID: <338c8a458b97799d47d9686634d35f75b408ea47.camel@pengutronix.de>
Subject: Re: [PATCH v15 08/12] spi: imx: remove ERR009165 workaround on
 i.mx6ul
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 13 Jul 2021 12:34:46 +0200
In-Reply-To: <1626201709-19643-9-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
         <1626201709-19643-9-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Mittwoch, dem 14.07.2021 um 02:41 +0800 schrieb Robin Gong:
> ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
> i.mx8m/8mm still need this errata. Please refer to nxp official
> errata document from https://www.nxp.com/ .
> 
> For removing workaround on those chips. Add new i.mx6ul type.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/spi/spi-imx.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 61e4fa0..63a8d7b 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -77,6 +77,11 @@ struct spi_imx_devtype_data {
>  	bool has_slavemode;
>  	unsigned int fifo_size;
>  	bool dynamic_burst;
> +	/*
> +	 * ERR009165 fixed or not:
> +	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> +	 */
> +	bool tx_glitch_fixed;
>  	enum spi_imx_devtype devtype;
>  };
>  
> @@ -608,8 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> -	/* ERR009165: work in XHC mode as PIO */
> -	ctrl &= ~MX51_ECSPI_CTRL_SMC;
> +	/*
> +	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
> +	 * before i.mx6ul.
> +	 */
> +	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
> +		ctrl |= MX51_ECSPI_CTRL_SMC;
> +	else
> +		ctrl &= ~MX51_ECSPI_CTRL_SMC;
>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  
> @@ -618,12 +629,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  
>  static void mx51_setup_wml(struct spi_imx_data *spi_imx)
>  {
> +	u32 tx_wml = 0;
> +
> +	if (spi_imx->devtype_data->tx_glitch_fixed)
> +		tx_wml = spi_imx->wml;
>  	/*
>  	 * Configure the DMA register: setup the watermark
>  	 * and enable DMA request.
>  	 */
>  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> -		MX51_ECSPI_DMA_TX_WML(0) |
> +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
>  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
>  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
>  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
> @@ -1014,6 +1029,23 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
>  	.devtype = IMX53_ECSPI,
>  };
>  
> +static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
> +	.intctrl = mx51_ecspi_intctrl,
> +	.prepare_message = mx51_ecspi_prepare_message,
> +	.prepare_transfer = mx51_ecspi_prepare_transfer,
> +	.trigger = mx51_ecspi_trigger,
> +	.rx_available = mx51_ecspi_rx_available,
> +	.reset = mx51_ecspi_reset,
> +	.setup_wml = mx51_setup_wml,
> +	.fifo_size = 64,
> +	.has_dmamode = true,
> +	.dynamic_burst = true,
> +	.has_slavemode = true,
> +	.tx_glitch_fixed = true,
> +	.disable = mx51_ecspi_disable,
> +	.devtype = IMX51_ECSPI,
> +};
> +
>  static const struct of_device_id spi_imx_dt_ids[] = {
>  	{ .compatible = "fsl,imx1-cspi", .data = &imx1_cspi_devtype_data, },
>  	{ .compatible = "fsl,imx21-cspi", .data = &imx21_cspi_devtype_data, },
> @@ -1022,6 +1054,7 @@ static const struct of_device_id spi_imx_dt_ids[] = {
>  	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
>  	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
>  	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
> +	{ .compatible = "fsl,imx6ul-ecspi", .data = &imx6ul_ecspi_devtype_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, spi_imx_dt_ids);


