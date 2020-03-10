Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E06417F161
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 09:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgCJIC6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 04:02:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCJIC5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Mar 2020 04:02:57 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBZqd-0003q9-DC; Tue, 10 Mar 2020 09:02:43 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBZqb-000205-1H; Tue, 10 Mar 2020 09:02:41 +0100
Date:   Tue, 10 Mar 2020 09:02:41 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND v6  07/13] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Message-ID: <20200310080240.GS3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-8-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583839922-22699-8-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:40:21 up 19 days, 15:10, 46 users,  load average: 0.37, 0.19,
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

On Tue, Mar 10, 2020 at 07:31:56PM +0800, Robin Gong wrote:
> ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
> i.mx8m/8mm still need this errata. Please refer to nxp official
> errata document from https://www.nxp.com/ .
> 
> For removing workaround on those chips. Add new i.mx6ul type.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-imx.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 842a86e..f7ee2ec 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -57,6 +57,7 @@ enum spi_imx_devtype {
>  	IMX35_CSPI,	/* CSPI on all i.mx except above */
>  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
>  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
>  };
>  
>  struct spi_imx_data;
> @@ -75,6 +76,11 @@ struct spi_imx_devtype_data {
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
> @@ -128,7 +134,8 @@ static inline int is_imx35_cspi(struct spi_imx_data *d)
>  
>  static inline int is_imx51_ecspi(struct spi_imx_data *d)
>  {
> -	return d->devtype_data->devtype == IMX51_ECSPI;
> +	return d->devtype_data->devtype == IMX51_ECSPI ||
> +	       d->devtype_data->devtype == IMX6UL_ECSPI;
>  }

Erm, no. A i.MX51 ECSPI is a i.MX51 ECSPI and not a i.MX6UL ECSPI. If
you want to handle them equally somewhere then explicitly test for
i.MX6ul *and* i.MX51 there.

>  
>  static inline int is_imx53_ecspi(struct spi_imx_data *d)
> @@ -585,9 +592,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> -	/* ERR009165: work in XHC mode as PIO */
> -	if (spi_imx->usedma)
> -		ctrl &= ~MX51_ECSPI_CTRL_SMC;
> +	/*
> +	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
> +	 * before i.mx6ul.
> +	 */
> +	if (spi_imx->usedma) {
> +		if (spi_imx->devtype_data->tx_glitch_fixed)
> +			ctrl |= MX51_ECSPI_CTRL_SMC;
> +		else
> +			ctrl &= ~MX51_ECSPI_CTRL_SMC;
> +	}

Changed again, but the PIO case still not honoured. This should look
like
	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
		ctrl |= MX51_ECSPI_CTRL_SMC;
	else
		ctrl &= ~MX51_ECSPI_CTRL_SMC;

>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  
> @@ -615,6 +629,8 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
>  {
>  	u32 tx_wml = 0;
>  
> +	if (spi_imx->devtype_data->tx_glitch_fixed)
> +		tx_wml = spi_imx->wml;

That explains the variable introduced in the last patch, ok.

I have the impression that splitting up 06/13 and 07/13 into two patches
doesn't make it easier to review.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
