Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90937E1C1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfD2MBW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 08:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfD2MBW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 08:01:22 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAE3B2053B;
        Mon, 29 Apr 2019 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556539281;
        bh=DbIFoJQ0NjskWCgR2+Q/6spBpIIZcCw2op2ve10iRqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MhIcf0lP7BFFL2RENHkggZTMclJN4Ls4fuywMSRn+E/0bpfOjpVTfATR6qSV9F0bQ
         ZlDaY5C2MNIC2N/yrdUKmyxKEm3mfxgp6p75OYWAZJncJdhfaVdZWnP8ppLx7dTinq
         5TUM5Knxz4BNRMHMEXYHWb7D7MlbT+5w99XNoDgo=
Date:   Mon, 29 Apr 2019 17:31:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@unisoc.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dmaengine: sprd: Add interrupt support for 2-stage
 transfer
Message-ID: <20190429120108.GL3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <07c070b4397296a4500d04abe16dfd8a71a2f211.1555330115.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c070b4397296a4500d04abe16dfd8a71a2f211.1555330115.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-19, 20:15, Baolin Wang wrote:
> For 2-stage transfer, some users like Audio still need transaction interrupt
> to notify when the 2-stage transfer is completed. Thus we should enable
> 2-stage transfer interrupt to support this feature.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/sprd-dma.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index cc9c24d..4c18f44 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -62,6 +62,8 @@
>  /* SPRD_DMA_GLB_2STAGE_GRP register definition */
>  #define SPRD_DMA_GLB_2STAGE_EN		BIT(24)
>  #define SPRD_DMA_GLB_CHN_INT_MASK	GENMASK(23, 20)
> +#define SPRD_DMA_GLB_DEST_INT		BIT(22)
> +#define SPRD_DMA_GLB_SRC_INT		BIT(20)
>  #define SPRD_DMA_GLB_LIST_DONE_TRG	BIT(19)
>  #define SPRD_DMA_GLB_TRANS_DONE_TRG	BIT(18)
>  #define SPRD_DMA_GLB_BLOCK_DONE_TRG	BIT(17)
> @@ -135,6 +137,7 @@
>  /* define DMA channel mode & trigger mode mask */
>  #define SPRD_DMA_CHN_MODE_MASK		GENMASK(7, 0)
>  #define SPRD_DMA_TRG_MODE_MASK		GENMASK(7, 0)
> +#define SPRD_DMA_INT_TYPE_MASK		GENMASK(7, 0)
>  
>  /* define the DMA transfer step type */
>  #define SPRD_DMA_NONE_STEP		0
> @@ -190,6 +193,7 @@ struct sprd_dma_chn {
>  	u32			dev_id;
>  	enum sprd_dma_chn_mode	chn_mode;
>  	enum sprd_dma_trg_mode	trg_mode;
> +	enum sprd_dma_int_type	int_type;
>  	struct sprd_dma_desc	*cur_desc;
>  };
>  
> @@ -429,6 +433,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>  		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
>  		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
>  		val |= SPRD_DMA_GLB_2STAGE_EN;
> +		if (schan->int_type != SPRD_DMA_NO_INT)

Who configure int_type?

> +			val |= SPRD_DMA_GLB_SRC_INT;
> +
>  		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
>  		break;
>  
> @@ -436,6 +443,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>  		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
>  		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
>  		val |= SPRD_DMA_GLB_2STAGE_EN;
> +		if (schan->int_type != SPRD_DMA_NO_INT)
> +			val |= SPRD_DMA_GLB_SRC_INT;
> +
>  		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
>  		break;
>  
> @@ -443,6 +453,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>  		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
>  			SPRD_DMA_GLB_DEST_CHN_MASK;
>  		val |= SPRD_DMA_GLB_2STAGE_EN;
> +		if (schan->int_type != SPRD_DMA_NO_INT)
> +			val |= SPRD_DMA_GLB_DEST_INT;
> +
>  		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
>  		break;
>  
> @@ -450,6 +463,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>  		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
>  			SPRD_DMA_GLB_DEST_CHN_MASK;
>  		val |= SPRD_DMA_GLB_2STAGE_EN;
> +		if (schan->int_type != SPRD_DMA_NO_INT)
> +			val |= SPRD_DMA_GLB_DEST_INT;
> +
>  		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
>  		break;
>  
> @@ -911,11 +927,15 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
>  		schan->linklist.virt_addr = 0;
>  	}
>  
> -	/* Set channel mode and trigger mode for 2-stage transfer */
> +	/*
> +	 * Set channel mode, interrupt mode and trigger mode for 2-stage
> +	 * transfer.
> +	 */
>  	schan->chn_mode =
>  		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
>  	schan->trg_mode =
>  		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
> +	schan->int_type = flags & SPRD_DMA_INT_TYPE_MASK;
>  
>  	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
>  	if (!sdesc)
> -- 
> 1.7.9.5

-- 
~Vinod
