Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D397F604975
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJSOkb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiJSOkJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:40:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D253A157F68;
        Wed, 19 Oct 2022 07:25:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676B6617FE;
        Wed, 19 Oct 2022 14:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14770C433C1;
        Wed, 19 Oct 2022 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666189498;
        bh=qtELXB0QXhax+1b+LBzDwFls1i+mOZ2KCsyxiqtBldA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hz4WzVCzq0HUqkpNEIz4SATXi8H7jRUA/q0jjKTZSNSf3iGHlzc7S4ymDR01VHVM+
         9RVuqmt3yIEAMUWKvJ7EDyByyLq4+vcJW21YEB7V3J+bk+TNbKSYkOMu7d9Kgdm8Sz
         E79IGfVSzPy0Z+JZd0vK7K6D9RYRECJlA0WImxF/fLyBjw3qEwCt+8bMi8/dU0NRQd
         Pm5ZgLTP3XOnJsQvZ8biHGY52G0jSHy3mAF31Vq68BsQBm9zoJr2BtViW7SFyKZ2r1
         jsiDt/25i8Agj9wB+OpzUlfpjYHh2XBXyLYw6GH3WogoDjNE5wtxt29FNRID0Hqmzg
         Ew7rrNsL9esbw==
Date:   Wed, 19 Oct 2022 19:54:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shengjiu.wang@nxp.com, martink@posteo.de,
        dev@lynxeye.de, alexander.stein@ew.tq-group.com, peng.fan@nxp.com,
        david@ixit.cz, aford173@gmail.com, hongxing.zhu@nxp.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] dmaengine: imx-sdma: support hdmi audio
Message-ID: <Y1AIte+S1sHw2qju@matsya>
References: <20220906094256.3787384-1-joy.zou@nxp.com>
 <20220906094256.3787384-3-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906094256.3787384-3-joy.zou@nxp.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-09-22, 17:42, Joy Zou wrote:
> Add hdmi audio support in sdma.

Pls add description in changelog about what it takes to enabled hdmi
(cyclic support etc)

> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
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

-- 
~Vinod
