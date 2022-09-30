Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96D5F04FF
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 08:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiI3GmQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiI3GmO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 02:42:14 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF95161CD2;
        Thu, 29 Sep 2022 23:42:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VR0h1jk_1664520126;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VR0h1jk_1664520126)
          by smtp.aliyun-inc.com;
          Fri, 30 Sep 2022 14:42:07 +0800
Message-ID: <bd3ce49b-f887-1021-f21f-4e57ade1ba25@linux.alibaba.com>
Date:   Fri, 30 Sep 2022 14:42:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dmaengine: sprd: Support two-stage dma interrupt
To:     Cixi Geng <gengcixi@gmail.com>, vkoul@kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220930055331.138868-1-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220930055331.138868-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cixi,

On 9/30/2022 1:53 PM, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Audio need to request Audio CP global dma interrupt, so Audio CP
> DMA should support two-stage interrupt to adapte it.
> It will occur interrupt when two-stage dma channel transfer done.

If the AP does not want the interrupt, why not just set SPRD_DMA_NO_INT?

I am struggling to understand the whole requirement, could you elaborate?

> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>   drivers/dma/sprd-dma.c       |  8 ++++----
>   include/linux/dma/sprd-dma.h | 12 ++++++++++++
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 474d3ba8ec9f..7a9ade422a00 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -441,7 +441,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
>   		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type != SPRD_DMA_SRC_CHN0_INT)
>   			val |= SPRD_DMA_GLB_SRC_INT;

That does not make sense to me. If user configues the interrupt type as 
SPRD_DMA_NO_INT, the code will still enable the source interrupt.

If user configures the interrupt type as SPRD_DMA_SRC_CHN0_INT, you will 
disable the source interrupt? Confusing...

>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> @@ -451,7 +451,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
>   		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type != SPRD_DMA_SRC_CHN1_INT)
>   			val |= SPRD_DMA_GLB_SRC_INT;
>   
>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
> @@ -461,7 +461,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
>   			SPRD_DMA_GLB_DEST_CHN_MASK;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type != SPRD_DMA_DST_CHN0_INT)
>   			val |= SPRD_DMA_GLB_DEST_INT;
>   
>   		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
> @@ -471,7 +471,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
>   		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
>   			SPRD_DMA_GLB_DEST_CHN_MASK;
>   		val |= SPRD_DMA_GLB_2STAGE_EN;
> -		if (schan->int_type != SPRD_DMA_NO_INT)
> +		if (schan->int_type != SPRD_DMA_DST_CHN1_INT)
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
