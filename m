Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22948F5A2
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jan 2022 08:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiAOHa7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Jan 2022 02:30:59 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:52376 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAOHa6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Jan 2022 02:30:58 -0500
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 8dWani9skhTNk8dWbn3h1m; Sat, 15 Jan 2022 08:30:57 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 15 Jan 2022 08:30:57 +0100
X-ME-IP: 90.126.236.122
Message-ID: <835ae5f0-79de-af2b-2837-62448bc9e824@wanadoo.fr>
Date:   Sat, 15 Jan 2022 08:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dmaengine: qcom_hidma: Remove useless DMA-32 fallback
 configuration
Content-Language: fr
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <c4c4eb13d5da283450d675e611d9582e6744dd5c.1642231548.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c4c4eb13d5da283450d675e611d9582e6744dd5c.1642231548.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 15/01/2022 à 08:26, Christophe JAILLET a écrit :
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/dma/ioat/init.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 373b8dac6c9b..5d707ff63554 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1364,8 +1364,6 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return -ENOMEM;
>   
>   	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> -	if (err)
> -		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>   	if (err)
>   		return err;
>   
> 
NACK, wrong driver name in the subject. I'll resend.

CJ
