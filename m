Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D962D4A0
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 09:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbiKQIGI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 03:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiKQIGA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 03:06:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9555E9F7
        for <dmaengine@vger.kernel.org>; Thu, 17 Nov 2022 00:05:54 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ovZtw-0003au-Jr; Thu, 17 Nov 2022 09:05:36 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ovZtv-0003Zc-CX; Thu, 17 Nov 2022 09:05:35 +0100
Date:   Thu, 17 Nov 2022 09:05:35 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, shengjiu.wang@nxp.com,
        martink@posteo.de, dev@lynxeye.de, alexander.stein@ew.tq-group.com,
        peng.fan@nxp.com, david@ixit.cz, aford173@gmail.com,
        hongxing.zhu@nxp.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] dmaengine: imx-sdma: support hdmi in sdma
Message-ID: <20221117080535.GF9130@pengutronix.de>
References: <20221115093823.2879128-1-joy.zou@nxp.com>
 <20221115093823.2879128-3-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115093823.2879128-3-joy.zou@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 15, 2022 at 05:38:23PM +0800, Joy Zou wrote:
> The hdmi script already supported in sdma firmware. So add support hdmi
> in sdma driver.
> 
> The design of hdmi script is different from common script such as sai.
> There is no need to config buffer descriptor for HDMI. The cyclic
> capability is achieved by the hdmi script. The slave config is so simple,
> only config src_addr, dts_addr and direction DMA_TRANS_NONE.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> Changes in v7:
>     modify the commit message.
> ---
>  drivers/dma/imx-sdma.c      | 38 +++++++++++++++++++++++++++++--------
>  include/linux/dma/imx-dma.h |  1 +
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index fbea5f62dd98..ab877ceeac3f 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -954,7 +954,10 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
>  		desc = sdmac->desc;
>  		if (desc) {
>  			if (sdmac->flags & IMX_DMA_SG_LOOP) {
> -				sdma_update_channel_loop(sdmac);
> +				if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
> +					sdma_update_channel_loop(sdmac);
> +				else
> +					vchan_cyclic_callback(&desc->vd);
>  			} else {
>  				mxc_sdma_handle_channel_normal(sdmac);
>  				vchan_cookie_complete(&desc->vd);
> @@ -1074,6 +1077,10 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
>  		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
>  		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
>  		break;
> +	case IMX_DMATYPE_HDMI:
> +		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
> +		sdmac->is_ram_script = true;
> +		break;
>  	default:
>  		dev_err(sdma->dev, "Unsupported transfer type %d\n",
>  			peripheral_type);
> @@ -1125,11 +1132,16 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	/* Send by context the event mask,base address for peripheral
>  	 * and watermark level
>  	 */
> -	context->gReg[0] = sdmac->event_mask[1];
> -	context->gReg[1] = sdmac->event_mask[0];
> -	context->gReg[2] = sdmac->per_addr;
> -	context->gReg[6] = sdmac->shp_addr;
> -	context->gReg[7] = sdmac->watermark_level;
> +	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI) {
> +		context->gReg[4] = sdmac->per_addr;
> +		context->gReg[6] = sdmac->shp_addr;
> +	} else {
> +		context->gReg[0] = sdmac->event_mask[1];
> +		context->gReg[1] = sdmac->event_mask[0];
> +		context->gReg[2] = sdmac->per_addr;
> +		context->gReg[6] = sdmac->shp_addr;
> +		context->gReg[7] = sdmac->watermark_level;
> +	}
>  
>  	bd0->mode.command = C0_SETDM;
>  	bd0->mode.status = BD_DONE | BD_WRAP | BD_EXTD;
> @@ -1513,7 +1525,7 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  	desc->sdmac = sdmac;
>  	desc->num_bd = bds;
>  
> -	if (sdma_alloc_bd(desc))
> +	if (bds && sdma_alloc_bd(desc))
>  		goto err_desc_out;
>  
>  	/* No slave_config called in MEMCPY case, so do here */
> @@ -1678,13 +1690,16 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
>  	struct sdma_engine *sdma = sdmac->sdma;
> -	int num_periods = buf_len / period_len;
> +	int num_periods = 0;
>  	int channel = sdmac->channel;
>  	int i = 0, buf = 0;
>  	struct sdma_desc *desc;
>  
>  	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
>  
> +	if (sdmac->peripheral_type != IMX_DMATYPE_HDMI)
> +		num_periods = buf_len / period_len;
> +
>  	sdma_config_write(chan, &sdmac->slave_config, direction);
>  
>  	desc = sdma_transfer_init(sdmac, direction, num_periods);
> @@ -1701,6 +1716,9 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  		goto err_bd_out;
>  	}
>  
> +	if (sdmac->peripheral_type == IMX_DMATYPE_HDMI)
> +		return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
> +
>  	while (buf < buf_len) {
>  		struct sdma_buffer_descriptor *bd = &desc->bd[i];
>  		int param;
> @@ -1761,6 +1779,10 @@ static int sdma_config_write(struct dma_chan *chan,
>  		sdmac->watermark_level |= (dmaengine_cfg->dst_maxburst << 16) &
>  			SDMA_WATERMARK_LEVEL_HWML;
>  		sdmac->word_size = dmaengine_cfg->dst_addr_width;
> +	} else if (sdmac->peripheral_type == IMX_DMATYPE_HDMI) {
> +		sdmac->per_address = dmaengine_cfg->dst_addr;
> +		sdmac->per_address2 = dmaengine_cfg->src_addr;
> +		sdmac->watermark_level = 0;
>  	} else {
>  		sdmac->per_address = dmaengine_cfg->dst_addr;
>  		sdmac->watermark_level = dmaengine_cfg->dst_maxburst *
> diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
> index f487a4fa103a..cfec5f946e23 100644
> --- a/include/linux/dma/imx-dma.h
> +++ b/include/linux/dma/imx-dma.h
> @@ -40,6 +40,7 @@ enum sdma_peripheral_type {
>  	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
>  	IMX_DMATYPE_SAI,	/* SAI */
>  	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
> +	IMX_DMATYPE_HDMI,       /* HDMI Audio */
>  };
>  
>  enum imx_dma_prio {
> -- 
> 2.37.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
