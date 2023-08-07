Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC0771BC7
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 09:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHGHua (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHGHu3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 03:50:29 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4461700;
        Mon,  7 Aug 2023 00:50:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VpBLPig_1691394619;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpBLPig_1691394619)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 15:50:19 +0800
Message-ID: <19716311-c1c5-2638-05ef-a7c3f74de8fe@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 15:50:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] dma: add dma mask interface in probe
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20230807052014.2781-1-kaiwei.liu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230807052014.2781-1-kaiwei.liu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/7/2023 1:20 PM, Kaiwei Liu wrote:
> In the probe of DMA, the default addressing range is 32 bits,
> while the actual DMA hardware addressing range used is 36 bits.
> So add dma_set_mask_and_coherent function to match DMA
> addressing range.
> 
> Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
> ---
>   drivers/dma/sprd-dma.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 20c3cb1ef2f5..0e146550dfbb 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -1115,6 +1115,15 @@ static int sprd_dma_probe(struct platform_device *pdev)
>   	u32 chn_count;
>   	int ret, i;
>   
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		if (ret) {
> +			dev_err(&pdev->dev, "dma_set_mask_and_coherent failed\n");

The error message is not readable, may be something like below?
"unable to set coherent mask to 32\n"

The changes look good to me. Chunyan and Orson, please double check the 
DMA mask?

> +			return ret;
> +		}
> +	}
> +
>   	/* Parse new and deprecated dma-channels properties */
>   	ret = device_property_read_u32(&pdev->dev, "dma-channels", &chn_count);
>   	if (ret)
