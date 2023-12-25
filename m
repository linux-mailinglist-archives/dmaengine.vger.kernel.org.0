Return-Path: <dmaengine+bounces-654-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783DE81DEBD
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 08:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D991A1F216E2
	for <lists+dmaengine@lfdr.de>; Mon, 25 Dec 2023 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B35101D8;
	Mon, 25 Dec 2023 07:05:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65B101C1;
	Mon, 25 Dec 2023 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vz8RevF_1703487897;
Received: from 30.97.48.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vz8RevF_1703487897)
          by smtp.aliyun-inc.com;
          Mon, 25 Dec 2023 15:04:58 +0800
Message-ID: <6e0a104a-1f99-4686-ba76-99ef631b0d25@linux.alibaba.com>
Date: Mon, 25 Dec 2023 15:05:21 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] dmaengine: sprd: optimize two stage transfer
 function
To: Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kaiwei liu <liukaiwei086@gmail.com>, Wenming Wu <wenming.wu@unisoc.com>
References: <20231222112746.9720-1-kaiwei.liu@unisoc.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231222112746.9720-1-kaiwei.liu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/22/2023 7:27 PM, Kaiwei Liu wrote:
> From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
> 
> For SPRD DMA, it provides a function that one channel can start
> the second channel after completing the transmission, which we
> call two stage transfer mode. You can choose which channel can
> generate interrupt when finished. It can support up to two sets
> of such patterns.
> When configuring registers for two stage transfer mode, we need
> to set the mask bit to ensure that the setting are accurate. And
> we should clear the two stage transfer configuration when release
> DMA channel.
> The two stage transfer function is mainly used by SPRD audio, and
> now audio also requires that the data need to be accessed on the
> device side. So here use the src_port_window_size and dst_port_win-
> dow_size in the struct of dma_slave_config.
> 
> Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>

It seems you ignored my previous comments[1], please make sure they are 
addressed firstly.

[1] 
https://lore.kernel.org/all/522e9d29-fab2-5bb0-c2d3-9cf908007000@linux.alibaba.com/

> ---
> Change in V2
> -change because [PATCH 1/2]
> ---
>   drivers/dma/sprd-dma.c | 116 ++++++++++++++++++++++++-----------------
>   1 file changed, 69 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index cb48731d70b2..e9e113142fd2 100644
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
> +
>   /* dma data width values */
>   enum sprd_dma_datawidth {
>   	SPRD_DMA_DATAWIDTH_1_BYTE,
> @@ -431,53 +439,57 @@ static enum sprd_dma_req_mode sprd_dma_get_req_type(struct sprd_dma_chn *schan)
>   	return (frag_reg >> SPRD_DMA_REQ_MODE_OFFSET) & SPRD_DMA_REQ_MODE_MASK;
>   }
>   
> -static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> +static void sprd_dma_2stage_write(struct sprd_dma_chn *schan,
> +				  u32 config_type, u32 grp_offset)
>   {
>   	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
> -	u32 val, chn = schan->chn_num + 1;
> -
> -	switch (schan->chn_mode) {
> -	case SPRD_DMA_SRC_CHN0:
> -		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> -		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_SRC_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> -		break;
> -
> -	case SPRD_DMA_SRC_CHN1:
> -		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> -		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_SRC_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> -		break;
> -
> -	case SPRD_DMA_DST_CHN0:
> -		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> -			SPRD_DMA_GLB_DEST_CHN_MASK;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_DEST_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> -		break;
> -
> -	case SPRD_DMA_DST_CHN1:
> -		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> -			SPRD_DMA_GLB_DEST_CHN_MASK;
> -		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> -			val |= SPRD_DMA_GLB_DEST_INT;
> -
> -		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> -		break;
> +	u32 mask_val;
> +	u32 chn = schan->chn_num + 1;
> +	u32 val = 0;
> +
> +	if (config_type == SPRD_DMA_2STAGE_SET) {
> +		if (schan->chn_mode == SPRD_DMA_SRC_CHN0 ||
> +		    schan->chn_mode == SPRD_DMA_SRC_CHN1) {
> +			val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> +			val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> +			val |= SPRD_DMA_GLB_2STAGE_EN;
> +			if (schan->int_type & SPRD_DMA_SRC_CHN0_INT ||
> +			    schan->int_type & SPRD_DMA_SRC_CHN1_INT)
> +				val |= SPRD_DMA_GLB_SRC_INT;
> +			mask_val = SPRD_DMA_GLB_SRC_INT | SPRD_DMA_GLB_TRG_MASK |
> +				   SPRD_DMA_GLB_SRC_CHN_MASK;
> +		} else {
> +			val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> +			       SPRD_DMA_GLB_DEST_CHN_MASK;
> +			val |= SPRD_DMA_GLB_2STAGE_EN;
> +			if (schan->int_type & SPRD_DMA_DST_CHN0_INT ||
> +			    schan->int_type & SPRD_DMA_DST_CHN1_INT)
> +				val |= SPRD_DMA_GLB_DEST_INT;
> +			mask_val = SPRD_DMA_GLB_DEST_INT | SPRD_DMA_GLB_DEST_CHN_MASK;
> +		}
> +	} else {
> +		if (schan->chn_mode == SPRD_DMA_SRC_CHN0 ||
> +		    schan->chn_mode == SPRD_DMA_SRC_CHN1)
> +			mask_val = SPRD_DMA_GLB_SRC_INT | SPRD_DMA_GLB_TRG_MASK |
> +				   SPRD_DMA_GLB_2STAGE_EN | SPRD_DMA_GLB_SRC_CHN_MASK;
> +		else
> +			mask_val = SPRD_DMA_GLB_DEST_INT | SPRD_DMA_GLB_2STAGE_EN |
> +				   SPRD_DMA_GLB_DEST_CHN_MASK;
> +	}
> +	sprd_dma_glb_update(sdev, grp_offset, mask_val, val);
> +}
>   
> -	default:
> +static int sprd_dma_2stage_config(struct sprd_dma_chn *schan, u32 config_type)
> +{
> +	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
> +
> +	if (schan->chn_mode == SPRD_DMA_SRC_CHN0 ||
> +	    schan->chn_mode == SPRD_DMA_DST_CHN0)
> +		sprd_dma_2stage_write(schan, config_type, SPRD_DMA_GLB_2STAGE_GRP1);
> +	else if (schan->chn_mode == SPRD_DMA_SRC_CHN1 ||
> +		 schan->chn_mode == SPRD_DMA_DST_CHN1)
> +		sprd_dma_2stage_write(schan, config_type, SPRD_DMA_GLB_2STAGE_GRP2);
> +	else {
>   		dev_err(sdev->dma_dev.dev, "invalid channel mode setting %d\n",
>   			schan->chn_mode);
>   		return -EINVAL;
> @@ -545,7 +557,7 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
>   	 * Set 2-stage configuration if the channel starts one 2-stage
>   	 * transfer.
>   	 */
> -	if (schan->chn_mode && sprd_dma_set_2stage_config(schan))
> +	if (schan->chn_mode && sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_SET))
>   		return;
>   
>   	/*
> @@ -569,6 +581,12 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
>   	sprd_dma_set_pending(schan, false);
>   	sprd_dma_unset_uid(schan);
>   	sprd_dma_clear_int(schan);
> +	/*
> +	 * If 2-stage transfer is used, the configuration must be clear
> +	 * when release DMA channel.
> +	 */
> +	if (schan->chn_mode)
> +		sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_CLEAR);
>   	schan->cur_desc = NULL;
>   }
>   
> @@ -757,7 +775,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>   	phys_addr_t llist_ptr;
>   
>   	if (dir == DMA_MEM_TO_DEV) {
> -		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
> +		src_step = slave_cfg->src_port_window_size ?
> +			   slave_cfg->src_port_window_size :
> +			   sprd_dma_get_step(slave_cfg->src_addr_width);
>   		if (src_step < 0) {
>   			dev_err(sdev->dma_dev.dev, "invalid source step\n");
>   			return src_step;
> @@ -773,7 +793,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
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

