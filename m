Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA89771C44
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHGI1X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGI1X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 04:27:23 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944C10EF;
        Mon,  7 Aug 2023 01:27:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VpDH3HQ_1691396836;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpDH3HQ_1691396836)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 16:27:17 +0800
Message-ID: <522e9d29-fab2-5bb0-c2d3-9cf908007000@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 16:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/5] dma: optimize two stage transfer function
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20230807052028.2854-1-kaiwei.liu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230807052028.2854-1-kaiwei.liu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/7/2023 1:20 PM, Kaiwei Liu wrote:
> The DMA hardware is updated to optimize two stages transmission
> function, so modify relative register and logic. Two
> stages transmission mode of dma allows one channel finished
> transmission then start another channel transfer automatically.
> 
> Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
> ---
>   drivers/dma/sprd-dma.c | 124 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 91 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 0e146550dfbb..01053e106e8a 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -68,6 +68,7 @@
>   #define SPRD_DMA_GLB_TRANS_DONE_TRG	BIT(18)
>   #define SPRD_DMA_GLB_BLOCK_DONE_TRG	BIT(17)
>   #define SPRD_DMA_GLB_FRAG_DONE_TRG	BIT(16)
> +#define SPRD_DMA_GLB_TRG_MASK		GENMASK(19, 16)
>   #define SPRD_DMA_GLB_TRG_OFFSET		16
>   #define SPRD_DMA_GLB_DEST_CHN_MASK	GENMASK(13, 8)
>   #define SPRD_DMA_GLB_DEST_CHN_OFFSET	8
> @@ -155,6 +156,13 @@
>   
>   #define SPRD_DMA_SOFTWARE_UID		0
>   
> +#define SPRD_DMA_SRC_CHN0_INT		9
> +#define SPRD_DMA_SRC_CHN1_INT		10
> +#define SPRD_DMA_DST_CHN0_INT		11
> +#define SPRD_DMA_DST_CHN1_INT		12
> +#define SPRD_DMA_2STAGE_SET		1
> +#define SPRD_DMA_2STAGE_CLEAR		0

This 2 are not hardware definition, and I don't think they are helpful, 
just use a boolean parameter.

> +
>   /* dma data width values */
>   enum sprd_dma_datawidth {
>   	SPRD_DMA_DATAWIDTH_1_BYTE,
> @@ -212,7 +220,7 @@ struct sprd_dma_dev {
>   	struct clk		*ashb_clk;
>   	int			irq;
>   	u32			total_chns;
> -	struct sprd_dma_chn	channels[];
> +	struct sprd_dma_chn	channels[0];

Please remove redundant changes.

>   };
>   
>   static void sprd_dma_free_desc(struct virt_dma_desc *vd);
> @@ -431,50 +439,90 @@ static enum sprd_dma_req_mode sprd_dma_get_req_type(struct sprd_dma_chn *schan)
>   	return (frag_reg >> SPRD_DMA_REQ_MODE_OFFSET) & SPRD_DMA_REQ_MODE_MASK;
>   }
>   
> -static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> +static int sprd_dma_2stage_config(struct sprd_dma_chn *schan, u32 config_type)

Why change the function name? 'config_type' should be boolean.

>   {
>   	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
>   	u32 val, chn = schan->chn_num + 1;
>   
>   	switch (schan->chn_mode) {
>   	case SPRD_DMA_SRC_CHN0:
> -		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> -		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_SRC_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> +		if (config_type == SPRD_DMA_2STAGE_SET) {
> +			val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> +			val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> +			val |= SPRD_DMA_GLB_2STAGE_EN;
> +			if (schan->int_type & SPRD_DMA_SRC_CHN0_INT)

can you explain why change the interrupt validation? ignore other 
interrupt type?

> +				val |= SPRD_DMA_GLB_SRC_INT;
> +
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
> +					    SPRD_DMA_GLB_SRC_INT |
> +					    SPRD_DMA_GLB_TRG_MASK |
> +					    SPRD_DMA_GLB_SRC_CHN_MASK, val);
> +		} else {
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
> +					    SPRD_DMA_GLB_SRC_INT |
> +					    SPRD_DMA_GLB_TRG_MASK |
> +					    SPRD_DMA_GLB_2STAGE_EN |
> +					    SPRD_DMA_GLB_SRC_CHN_MASK, 0);
> +		}
>   		break;
>   
>   	case SPRD_DMA_SRC_CHN1:
> -		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> -		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_SRC_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> +		if (config_type == SPRD_DMA_2STAGE_SET) {
> +			val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> +			val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> +			val |= SPRD_DMA_GLB_2STAGE_EN;
> +			if (schan->int_type & SPRD_DMA_SRC_CHN1_INT)
> +				val |= SPRD_DMA_GLB_SRC_INT;
> +
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
> +					    SPRD_DMA_GLB_SRC_INT |
> +					    SPRD_DMA_GLB_TRG_MASK |
> +					    SPRD_DMA_GLB_SRC_CHN_MASK, val);
> +		} else {
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
> +					    SPRD_DMA_GLB_SRC_INT |
> +					    SPRD_DMA_GLB_TRG_MASK |
> +					    SPRD_DMA_GLB_2STAGE_EN |
> +					    SPRD_DMA_GLB_SRC_CHN_MASK, 0);
> +		}
>   		break;
>   
>   	case SPRD_DMA_DST_CHN0:
> -		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> -			SPRD_DMA_GLB_DEST_CHN_MASK;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_DEST_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> +		if (config_type == SPRD_DMA_2STAGE_SET) {
> +			val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> +				SPRD_DMA_GLB_DEST_CHN_MASK;
> +			val |= SPRD_DMA_GLB_2STAGE_EN;
> +			if (schan->int_type & SPRD_DMA_DST_CHN0_INT)
> +				val |= SPRD_DMA_GLB_DEST_INT;
> +
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
> +					    SPRD_DMA_GLB_DEST_INT |
> +					    SPRD_DMA_GLB_DEST_CHN_MASK, val);
> +		} else {
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1,
> +					    SPRD_DMA_GLB_DEST_INT |
> +					    SPRD_DMA_GLB_2STAGE_EN |
> +					    SPRD_DMA_GLB_DEST_CHN_MASK, 0);
> +		}
>   		break;
>   
>   	case SPRD_DMA_DST_CHN1:
> -		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> -			SPRD_DMA_GLB_DEST_CHN_MASK;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_DEST_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> +		if (config_type == SPRD_DMA_2STAGE_SET) {
> +			val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> +				SPRD_DMA_GLB_DEST_CHN_MASK;
> +			val |= SPRD_DMA_GLB_2STAGE_EN;
> +			if (schan->int_type & SPRD_DMA_DST_CHN1_INT)
> +				val |= SPRD_DMA_GLB_DEST_INT;
> +
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
> +					    SPRD_DMA_GLB_DEST_INT |
> +					    SPRD_DMA_GLB_DEST_CHN_MASK, val);
> +		} else {
> +			sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2,
> +					    SPRD_DMA_GLB_DEST_INT |
> +					    SPRD_DMA_GLB_2STAGE_EN |
> +					    SPRD_DMA_GLB_DEST_CHN_MASK, 0);
> +		}
>   		break;
>   
>   	default:
> @@ -545,7 +593,7 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
>   	 * Set 2-stage configuration if the channel starts one 2-stage
>   	 * transfer.
>   	 */
> -	if (schan->chn_mode && sprd_dma_set_2stage_config(schan))
> +	if (schan->chn_mode && sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_SET))
>   		return;
>   
>   	/*
> @@ -569,6 +617,12 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
>   	sprd_dma_set_pending(schan, false);
>   	sprd_dma_unset_uid(schan);
>   	sprd_dma_clear_int(schan);
> +	/*
> +	 * If 2-stage transfer is used, the configuration must be clear
> +	 * when release DMA channel.

Please explain why? not only 'what'.

> +	 */
> +	if (schan->chn_mode)
> +		sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_CLEAR);

How to ensure backward compatibility with previous SPRD DMA IP?

>   	schan->cur_desc = NULL;
>   }
>   
> @@ -757,7 +811,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>   	phys_addr_t llist_ptr;
>   
>   	if (dir == DMA_MEM_TO_DEV) {
> -		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
> +		src_step = slave_cfg->src_port_window_size ?
> +			   slave_cfg->src_port_window_size :
> +			   sprd_dma_get_step(slave_cfg->src_addr_width);

Please also explain why.

>   		if (src_step < 0) {
>   			dev_err(sdev->dma_dev.dev, "invalid source step\n");
>   			return src_step;
> @@ -773,7 +829,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>   		else
>   			dst_step = SPRD_DMA_NONE_STEP;
>   	} else {
> -		dst_step = sprd_dma_get_step(slave_cfg->dst_addr_width);
> +		dst_step = slave_cfg->dst_port_window_size ?
> +			   slave_cfg->dst_port_window_size :
> +			   sprd_dma_get_step(slave_cfg->dst_addr_width);
>   		if (dst_step < 0) {
>   			dev_err(sdev->dma_dev.dev, "invalid destination step\n");
>   			return dst_step;
