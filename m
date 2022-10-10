Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD45F9858
	for <lists+dmaengine@lfdr.de>; Mon, 10 Oct 2022 08:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJJG3x (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Oct 2022 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiJJG3w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Oct 2022 02:29:52 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4FC1580D;
        Sun,  9 Oct 2022 23:29:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VRltyp3_1665383386;
Received: from 30.97.48.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VRltyp3_1665383386)
          by smtp.aliyun-inc.com;
          Mon, 10 Oct 2022 14:29:47 +0800
Message-ID: <94f163ac-0ecd-bc4c-78df-60e254746a0d@linux.alibaba.com>
Date:   Mon, 10 Oct 2022 14:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
To:     Cixi Geng <gengcixi@gmail.com>, vkoul@kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cixi Geng <cixi.geng1@unisoc.com>
References: <20221003234929.186290-1-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221003234929.186290-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/4/2022 7:49 AM, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Audio need to request Audio CP global dma interrupt, so Audio CP
> DMA should support two-stage interrupt to adapte it.

s/adapte/adapt

> It will occur interrupt when two-stage dma channel transfer done.

I don't understand why not just set the interrupt type as 
SPRD_DMA_TRANS_INT.

> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
> Changes in v2:
>    fix the condition of 2stage_config config for each channel interrupt.
> 
>   drivers/dma/sprd-dma.c       |  8 ++++----
>   include/linux/dma/sprd-dma.h | 12 ++++++++++++
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 474d3ba8ec9f..dbcfa340a40f 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -441,7 +441,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
>   		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type & SPRD_DMA_SRC_CHN0_INT)
>   			val |= SPRD_DMA_GLB_SRC_INT;

I think you will break sprd-pcm-compress.c driver, since we will set 
SPRD_DMA_TRANS_INT interrupt type for the 2 stage transaction. Have you 
tested the sprd-pcm-compress drvier?

https://elixir.bootlin.com/linux/v6.0-rc5/source/sound/soc/sprd/sprd-pcm-compress.c#L129

>   
>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> @@ -451,7 +451,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
>   		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type & SPRD_DMA_SRC_CHN1_INT)
>   			val |= SPRD_DMA_GLB_SRC_INT;
>   
>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> @@ -461,7 +461,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
>   			SPRD_DMA_GLB_DEST_CHN_MASK;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type & SPRD_DMA_DST_CHN0_INT)
>   			val |= SPRD_DMA_GLB_DEST_INT;
>   
>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> @@ -471,7 +471,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
>   			SPRD_DMA_GLB_DEST_CHN_MASK;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type & SPRD_DMA_DST_CHN1_INT)
>   			val |= SPRD_DMA_GLB_DEST_INT;
>   
>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
> index d09c6f6f6da5..26de41d6d915 100644
> --- a/include/linux/dma/sprd-dma.h
> +++ b/include/linux/dma/sprd-dma.h
> @@ -101,6 +101,14 @@ enum sprd_dma_req_mode {
>    * is done.
>    * @SPRD_DMA_CFGERR_INT: configure error interrupt when configuration is
>    * incorrect.
> + * @SPRD_DMA_SRC_CHN0_INT: interrupt occurred when source channel0
> + * transfer is done.
> + * @SPRD_DMA_SRC_CHN1_INT: interrupt occurred when source channel1
> + * transfer is done.
> + * @SPRD_DMA_DST_CHN0_INT: interrupt occurred when destination channel0
> + * transfer is done.
> + * @SPRD_DMA_DST_CHN1_INT: interrupt occurred when destination channel1
> + * transfer is done.
>    */
>   enum sprd_dma_int_type {
>   	SPRD_DMA_NO_INT,
> @@ -112,6 +120,10 @@ enum sprd_dma_int_type {
>   	SPRD_DMA_TRANS_BLK_INT,
>   	SPRD_DMA_LIST_INT,
>   	SPRD_DMA_CFGERR_INT,
> +	SPRD_DMA_SRC_CHN0_INT,
> +	SPRD_DMA_SRC_CHN1_INT,
> +	SPRD_DMA_DST_CHN0_INT,
> +	SPRD_DMA_DST_CHN1_INT,
>   };
>   
>   /*
