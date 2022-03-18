Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82A4DD7EB
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiCRKaA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiCRKaA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 06:30:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF15938A
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 03:28:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BBADD1F45DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647599319;
        bh=RLh0iGI//uz1ksSyMfYq/kKVW5zQwl6rIk1/V3IyKlI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kgBQV8a2vitxThYInEsApGhTJkbu2ywe5oNv3dQpcWXlMQowFGW2k0rjeuOcL6kmS
         O6ZxllIkYiBARFIi+gW4Zn1ejhluQAVWXRdskhqgRX6m8jJcWVKkr/8hscZ26Uke6B
         cPELa3vvVg9Dz1rR0LlMlR+KrLiSg1iLIXFnAm64kVPOBgVWR3bI5rEXYEZ6QltTHR
         zt3Lpf72rvseN8a+mXeJxU542Zin4zvEYjZMsDPn22Hxm3pfkRI6Bs5SNdmctnJ1TR
         26jbMLjd1mXiLi4Xb3/5hfaAEhI6/0Svtl4A43gP+dIJq4BV73FLPaEdmf1PuxUKpT
         5CApo9pFWCo3A==
Message-ID: <89a49057-50c5-5abe-559a-744447a60774@collabora.com>
Date:   Fri, 18 Mar 2022 11:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH -next] dmaengine: mediatek:Fix PM usage reference leak of
 tegra
Content-Language: en-US
To:     Zhang Qilong <zhangqilong3@huawei.com>, sean.wang@mediatek.com,
        vkoul@kernel.org, matthias.bgg@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220318080809.22562-1-zhangqilong3@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318080809.22562-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Il 18/03/22 09:08, Zhang Qilong ha scritto:
> From: zhangqilong <zhangqilong3@huawei.com>
> 
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> We fix it:
> 1) Replacing it with pm_runtime_resume_and_get to keep usage counter
>     balanced.
> 2) Add putting operation before returning error.
> 
> Fixes:9135408c3ace4 ("dmaengine: mediatek: Add MediaTek UART APDMA support")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Hello Zhang,

I agree with this change, but the commit message is misleading, as this is not
Tegra.

Please fix it.

Regards,
Angelo

> ---
>   drivers/dma/mediatek/mtk-uart-apdma.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
> index 375e7e647df6..a1517ef1f4a0 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -274,7 +274,7 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
>   	unsigned int status;
>   	int ret;
>   
> -	ret = pm_runtime_get_sync(mtkd->ddev.dev);
> +	ret = pm_runtime_resume_and_get(mtkd->ddev.dev);
>   	if (ret < 0) {
>   		pm_runtime_put_noidle(chan->device->dev);
>   		return ret;
> @@ -288,18 +288,21 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
>   	ret = readx_poll_timeout(readl, c->base + VFF_EN,
>   			  status, !status, 10, 100);
>   	if (ret)
> -		return ret;
> +		goto err_pm;
>   
>   	ret = request_irq(c->irq, mtk_uart_apdma_irq_handler,
>   			  IRQF_TRIGGER_NONE, KBUILD_MODNAME, chan);
>   	if (ret < 0) {
>   		dev_err(chan->device->dev, "Can't request dma IRQ\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_pm;
>   	}
>   
>   	if (mtkd->support_33bits)
>   		mtk_uart_apdma_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_CLR_B);
>   
> +err_pm:
> +	pm_runtime_put_noidle(mtkd->ddev.dev);
>   	return ret;
>   }
>   
> 

