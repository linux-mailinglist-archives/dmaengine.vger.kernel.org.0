Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E33C7FE6
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhGNIVJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 04:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhGNIVI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Jul 2021 04:21:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E95C061760
        for <dmaengine@vger.kernel.org>; Wed, 14 Jul 2021 01:18:17 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m3a5h-0005Hf-Ex; Wed, 14 Jul 2021 10:18:01 +0200
Message-ID: <152cb353c4c6fe66ba40c084cd62947967080011.camel@pengutronix.de>
Subject: Re: [PATCH v16 09/12] dmaengine: imx-sdma: remove ERR009165 on
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
Date:   Wed, 14 Jul 2021 10:17:59 +0200
In-Reply-To: <1626258052-22198-10-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
         <1626258052-22198-10-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Mittwoch, dem 14.07.2021 um 18:20 +0800 schrieb Robin Gong:
> ECSPI issue fixed from i.mx6ul at hardware level, no need
> ERR009165 anymore on those chips such as i.mx8mq.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5969df8..cfcd413 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -476,6 +476,13 @@ struct sdma_driver_data {
>  	int num_events;
>  	struct sdma_script_start_addrs	*script_addrs;
>  	bool check_ratio;
> +	/*
> +	 * ecspi ERR009165 fixed should be done in sdma script
> +	 * and it has been fixed in soc from i.mx6ul.
> +	 * please get more information from the below link:
> +	 * https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> +	 */
> +	bool ecspi_fixed;
>  };
>  
>  struct sdma_engine {
> @@ -596,6 +603,13 @@ static struct sdma_driver_data sdma_imx6q = {
>  	.script_addrs = &sdma_script_imx6q,
>  };
>  
> +static struct sdma_driver_data sdma_imx6ul = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx6q,
> +	.ecspi_fixed = true,
> +};
> +
>  static struct sdma_script_start_addrs sdma_script_imx7d = {
>  	.ap_2_ap_addr = 644,
>  	.uart_2_mcu_addr = 819,
> @@ -629,6 +643,7 @@ static const struct of_device_id sdma_dt_ids[] = {
>  	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
>  	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
>  	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
> +	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
>  	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
>  	{ /* sentinel */ }
>  };
> @@ -948,8 +963,15 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  		break;
>  	case IMX_DMATYPE_CSPI:
>  		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
> -		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
> -		sdmac->is_ram_script = true;
> +
> +		/* Use rom script mcu_2_app if ERR009165 fixed */
> +		if (sdmac->sdma->drvdata->ecspi_fixed) {
> +			emi_2_per = sdma->script_addrs->mcu_2_app_addr;
> +		} else {
> +			emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
> +			sdmac->is_ram_script = true;
> +		}
> +
>  		break;
>  	case IMX_DMATYPE_EXT:
>  	case IMX_DMATYPE_SSI:


