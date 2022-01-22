Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63820496D31
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jan 2022 19:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiAVSFe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jan 2022 13:05:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40544 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiAVSFd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jan 2022 13:05:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C81160E97;
        Sat, 22 Jan 2022 18:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF4AC004E1;
        Sat, 22 Jan 2022 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642874732;
        bh=TPZTXAeqCudQFjGeQRPIDybUI7yE5fBL/PIoEw43+OY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=t4aNQILFCgnBygili/WLh/ycln7jc6Ish9LHpO87IA89UD/lUbBpVyJ4PF+Zt/PVB
         Csv29j7VS2NyAT3LvaSo1jkvbNn37Rr/wCCNrVK21iG3H1lA7IlZYU84N0zM/zDT7w
         BPFtdnZYwpyoEfFC14mgmkv3Pp/7LvPb9lr7zhJzPNsvbT+oG585CNMjbLb4zu4+NF
         Yvdm5m3JRrKZ8dERVzityFF0wWH+rcRbIpTeYsNpOuwn12d95JxgLd99zXGa3Y10z/
         LcN0k1VuFqjr8fVZ9iTJv60lwlC1HDcTBHxXNWvq6Y8KQSJIqsGc+0bnlYfM1yO85p
         cS973ugmC1byA==
Message-ID: <ee43d68f-000c-6513-38f2-877b9018ab22@kernel.org>
Date:   Sat, 22 Jan 2022 13:05:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] dmaengine: qcom_hidma: Remove useless DMA-32 fallback
 configuration
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <4deb32b0c7838da66608022c584326eb01d0da03.1642232106.git.christophe.jaillet@wanadoo.fr>
From:   Sinan Kaya <okaya@kernel.org>
In-Reply-To: <4deb32b0c7838da66608022c584326eb01d0da03.1642232106.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/15/2022 2:35 AM, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 

Can we please document this?

Usual practice was to try allocating 64 bit DMA if possible and fallback
to 32 bits.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: have the subject and updated driver match
> ---
>   drivers/dma/qcom/hidma.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index 65d054bb11aa..51587cf8196b 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -838,9 +838,7 @@ static int hidma_probe(struct platform_device *pdev)
>   	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>   	if (rc) {
>   		dev_warn(&pdev->dev, "unable to set coherent mask to 64");
> -		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -		if (rc)
> -			goto dmafree;
> +		goto dmafree;
>   	}
>   
>   	dmadev->lldev = hidma_ll_init(dmadev->ddev.dev,

