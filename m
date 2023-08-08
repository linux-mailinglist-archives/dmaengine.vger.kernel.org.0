Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40447746EE
	for <lists+dmaengine@lfdr.de>; Tue,  8 Aug 2023 21:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjHHTHn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Aug 2023 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjHHTH3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Aug 2023 15:07:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02512D1D9;
        Tue,  8 Aug 2023 09:29:18 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7224E66071F6;
        Tue,  8 Aug 2023 12:45:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691495104;
        bh=TLCXArraVp1GnqEqP+LWsyF5aCVliI9FrcY4g8JDRiE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FZIwYjLSNwUeWjsyZKshC+XGEuO9rzr2fl6CY137AFkL27nbhoX1viX64mcXCBSs9
         VMQuda3NcfX7cJGMIWFEj7VHIoGKrg7ZLOiPIwNtL9w07KH1eqNyJDHAd9aPwrHVDd
         GYstIOuUbIgVi9CmE/Sh5tiHf8+6Isbio8IVF2WRuomdAT8XyMRiuCn8PsRZUa9qfL
         zF7IuvANvKydrM7uktr78aa0dDv3u4/NkSrUUSLSmkgMjCDd0e5/mLATy4XPWcEoTX
         MCsliGpI+8JdKzwaN7GDNQWugpfe/bD5jsnbxayCIx4FNQ37RMQZ0Sy03/BDnn++iV
         8/8z2GvOGvEQg==
Message-ID: <da5d1a11-93d4-3952-9a2b-8313b9206660@collabora.com>
Date:   Tue, 8 Aug 2023 14:45:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dmaengine: mediatek: Fix deadlock caused by
 synchronize_irq()
Content-Language: en-US
To:     Duoming Zhou <duoming@zju.edu.cn>, sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230806032511.45263-1-duoming@zju.edu.cn>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230806032511.45263-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 8/6/23 06:25, Duoming Zhou wrote:
> The synchronize_irq(c->irq) will not return until the IRQ handler
> mtk_uart_apdma_irq_handler() is completed. If the synchronize_irq()
> holds a spin_lock and waits the IRQ handler to complete, but the
> IRQ handler also needs the same spin_lock. The deadlock will happen.
> The process is shown below:
> 
>            cpu0                        cpu1
> mtk_uart_apdma_device_pause() | mtk_uart_apdma_irq_handler()
>    spin_lock_irqsave()         |
>                                |   spin_lock_irqsave()
>    //hold the lock to wait     |
>    synchronize_irq()           |
> 
> This patch reorders the synchronize_irq(c->irq) outside the spin_lock
> in order to mitigate the bug.
> 
> Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/dma/mediatek/mtk-uart-apdma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
> index a1517ef1f4a..0acf6a92a4a 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -451,9 +451,8 @@ static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
>   	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_CLR_B);
>   	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
>   
> -	synchronize_irq(c->irq);
> -
>   	spin_unlock_irqrestore(&c->vc.lock, flags);
> +	synchronize_irq(c->irq);
>   
>   	return 0;
>   }


Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com>
