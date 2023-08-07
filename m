Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF386771BB6
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHGHnM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjHGHnL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 03:43:11 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5352010D4;
        Mon,  7 Aug 2023 00:43:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VpBxhTy_1691394185;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpBxhTy_1691394185)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 15:43:06 +0800
Message-ID: <cef5d9ad-7b29-f09f-f88b-2fd78451165b@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 15:43:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] dma: delect redundant parameter for dma driver
 function
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20230807051907.2713-1-kaiwei.liu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230807051907.2713-1-kaiwei.liu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/7/2023 1:19 PM, Kaiwei Liu wrote:
> The parameter *sdesc in function sprd_dma_check_trans_done is not
> used, so here delect redundant parameter.
> 
> Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>

The subject line should be "dmaengine: sprd: xxx", and please also 
change all your following patches.

With subject line fixed, you can add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/dma/sprd-dma.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 2b639adb48ba..20c3cb1ef2f5 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -572,8 +572,7 @@ static void sprd_dma_stop(struct sprd_dma_chn *schan)
>   	schan->cur_desc = NULL;
>   }
>   
> -static bool sprd_dma_check_trans_done(struct sprd_dma_desc *sdesc,
> -				      enum sprd_dma_int_type int_type,
> +static bool sprd_dma_check_trans_done(enum sprd_dma_int_type int_type,
>   				      enum sprd_dma_req_mode req_mode)
>   {
>   	if (int_type == SPRD_DMA_NO_INT)
> @@ -619,8 +618,7 @@ static irqreturn_t dma_irq_handle(int irq, void *dev_id)
>   			vchan_cyclic_callback(&sdesc->vd);
>   		} else {
>   			/* Check if the dma request descriptor is done. */
> -			trans_done = sprd_dma_check_trans_done(sdesc, int_type,
> -							       req_type);
> +			trans_done = sprd_dma_check_trans_done(int_type, req_type);
>   			if (trans_done == true) {
>   				vchan_cookie_complete(&sdesc->vd);
>   				schan->cur_desc = NULL;
