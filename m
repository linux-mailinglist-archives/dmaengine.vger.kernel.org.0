Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13807A57D8
	for <lists+dmaengine@lfdr.de>; Tue, 19 Sep 2023 05:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjISDX2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Sep 2023 23:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjISDX2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Sep 2023 23:23:28 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72B95;
        Mon, 18 Sep 2023 20:23:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VsPmsoK_1695093793;
Received: from 30.97.48.69(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VsPmsoK_1695093793)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 11:23:14 +0800
Message-ID: <793afbca-187d-c54f-c479-52cfd1975799@linux.alibaba.com>
Date:   Tue, 19 Sep 2023 11:23:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2] dmaengine: sprd: add dma mask interface in probe
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20230919023050.3777-1-kaiwei.liu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230919023050.3777-1-kaiwei.liu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/19/2023 10:30 AM, Kaiwei Liu wrote:
> In the probe of DMA, the default addressing range is 32 bits,
> while the actual DMA hardware addressing range used is 36 bits.
> So add dma_set_mask_and_coherent function to match DMA
> addressing range.
> 
> Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
> ---
> Change in V2:
> -Change subject line.
> -Modify error message to make it more readable.

Have you modified the error message against v1? I did not see it.

https://lore.kernel.org/all/20230807052014.2781-1-kaiwei.liu@unisoc.com/

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
> +			return ret;
> +		}
> +	}
> +
>   	/* Parse new and deprecated dma-channels properties */
>   	ret = device_property_read_u32(&pdev->dev, "dma-channels", &chn_count);
>   	if (ret)
