Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8D17F1AF
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 09:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgCJIT5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 04:19:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34381 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgCJIT4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Mar 2020 04:19:56 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBa6p-00069G-Gm; Tue, 10 Mar 2020 09:19:27 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jBa6n-0002TP-9h; Tue, 10 Mar 2020 09:19:25 +0100
Date:   Tue, 10 Mar 2020 09:19:25 +0100
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
Subject: Re: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Message-ID: <20200310081925.GT3335@pengutronix.de>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:04:16 up 19 days, 15:34, 45 users,  load average: 0.11, 0.18,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> ECSPI issue fixed from i.mx6ul at hardware level, no need
> ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx
> from where i.mx6ul source.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/imx-sdma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 56288d8..5ae7237 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -419,6 +419,13 @@ struct sdma_driver_data {
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
> @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q = {
>  	.script_addrs = &sdma_script_imx6q,
>  };
>  
> +static struct sdma_script_start_addrs sdma_script_imx6sx = {
> +	.ap_2_ap_addr = 642,
> +	.uart_2_mcu_addr = 817,
> +	.mcu_2_app_addr = 747,
> +	.uartsh_2_mcu_addr = 1032,
> +	.mcu_2_shp_addr = 960,
> +	.app_2_mcu_addr = 683,
> +	.shp_2_mcu_addr = 891,
> +	.spdif_2_mcu_addr = 1100,
> +	.mcu_2_spdif_addr = 1134,
> +};
> +
> +static struct sdma_driver_data sdma_imx6sx = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx6sx,
> +};
> +
> +static struct sdma_driver_data sdma_imx6ul = {
> +	.chnenbl0 = SDMA_CHNENBL0_IMX35,
> +	.num_events = 48,
> +	.script_addrs = &sdma_script_imx6sx,
> +	.ecspi_fixed = true,
> +};
> +
>  static struct sdma_script_start_addrs sdma_script_imx7d = {
>  	.ap_2_ap_addr = 644,
>  	.uart_2_mcu_addr = 819,
> @@ -584,9 +616,15 @@ static const struct platform_device_id sdma_devtypes[] = {
>  		.name = "imx6q-sdma",
>  		.driver_data = (unsigned long)&sdma_imx6q,
>  	}, {
> +		.name = "imx6sx-sdma",
> +		.driver_data = (unsigned long)&sdma_imx6sx,
> +	}, {

Now the i.MX6sx uses a new sdma_script_start_addrs entry which is the same
as the i.MX6q one we used before with one exception: it lacks the
per_2_per_addr = 6331 entry. This is only used for IMX_DMATYPE_ASRC and
IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline kernel. So
why must the i.MX6sx changed here and what has this to do with ECSPI?

Sascha

>  		.name = "imx7d-sdma",
>  		.driver_data = (unsigned long)&sdma_imx7d,
>  	}, {
> +		.name = "imx6ul-sdma",
> +		.driver_data = (unsigned long)&sdma_imx6ul,
> +	}, {
>  		.name = "imx8mq-sdma",
>  		.driver_data = (unsigned long)&sdma_imx8mq,
>  	}, {
> @@ -602,7 +640,9 @@ static const struct of_device_id sdma_dt_ids[] = {
>  	{ .compatible = "fsl,imx35-sdma", .data = &sdma_imx35, },
>  	{ .compatible = "fsl,imx31-sdma", .data = &sdma_imx31, },
>  	{ .compatible = "fsl,imx25-sdma", .data = &sdma_imx25, },
> +	{ .compatible = "fsl,imx6sx-sdma", .data = &sdma_imx6sx, },
>  	{ .compatible = "fsl,imx7d-sdma", .data = &sdma_imx7d, },
> +	{ .compatible = "fsl,imx6ul-sdma", .data = &sdma_imx6ul, },
>  	{ .compatible = "fsl,imx8mq-sdma", .data = &sdma_imx8mq, },
>  	{ /* sentinel */ }
>  };
> @@ -1169,8 +1209,17 @@ static int sdma_config_channel(struct dma_chan *chan)
>  			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
>  			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
>  				sdma_set_watermarklevel_for_p2p(sdmac);
> -		} else
> +		} else {
> +			/*
> +			 * ERR009165 fixed from i.mx6ul, no errata need,
> +			 * set bit31 to let sdma script skip the errata.
> +			 */
> +			if (sdmac->peripheral_type == IMX_DMATYPE_CSPI &&
> +			    sdmac->direction == DMA_MEM_TO_DEV &&
> +			    sdmac->sdma->drvdata->ecspi_fixed)
> +				__set_bit(31, &sdmac->watermark_level);
>  			__set_bit(sdmac->event_id0, sdmac->event_mask);
> +		}
>  
>  		/* Address */
>  		sdmac->shp_addr = sdmac->per_address;
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
